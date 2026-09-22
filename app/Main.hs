{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import System.Exit (die)
import Data.ByteString.Base64 ( decodeBase64 )
import Data.ByteString (writeFile)
import Ws ( aut,solE,ver,TipoSol(CFDI, Metadata),des, solR )
import Data.String (fromString)
import System.Environment (lookupEnv)
import Crypto.Types.PubKey.RSA ( PrivateKey )
import Data.X509 (Certificate)
import Control.Applicative ( Alternative((<|>)) )
import System.Console.ArgParser ( ParserSpec, parsedBy, boolFlag, optFlag, CmdLnInterface(..), mkDefaultApp, mkSubParser, mkDefaultApp, posArgs, reqFlag )
import System.Console.ArgParser.QuickParams (reqPos)
import System.Console.ArgParser.Parser (andBy)
import System.Console.ArgParser.Run (runApp)
import System.Console.ArgParser.Params (Descr(Descr), StdArgParam, MetaVar (MetaVar))
import Sellos (getCert, getNombre, getRfc, getFinVigencia, getTipo, getFiel, getInitVigencia, getNoCert, vigente, validar, getFielCsd, signSHA256)
import System.Directory ( doesFileExist, removeFile, listDirectory, doesDirectoryExist )
import Control.Monad (when, unless)
import GHC.IO.Handle (hDuplicateTo)
import System.IO
import Text.XML.Light ( parseXML,Attr(Attr),unqual,add_attr,ppTopElement,showElement,showTopElement )
import Pdf (buildPdf, getPdfContext, PdfTableContext)
import Internal.Types (Context(cDebug, cPdf, cFields), Field (fXpath, fName, fLabel), TipoDocto (..), Table (tName), tableXmlPath)
import Context
import System.Console.ArgParser (optPos)
import System.FilePath (takeFileName, takeExtension, dropExtension,replaceExtension,(</>))
import System.Console.ArgParser.SubParser (mkSubParserWithName)
import Time (parsePeriod)
import Data.Maybe (fromMaybe, fromJust, catMaybes, isNothing, isJust)
import Fields (xmlFields, onList, isLabel)
import Xml (getVersion, path', xpath, getTipo, cfdiValido, path, getElems, xpath')
import Data.List (isSuffixOf,isPrefixOf,intercalate)
import Data.Text  (pack,unpack)
import Codec.Archive.Zip (withArchive, getEntries, getEntry, createArchive, mkEntrySelector, addEntry, CompressionMethod (..))
import Codec.Archive.Zip.Internal.Type (getEntryName)
import Data.ByteString.UTF8 (toString)
import Control.Monad.IO.Class (liftIO)
import Data.Map (toList)
import qualified Data.ByteString.Lazy as B
import Internal.Types (TipoDocto(X), Context (cTables), Table (tableFields))
import Control.Exception (catch)
import GHC.Exception (SomeException)
import DefaultData (cliFields)
import Text.XML.Light.Proc (onlyElems)
import Text.XML.HXT.Arrow.XmlArrow (ArrowXml(addAttr))
import Text.XML.Light.Output (ppElement)
import CFDI (cadena40)
import qualified Data.ByteString.Lazy.Char8 as LBS8


data MyArgs =  -- First, we need a datatype
  MyArgs {argCmd :: String, argKey :: String, argCer :: String, argPass :: String, argId :: String, argInicio :: String, argFin :: String, argPeriodo :: String} |
  CmdAut {argKey :: String, argCer :: String, argPass :: String} |
  CmdVal {argKey :: String, argCer :: String, argPass :: String} |
  CmdSellar {argKey :: String, argCer :: String, argPass :: String, argPath :: [String]} |
  CmdVer {argKey :: String, argCer :: String, argPass :: String, argId :: String} |
  CmdDes {argKey :: String, argCer :: String, argPass :: String, argId :: String} |
  CmdSolE {argKey :: String, argCer :: String, argPass :: String, argInicio :: String, argFin :: String, argMeta :: Bool, argPeriodo::String} |
  CmdSolR {argKey :: String, argCer :: String, argPass :: String, argInicio :: String, argFin :: String, argMeta :: Bool, argPeriodo::String} |
  CmdCertInfo {argCer :: String} |
  CmdPdf {argPath :: [String], argDebug :: Bool} |
  CmdCsv {argReport::String,argPath :: [String], argDebug :: Bool} |
  CmdWeb {argCer :: String, fileLog :: Bool, autoOpen :: Bool} |
  CmdStart {argCer :: String, fileLog :: Bool}
  deriving (Show) -- we will print the values


cFlag = optFlag "" "c" `Descr` "Ruta archivo cer | $HCFDI_CER" `MetaVar` "RUTA"
kFlag = optFlag "" "k" `Descr` "Ruta archivo key | $HCFDI_KEY" `MetaVar` "RUTA"
pFlag = optFlag "" "p" `Descr` "Contraseña | $HCFDI_PASS" `MetaVar` "PASS"
idFlag = reqFlag "I" `Descr` "ID de solicitud/descarga SAT" `MetaVar` "UUID"
startFlag = optFlag "" "i" `Descr` "Fecha inicio 2024-01-01T00:00:00"
endFlag = optFlag "" "f" `Descr` "Fecha fin 2024-12-31T23:59:59"
periodoFlag = optFlag "" "P" `Descr` "Periodo: hoy|mes|año"
rutaFlag = posArgs "ruta" [] (\a v -> v:a) `Descr` "Ruta | stdin"

myParser :: IO (CmdLnInterface MyArgs)
myParser = mkSubParser
  [ ("pdf", (mkDefaultApp
    (CmdPdf `parsedBy` rutaFlag `andBy` (boolFlag "d" `Descr` "Debug")) "pdf"){getAppDescr=Just "Genera PDFs"})
  , ("csv", (mkDefaultApp
    (CmdCsv `parsedBy` reqPos "rep"  `Descr` "Reporte: general|partidas|pagos|nomina" `andBy`  rutaFlag `andBy` (boolFlag "d" `Descr` "Debug")) "csv"){getAppDescr=Just "Genera csv/excel"})
  -- , ("validar", (mkDefaultApp
  --   (CmdCsv `parsedBy` posArgs "ruta" [] (\a v -> v:a) `Descr` "Ruta | stdin" `andBy` (boolFlag "d" `Descr` "Debug")) "validar"){getAppDescr=Just "Valida archivos XML"})
  , ("ws", (mkSubParserWithName "ws" [
      ("aut", (mkDefaultApp (CmdAut `parsedBy` kFlag `andBy` cFlag `andBy` pFlag) "aut"){getAppDescr=Just "Autentifica con el SAT"})
      ,("des", (mkDefaultApp (CmdDes `parsedBy` kFlag `andBy` cFlag `andBy` pFlag `andBy` idFlag) "des"){getAppDescr=Just "Descarga un ID de solicitud"})
      ,("ver", (mkDefaultApp (CmdVer `parsedBy` kFlag `andBy` cFlag `andBy` pFlag `andBy` idFlag) "ver"){getAppDescr=Just "Verifica un ID de solicitud"})
      ,("solE", (mkDefaultApp (CmdSolE `parsedBy` kFlag `andBy` cFlag `andBy` pFlag  `andBy` startFlag `andBy` endFlag`andBy` (boolFlag "m" `Descr` "Metadata") `andBy` periodoFlag) "solE"){getAppDescr=Just "Solicita un periodo al SAT"})
      ,("solR", (mkDefaultApp (CmdSolR `parsedBy` kFlag `andBy` cFlag `andBy` pFlag  `andBy` startFlag `andBy` endFlag `andBy` (boolFlag "m" `Descr` "Metadata") `andBy` periodoFlag) "solR"){getAppDescr=Just "Solicita un periodo al SAT"})
      ]){getAppDescr=Just "Servicios WebService del SAT"}
    )
    , ("csd", (mkSubParserWithName "csd" [
      ("val", (mkDefaultApp (CmdVal `parsedBy` kFlag `andBy` cFlag `andBy` pFlag) "val"){getAppDescr=Just "Validar CSD|FIEL"})
      ,("sellar", (mkDefaultApp (CmdSellar `parsedBy` kFlag `andBy` cFlag `andBy` pFlag `andBy` rutaFlag) "sellar"){getAppDescr=Just "Sella un XML"})
      ,("info", (mkDefaultApp (CmdCertInfo `parsedBy` cFlag) "info"){getAppDescr=Just "Informacion de certificado"})
      ]){getAppDescr=Just "Validacion de CSD y FIEL"}
    )
  ]


loadCert :: MyArgs -> IO Data.X509.Certificate
loadCert args = do
  envPath <- lookupEnv "HCFDI_CER"
  let argPath = argCer args
      path = (if null argPath then Nothing else Just argPath) <|> envPath
  case path of
    Nothing -> die "Debe especificar un certificado -c | HCFDI_CER"
    Just certPath -> do
      cert' <- getCert certPath
      case cert' of
        Nothing -> die "Certificado invalido"
        Just cert -> return cert
loadFielCsd :: MyArgs -> IO (PrivateKey,Data.X509.Certificate,String)
loadFielCsd args = do
  envKeyPath <- lookupEnv "HCFDI_KEY"
  envCerPath <- lookupEnv "HCFDI_CER"
  envPass <- lookupEnv "HCFDI_PASS"
  let argKeyPath = argKey args
      argCerPath = argCer args
      argPass' = argPass args
      keyPath' = (if null argKeyPath then Nothing else Just argKeyPath) <|> envKeyPath
      cerPath' = (if null argCerPath then Nothing else Just argCerPath) <|> envCerPath
      pass' = (if null argPass' then Nothing else Just argPass') <|> envPass
  case pass' of
    Nothing -> die "Debe especificar una Contraseña -p | HCFDI_PASS"
    Just pass -> do
      case keyPath' of
        Nothing -> die "Debe especificar una llave privada -k | HCFDI_KEY"
        Just keyPath -> do
          case cerPath' of
            Nothing -> die "Debe especificar un certificado -c | HCFDI_CER"
            Just cerPath -> do
              fiel' <- getFielCsd keyPath cerPath pass
              case fiel' of
                Left msg -> die msg
                Right fiel -> return fiel
loadFiel :: MyArgs -> IO (PrivateKey,Data.X509.Certificate,String)
loadFiel args = do
  envKeyPath <- lookupEnv "HCFDI_KEY"
  envCerPath <- lookupEnv "HCFDI_CER"
  envPass <- lookupEnv "HCFDI_PASS"
  let argKeyPath = argKey args
      argCerPath = argCer args
      argPass' = argPass args
      keyPath' = (if null argKeyPath then Nothing else Just argKeyPath) <|> envKeyPath
      cerPath' = (if null argCerPath then Nothing else Just argCerPath) <|> envCerPath
      pass' = (if null argPass' then Nothing else Just argPass') <|> envPass
  case pass' of
    Nothing -> die "Debe especificar una Contraseña -p | HCFDI_PASS"
    Just pass -> do
      case keyPath' of
        Nothing -> die "Debe especificar una llave privada -k | HCFDI_KEY"
        Just keyPath -> do
          case cerPath' of
            Nothing -> die "Debe especificar un certificado -c | HCFDI_CER"
            Just cerPath -> do
              fiel' <- getFiel keyPath cerPath pass
              case fiel' of
                Left msg -> die msg
                Right fiel -> return fiel

getToken :: PrivateKey -> String -> IO String
getToken key b64 = do
  token' <- aut key b64
  case token' of
    Left msg -> die ("Error: " ++ msg)
    Right token -> return token


--TODO: Procesar zips
crearPDFs :: [String] -> Context -> PdfTableContext -> IO ()
crearPDFs [] _ _ = return ()
crearPDFs (path:pathRest) ctx ptCtx = do
  isDirectory <- doesDirectoryExist path
  if isDirectory then do
    subPaths <- listDirectory path
    crearPDFs (map (path</>) subPaths) ctx ptCtx
    crearPDFs pathRest ctx ptCtx
  else do
    case takeExtension path of
      ext | ext==".xml" || ext==".XML" -> do
        xmlData <- readFile path
        let xml = parseXML xmlData
        if (not.cfdiValido) xml then do
          hPutStrLn stderr (path ++" XML invalido")
          return Nothing
        else
          buildPdf ctx ptCtx (Just  (replaceExtension path ".pdf")) $ parseXML xmlData
      ext | ext==".zip" || ext==".ZIP" -> do
        maybeFiles <- withArchive path $ do
            entries <- getEntries
            mapM (\(e,_) -> do
                entry <- getEntry e
                if "xml" `isSuffixOf` unpack (getEntryName e) || "XML" `isSuffixOf` unpack (getEntryName e) then do
                    let xml = parseXML (toString entry)
                    if cfdiValido xml then do
                      pdfData <- liftIO $ buildPdf ctx ptCtx Nothing xml
                      if isNothing pdfData then
                        return Nothing
                      else
                        return $ Just ((replaceExtension $ unpack (getEntryName e)) ".pdf",fromJust pdfData)
                    else do
                      liftIO $ hPutStrLn stderr (show e ++" XML invalido")
                      return Nothing
                else do
                    return Nothing
                ) (toList entries)
        let files = catMaybes maybeFiles
            zipFileName = dropExtension path ++ "_PDFS.zip"
        createArchive zipFileName $ do
            mapM_ (\(name,pdfData) -> do
                textSelector <- mkEntrySelector name
                addEntry Deflate (B.toStrict pdfData) textSelector
                ) files
        return Nothing
      _ -> return Nothing
    crearPDFs pathRest ctx ptCtx

crearCSVs :: [String] -> [Field] -> Maybe Table -> Context -> [[String]] -> IO [[String]]
crearCSVs [] _ _ _ result = return result
crearCSVs (path:pathRest) fields table ctx result = do
  isDirectory <- doesDirectoryExist path
  if isDirectory then do
    subPaths <- listDirectory path
    localData <- crearCSVs (map (path</>) subPaths) fields table ctx []
    crearCSVs pathRest fields table ctx (localData++result)
  else do
    rows <- case takeExtension path of
      ext | ext==".xml" || ext==".XML" -> do
        xmlData <- readFile path --`catch` (\(e::SomeException) -> return "")
        let xml = parseXML xmlData
        if (not.cfdiValido) xml then do
          hPutStrLn stderr (path ++" XML invalido")
          return [[]]
        else do
          let mainRow = csvRow xml
              tabRows = tableRows xml $ fromJust table
          --return [csvRow xml]
          return $ if isNothing table then [csvRow xml] else map (mainRow++) tabRows
      ext | ext==".zip" || ext==".ZIP" -> do
        maybeFiles <- withArchive path $ do
            entries <- getEntries
            mapM (\(e,_) -> do
                entry <- getEntry e
                let xml = parseXML (toString entry)
                if ("xml" `isSuffixOf` unpack (getEntryName e) || "XML" `isSuffixOf` unpack (getEntryName e)) then do
                    if cfdiValido xml then do
                      let mainRow = csvRow xml
                          tabRows = tableRows xml $ fromJust table
                      return $ if isNothing table then Just [csvRow xml] else Just $ map (mainRow++) tabRows
                    else do
                      liftIO $ hPutStrLn stderr (show e++" XML invalido")
                      return Nothing
                else
                    return Nothing
                ) (toList entries)
        return $ concat $ catMaybes maybeFiles
      _ -> return []
    crearCSVs pathRest fields table ctx (rows++result)
    where csvRow xml = if getVersion xml == "0" && Xml.getTipo xml == Just "X" then [] else
                          map (fromMaybe "" . xpath xml . Xml.path' (getVersion xml) . fXpath) fields
          tableRows xml table = do
            let elems = getElems xml $ Xml.path $ tableXmlPath table
            map (\e -> do
              "|":map (\f -> do
                  let ((_,x):xs) = fXpath f
                  if isPrefixOf "/Comprobante" x then
                      fromMaybe "" $ (xpath xml . Xml.path' version . fXpath) f
                  else
                      fromMaybe "" $ (xpath' e . Xml.path' version . fXpath) f
                ) fieldsNoLabels
              ) elems
            where fieldsNoLabels = filter (not . isLabel) (tableFields table)
                  version = getVersion xml


main :: IO ()
main = do
  interface <- myParser
  runApp (interface{getAppVersion=Just "0.1.0"}) doCmd


doCmd :: MyArgs -> IO ()
doCmd args@CmdCertInfo{} = do
  cert <- loadCert args
  putStrLn $ getNoCert cert
  putStrLn $ getNombre cert
  putStrLn $ getRfc cert
  putStr $ getInitVigencia cert ++ " - "
  putStrLn $ getFinVigencia cert
  putStrLn $ Sellos.getTipo cert
doCmd args@CmdVal{} = do
  (key,cer,b64) <- loadFielCsd args
  v <- vigente cer
  let v' = validar key cer
  unless v $ die "Vencido"
  unless v' $ die "Pareja incorrecta"
  putStrLn "OK"
doCmd args@CmdSellar{argPath=(path:rest)} = do
  (key,cer,b64) <- loadFielCsd args
  v <- vigente cer
  let v' = validar key cer
  unless v $ die "Vencido"
  unless v' $ die "Pareja incorrecta"
  input <- getContents
  xmlData <- if argPath args == ["stdin"] then
                getContents
             else
                case takeExtension path of
                  ext | ext==".xml" || ext==".XML" -> do
                    readFile path
                  _ -> die "El archivo no es un XML"
  let xml = parseXML xmlData
  cadena <- cadena40 $ showTopElement $ add_attr (Attr (unqual "NoCertificado") (getNoCert cer)) $ add_attr (Attr (unqual "Certificado") b64) $ onlyElems xml !! 1
  let sello = LBS8.unpack $ signSHA256 key $ LBS8.pack cadena
  putStrLn $ showTopElement $ add_attr (Attr (unqual "Sello") sello) $ add_attr (Attr (unqual "NoCertificado") (getNoCert cer)) $ add_attr (Attr (unqual "Certificado") b64) $ onlyElems xml !! 1
doCmd args@CmdPdf{argDebug=d} = do
  ctx <- getContext
  ptCtx <- getPdfContext
  input <- getContents
  if argPath args == ["stdin"] then
    crearPDFs (lines input) ctx{cDebug=d} ptCtx
  else
    crearPDFs (argPath args) ctx{cDebug=d} ptCtx
doCmd args@CmdCsv{argDebug=d,argReport=reporte} = do
  ctx <- getContext
  let fields =  xmlFields cliFields
      table' = filter ((reporte==) . tName) $ cTables ctx
      table
        | (not.null) table' = Just $ head table'
        | otherwise = Nothing
      headers= "\"" ++ intercalate "\",\"" (map fLabel fields) ++ "\"" ++ if isJust table then ",\"|\",\"" ++ intercalate "\",\"" (map fLabel (tableFields $ fromJust table)) ++ "\"" else ""
  when (reporte /= "general" && isNothing table)$ die "Reporte desconocido"
  input <- getContents
  cfdis <- if argPath args == ["stdin"] then
    crearCSVs (lines input) fields table ctx{cDebug=d} []
  else
    crearCSVs (argPath args) fields table ctx{cDebug=d} []
  let csv = unlines (map (\values -> "\"" ++ intercalate "\",\"" values ++ "\"") (filter (not.null) cfdis))
  putStrLn (headers++"\n"++csv)
doCmd args@CmdVer{argId=idSol} = do
  if null idSol then die "Debe indicar un ID -I" else do
    (key,cer,b64) <- loadFiel args
    token <- getToken key b64
    v <- ver idSol key b64 (getRfc cer) token
    case v of
      Left (status,msg) -> die (show status ++ " - " ++ msg)
      Right (totalCfdis, ids) -> mapM_ putStrLn ids
doCmd args@CmdAut{} = do
  (key,cer,b64) <- loadFiel args
  token <- getToken key b64
  putStrLn token
doCmd args@CmdSolE{argInicio=inicio,argFin=fin,argMeta=meta,argPeriodo=periodo} = do
  (key,cer,b64) <- loadFiel args
  token <- getToken key b64
  periodo <- parsePeriod periodo
  let (pInicio,pFin) = fromMaybe ("", "") periodo
      fechaInicio = if null periodo then inicio else pInicio
      fechaFin = if null periodo then fin else pFin
  when (null fechaInicio || null fechaFin) $ die "Debe ingresar un -P valido o -i y -f"
  v <- solE (if meta then Metadata else CFDI) fechaInicio fechaFin key b64 (getRfc cer) token
  case v of
    Left msg -> die msg
    Right id' -> putStrLn id'
doCmd args@CmdSolR{argInicio=inicio,argFin=fin,argMeta=meta,argPeriodo=periodo} = do
  (key,cer,b64) <- loadFiel args
  token <- getToken key b64
  periodo <- parsePeriod periodo
  let (pInicio,pFin) = fromMaybe ("", "") periodo
      fechaInicio = if null periodo then inicio else pInicio
      fechaFin = if null periodo then fin else pFin
  when (null fechaInicio || null fechaFin) $ die "Debe ingresar un -P valido o -i y -f"
  v <- solR (if meta then Metadata else CFDI) fechaInicio fechaFin key b64 (getRfc cer) token
  case v of
    Left msg -> die msg
    Right id' -> putStrLn id'
doCmd args@CmdDes{argId=idDes} = do
  if null idDes then die "Debe indicar un ID -I" else do
    (key,cer,b64) <- loadFiel args
    token <- getToken key b64
    r <- des idDes key b64 (getRfc cer) token
    case r of
      Left msg -> die msg
      Right s -> case decodeBase64 $ fromString s of
        Left _ -> die "Error al convertir Base64"
        Right bytes -> Data.ByteString.writeFile (idDes++".zip") bytes
doCmd _ = die "Error: Comando desconocido"