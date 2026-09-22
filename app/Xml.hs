{-# LANGUAGE OverloadedStrings #-}


module Xml (xpath',xpath,path,getUuid,getSmartPath,esPago,getPagos,getPartidas,getElems,getTipo,path',
getVersion,getFechaPeriodo,getRfcEmisor,getRfcReceptor,getFullFolio,getTotal,getSello,cfdiValido) where

import Text.XML.Light.Types ( Element )
import Text.XML.Light ( QName(qName, QName, qURI, qPrefix), Element(elName), findAttrBy, strContent, filterChildren, onlyElems, Content, findElements )
import Data.List.Split (splitOn)
import Text.Read (readMaybe)
import Data.Char (toUpper)
import Data.Maybe (fromMaybe, isJust, fromJust)
import Data.List (find)
import Text.XML.Light.Input (parseXML)


test = do
  f <- readFile "/tmp/xml.xml"
  let xml = parseXML f
      p = path "/Comprobante/Impuestos/Traslados/Traslado[Impuesto=002&&TipoFactor=\"Exento\"]/@Base"
  print $ xpath xml p

data Path = Const String | Att String | Elem String ElemFilter deriving (Show,Eq)
data ElemFilter = None | Index Int | Equal [(String,String)] deriving (Show,Eq)

path :: String -> [Path]
path [] = []
path ('/':p) = map pathE (splitOn "/" p)
path p = [Const p]

path' :: String -> [([String],String)] -> [Path]
path' version arr = path path_
  where (_,path_) = fromMaybe ([],"") $ find (\(versiones,_) -> version `elem` versiones) arr

-- | Parse path elements
pathE :: String -> Path
pathE ('@':x) = Att x
pathE x
  | length split == 1 = Elem x None
  | otherwise = Elem name $ parseFilt $ splitOn "&&" filts
  where split = splitOn "[" x
        name = head split
        filts = if length split > 1 then init (last split) else ""

        parseFilt :: [String] -> ElemFilter
        parseFilt [] = None
        parseFilt f 
          | length f == 1 = case index of
              Just i -> Index i
              _ -> Equal $ parseFilts f
          | otherwise =  Equal $ parseFilts f
          where index = readMaybe (head f) :: Maybe Int

        parseFilts :: [String] -> [(String,String)]
        parseFilts [] = []
        parseFilts (f:xs) = (head equalParts,last equalParts):parseFilts xs
          where equalParts = splitOn "=" f
xpath :: [Content] -> [Path] -> Maybe String
xpath c p = if p == path "/Comprobante/Complemento/TimbreFiscalDigital/@UUID" then
    case xpathE (onlyElems c) p of
      Nothing -> Nothing
      Just result -> Just $ map toUpper result
  else
    xpathE (onlyElems c) p

xpathE :: [Element] -> [Path] -> Maybe String
xpathE _ [] = Nothing
xpathE _ (Att _:_) = Nothing
xpathE _ (Const c:_) = Just c
xpathE e (Elem x _:xs)
  | null elems = Nothing
  | otherwise = xpath' (head elems) xs
  where elems = filter (\e' -> (qName . elName) e' == x) e

xpath' :: Element -> [Path] -> Maybe String
xpath' e [] = Just $ strContent e
xpath' _ (Const c:_) = Just c
xpath' e ((Att x): _) = findAttrBy (\e' -> qName e' == x) e
xpath' e (Elem name filt:xs)
  |  null elems = Nothing
  |  otherwise = case filt of
                  None -> xpath' (head elems) xs
                  Index x -> if x < length elems then
                      xpath' (elems!!x) xs
                    else
                      Nothing
                  Equal conditions -> case applyFilters elems conditions of
                    Nothing -> Nothing
                    Just e' -> xpath' e' xs
  where elems = filterChildren (\e' -> (qName . elName) e' == name) e


getElems :: [Content] -> [Path] -> [Element]
getElems c = getElemsE (onlyElems c)

getElemsE :: [Element] -> [Path] -> [Element]
getElemsE _ [] = []
getElemsE _ (Att _:_) = []
getElemsE _ (Const _:_) = []
getElemsE e (Elem x _:xs)
  | null elems = []
  | otherwise = getElems' (head elems) xs
  where elems = filter (\e' -> (qName . elName) e' == x) e

getElems' :: Element -> [Path] -> [Element]
getElems' _ [] = []
getElems' _ ((Att _): _) = []
getElems' _ ((Const _): _) = []
getElems' e [Elem name _] = filterChildren (\e' -> (qName . elName) e' == name) e -- Falta tomar en cuenta filt
getElems' e (Elem name filt:xs)
  |  null elems = []
  |  otherwise = case filt of
                  None -> getElems' (head elems) xs
                  Index x -> if x < length elems then
                      getElems' (elems!!x) xs
                    else
                      []
                  Equal conditions -> case applyFilters elems conditions of
                    Nothing -> []
                    Just e' -> getElems' e' xs
  where elems = filterChildren (\e' -> (qName . elName) e' == name) e


applyFilters :: [Element] -> [(String,String)] -> Maybe Element
applyFilters [] _ = Nothing
applyFilters (x:xs') conditions = if allTrue results then Just x else applyFilters xs' conditions
  where results = map (testCondition x) conditions
        testCondition :: Element -> (String,String) -> Bool
        testCondition elem' (att,val)
          | head val == '\"' = findAttrBy (\x' -> qName x' == att) elem' == Just (init $ tail val)
          | otherwise = readMaybe (fromMaybe "0" (findAttrBy (\x' -> qName x' == att) elem')) == (readMaybe ("0"++val) :: Maybe Double) -- "0"++val ya que hay unos xml con .16 y eso genera error en read
        allTrue (v:xs) = v && allTrue xs
        allTrue _ = True

-- applyFilter :: [Element] -> String -> String -> Maybe Element
-- applyFilter [] _ _ = Nothing
-- applyFilter (x:xs') att val = if findAttrBy (\x' -> qName x' == att) x == Just val then Just x else applyFilter xs' att val

esPago :: [Content] -> Bool
esPago xml = case getTipo xml of
          Nothing -> False
          Just tipo -> tipo == "P"


getDateParts :: [Content] -> (String,String,String)
getDateParts e = case getFecha e of
  Nothing -> ("00","00","00")
  Just date -> do
    let ymd = head (splitOn "T" date)
    (head (splitOn "-" ymd),splitOn "-" ymd !! 1,splitOn "-" ymd !! 2)

getSmartPath :: String -> [Content] -> String
getSmartPath base xml = base ++ "/" ++ y ++ "/" ++ m
  where (y,m,_) = getDateParts xml

getUuid :: [Content] -> Maybe String
getUuid e = xpath e (path "/Comprobante/Complemento/TimbreFiscalDigital/@UUID")

getSello :: [Content] -> Maybe String
getSello e = if isJust v4 then v4 else v3
  where v4 = xpath e (path "/Comprobante/Complemento/TimbreFiscalDigital/@SelloCFD")
        v3 = xpath e (path "/Comprobante/Complemento/TimbreFiscalDigital/@selloCFD")

getFecha :: [Content] -> Maybe String
getFecha e = if isJust v4 then v4 else v3
  where v4 = xpath e (path "/Comprobante/@Fecha")
        v3 = xpath e (path "/Comprobante/@fecha")

getFullFolio :: [Content] -> String
getFullFolio e = if isJust v4Folio then fromMaybe "" v4Serie ++ fromMaybe "" v4Folio  else fromMaybe "" v3Serie ++ fromMaybe "" v3Folio
  where v4Serie = xpath e (path "/Comprobante/@Serie")
        v4Folio = xpath e (path "/Comprobante/@Folio")
        v3Serie = xpath e (path "/Comprobante/@serie")
        v3Folio = xpath e (path "/Comprobante/@folio")

getFechaPago :: [Content] -> Maybe String
getFechaPago e = if isJust v4 then v4 else v3
  where v4 = xpath e (path "/Comprobante/Complemento/Pagos/Pago/@FechaPago")
        v3 = xpath e (path "/Comprobante/Complemento/Pagos/Pago/@fechaPago")

getFechaNomina :: [Content] -> Maybe String
getFechaNomina e = if isJust v4 then v4 else v3
  where v4 = xpath e (path "/Comprobante/Complemento/Nomina/@FechaPago")
        v3 = xpath e (path "/Comprobante/Complemento/Nomina/@fechaPago")

getFechaPeriodo :: [Content] -> Maybe String
getFechaPeriodo e = case getTipo e of
  Just "P" -> getFechaPago e
  Just "N" -> getFechaNomina e
  _ -> getFecha e

getTipo :: [Content] -> Maybe String
getTipo e = if isJust v4 then v4 else Just [(toUpper . head) (fromMaybe "X" v3)]
  where v4 = xpath e (path "/Comprobante/@TipoDeComprobante")
        v3 = xpath e (path "/Comprobante/@tipoDeComprobante")

getVersion :: [Content] -> String
getVersion e
  | isJust v4 = fromJust v4
  | isJust v3 = fromJust v3
  | otherwise = "0"
  where
      v4 = xpath e (path "/Comprobante/@Version")
      v3 = xpath e (path "/Comprobante/@version")

getTotal :: [Content] -> String
getTotal e
  | isJust v4 = fromJust v4
  | isJust v3 = fromJust v3
  | otherwise = "0"
  where
      v4 = xpath e (path "/Comprobante/@Total")
      v3 = xpath e (path "/Comprobante/@total")


cfdiValido :: [Content] -> Bool
cfdiValido xml = not $ getVersion xml == "0" && getTipo xml == Just "X" 

getRfcEmisor :: [Content] -> Maybe String
getRfcEmisor e = if isJust v4 then v4 else v3
  where v4 = xpath e (path "/Comprobante/Emisor/@Rfc")
        v3 = xpath e (path "/Comprobante/Emisor/@rfc")
getRfcReceptor :: [Content] -> Maybe String
getRfcReceptor e = if isJust v4 then v4 else v3
  where v4 = xpath e (path "/Comprobante/Receptor/@Rfc")
        v3 = xpath e (path "/Comprobante/Receptor/@rfc")

--Esta funcion no trabaja con Pagos < 2.0
getPagos :: [Content] -> [Element]
getPagos c = findElements (QName {qName = "DoctoRelacionado", qURI = Just "http://www.sat.gob.mx/Pagos20", qPrefix = Just "pago20"}) (last (onlyElems c))

getPartidas :: [Content] -> [Element]
getPartidas c = findElements (QName {qName = "Concepto", qURI = Just "http://www.sat.gob.mx/cfd/4", qPrefix = Just "cfdi"}) (last (onlyElems c))