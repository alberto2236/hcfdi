{-# LANGUAGE ScopedTypeVariables #-}
module Context where



import Fields
import Internal.Types
import DefaultData
import System.Directory (copyFile,doesFileExist,removeFile)
import Data.List ( intercalate, find )
import Data.Maybe (fromMaybe)
import Text.Read (readMaybe)
import Control.Exception (SomeException, catch)
import Data.List.Split (splitOn)




parseConfig :: IO [(String,String)]
parseConfig = do
  areConfig <- doesFileExist "config"
  if areConfig then do
    content <- readFile "config"
    let lines' = filter (\l -> '=' `elem` l) $ lines content
        splited = map (splitOn "=") lines'
    return $ map (\item -> (head item,last item)) splited
  else
    return []

getConfVal :: [(String,String)] -> String -> Maybe String
getConfVal conf var = let finded = filter (\(n,_) -> n==var) conf
        in if null conf || null finded then Nothing else Just $ snd $ head finded


getConfBuildPdf :: [(String,String)] -> ContextPDF
getConfBuildPdf conf = case getConfVal conf "buildPdf" of
                        Just "False" -> NonePDF
                        Just val -> fromMaybe FullPDF (readMaybe val)
                        _ -> FullPDF


getReports' :: IO [Report]
getReports' = do
  exists <- doesFileExist "reports"
  repts <- if exists then readFile "reports" else return ""
  return $ if exists then map read (filter (not . null) (lines repts)) else []
getReports :: IO [Report]
getReports = do
  exists <- doesFileExist "reports"
  repts <- if exists then readFile "reports" else return ""
  return $ defaultReports ++ if exists then map read (filter (not . null) (lines repts)) else []
getFields' :: IO [Field]
getFields' = do
  exists <- doesFileExist "fields"
  fields' <- if exists then readFile "fields" else return ""
  return $ defaultFields ++ if exists then map read (filter (not . null) (lines fields')) else []
getFields :: IO [Field]
getFields = do
  exists <- doesFileExist "fields"
  fields' <- if exists then readFile "fields" else return ""
  return $ specialFields ++ defaultFields ++ if exists then map read (filter (not . null) (lines fields')) else []
getTotalFields :: IO [Field]
getTotalFields = do
  exists <- doesFileExist "totalFields"
  fields' <- if exists then readFile "totalFields" else return ""
  return $ if exists then map read (filter (not . null) (lines fields')) else []


getTables' :: IO [Table]
getTables' = do
  exists <- doesFileExist "tables"
  tables' <- if exists then readFile "tables" else return ""
  return $ if exists then read tables' else []
getTables :: IO [Table]
getTables = do
  exists <- doesFileExist "tables"
  tables' <- if exists then readFile "tables" else return ""
  return $ defaultTables ++ if exists then read tables' else []


getContext :: IO Context
getContext = do
  conf <- parseConfig
  fields <- getFields
  tables <- getTables
  return $ Context { cDebug = False, cFields = fields, cTables = tables, cClavesSAT = clavesSat, cPdf = (getConfBuildPdf conf), cDb = (fromMaybe True $ getConfVal conf "buildDb" >>= readMaybe) }

findInBl :: [(Integer,String)] -> String -> Integer
findInBl bl rfc = case find (\(id,blRfc) -> blRfc==rfc) bl of
                    Nothing -> 0
                    Just (id',_) -> id'

onBlackList :: [(Integer,String)] -> Maybe String -> Maybe String -> Integer
onBlackList bl (Just rfc1) (Just rfc2) = let onBl1 = findInBl bl rfc1
                                             onBl2 = findInBl bl rfc2
                                        in if onBl1>0 then onBl1 else onBl2
onBlackList bl Nothing (Just rfc2) = findInBl bl rfc2
onBlackList bl (Just rfc1) Nothing = findInBl bl rfc1
onBlackList _ _ _ = 0



rmFields :: [String] -> IO ()
rmFields strFields = do
  ctx <- getContext
  let filteredFields = filter (not . (`elem` strFields) . fName) (rmSpecialFields (cFields ctx))
      newFields = map show filteredFields
  writeFile "tmp" $ unlines newFields
  copyFile "tmp" "fields"
  removeFile "tmp"


rmTables :: [String] -> IO ()
rmTables strTables = do
  ctx <- getContext
  let filteredTables = filter (not . (`elem` strTables) . tName) (cTables ctx)
      newTables = show filteredTables
  writeFile "tmp" newTables
  copyFile "tmp" "tables"
  removeFile "tmp"

addReports :: [String] -> IO ()
addReports strReports = do
  reports <- getReports'
  let reportsToAdd = map read strReports :: [Report]
      filteredReports = filter (not . (`elem` reportsToAdd)) reports
      newReports = map show $ filteredReports ++ reportsToAdd
  writeFile "tmpR" $ unlines newReports
  copyFile "tmpR" "reports"
  removeFile "tmpR"

rmReports :: [String] -> IO ()
rmReports strReports = do
  reports <- getReports'
  let filteredReports = filter (not . (`elem` strReports) . rName) reports
      newReports = map show filteredReports
  writeFile "tmp" $ unlines newReports
  copyFile "tmp" "reports"
  removeFile "tmp"

addTotals :: [String] -> IO ()
addTotals newQuerys = do
  qerys <- readFile "totals.sql"
  let filteredQuerys = filter (not . (`elem` newQuerys)) (read qerys)
      newFile = filteredQuerys ++ newQuerys
  writeFile "tmpQ" $ show newFile
  copyFile "tmpQ" "totals.sql"
  removeFile "tmpQ"

-- rmTotals :: [String] -> IO ()
-- rmTotals strQuerys = do
--   qerys <- readFile "totals.sql"
--   let filteredQuerys = filter (not . (`elem` strQuerys)) (read qerys)
--   writeFile "tmp" $ show filteredQuerys
--   copyFile "tmp" "totals.sql"
--   removeFile "tmp"

viewsEmpresa :: [String] -> IO ()
viewsEmpresa newQuerys = do
  existFile <- doesFileExist "viewsEmpresa.sql"
  qerys <-  if existFile then readFile "viewsEmpresa.sql" else return "[]"
  let filteredQuerys = filter (not . (`elem` newQuerys)) (read qerys)
      newFile = filteredQuerys ++ newQuerys
  writeFile "tmpQ" $ show newFile
  copyFile "tmpQ" "viewsEmpresa.sql"
  removeFile "tmpQ"

-- rmViewsRfc :: [String] -> IO ()
-- rmViewsRfc strQuerys = do
--   existFile <- doesFileExist "viewsEmpresa.sql"
--   when existFile $ do
--     qerys <- readFile "viewsEmpresa.sql"
--     let filteredQuerys = filter (not . (`elem` strQuerys)) (read qerys)
--     writeFile "tmp" $ show filteredQuerys
--     copyFile "tmp" "viewsEmpresa.sql"
--     removeFile "tmp"





totalsQuery :: IO [String]
totalsQuery = do
  userTotalFields <- getTotalFields
  let allTotalFields = userTotalFields ++ defaultTotalFields
  return [
    "UPDATE totalesPagos LEFT JOIN cfdis ON totalesPagos.idFactura=cfdis.id SET cfdis.importePagado=totalesPagos.totalPagado",
    "DELETE FROM cfditools.totales WHERE empresa=${empresa};",
    "INSERT INTO cfditools.totales (empresa, anio, mes, origen, "++intercalate "," (map fName allTotalFields)++") \
    \SELECT idEmpresa,YEAR(fechaPeriodo),MONTH(fechaPeriodo),origen,"++intercalate "," (map (snd.head.fXpath) allTotalFields)++"\
    \ FROM cfditools.empresas INNER JOIN cfdis ON empresas.id=cfdis.idEmpresa \
    \ WHERE empresas.id=${empresa} \
    \ GROUP BY idEmpresa,YEAR(fechaPeriodo),MONTH(fechaPeriodo),origen;"
    ]

diotQuery :: IO [String]
diotQuery = do
  return [
    "DELETE FROM diot WHERE anio=${year} AND mes=${month};",
    "INSERT INTO diot (anio ,mes , nombre , rfc ,tipoTercero ,tipoOperacion ,identFiscal ,nombreExtranjero ,pais ,jurisdiccion ,actosNorte ,devNorte ,actosSur ,devSur ,actosIVA16 ,devIVA16 ,actosImpTangIVA16 ,devImpTangIVA16 ,actosImpIntangIVA16 ,devImpIntangIVA16 ,exclusivoIVA8Norte ,proporcionalIVA8Norte ,exclusivoIVA8Sur ,proporcionalIVA8Sur ,exclusivoIVA16 ,proporcionalIVA16 ,exclusivoImpTangIVA16 ,proporcionImpTangIVA16 ,exclusivoImpIntangIVA16 ,proporcionImpIntangIVA16 ,noAcreditableProporcionNorte , noAcreditableNoRequisitosNorte , noAcreditableExentoNorte , noAcreditableNoObjetoNorte , noAcreditableProporcionSur , noAcreditableNoRequisitosSur , noAcreditableExentoSur , noAcreditableNoObjetoSur , noAcreditableProporcion16 , noAcreditableNoRequisitos16 , noAcreditableExento16 , noAcreditableNoObjeto16 , noAcreditableProporcion16ImpTang , noAcreditableNoRequisitos16ImpTang , noAcreditableExento16ImpTang , noAcreditableNoObjeto16ImpTang , noAcreditableProporcion16ImpInTang , noAcreditableNoRequisitos16ImpInTang , noAcreditableExento16ImpInTang , noAcreditableNoObjeto16ImpInTang ,IVARET ,actosImportExcentos ,actosExentos ,actosCero ,actosNoObjetoNacional ,actosNoObjetoExtranjero ,manifiesto) \
    \ SELECT YEAR(fechaPeriodo) AS anio,MONTH(fechaPeriodo) AS mes,emisorNombre,emisorRfc,'04' AS tipoTercero,'85' AS tipoOperacion,'' as identFiscal,'' as nombreExtranjero, '' as pais, '' as jurisdiccion, \
    
    \ ROUND(sum(IFNULL(CASE WHEN tipo='I' AND metodoPago='PUE' AND cps.zona=1 THEN base8 ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=1 THEN IFNULL(pagoBaseIVA8,0) ELSE 0 END), 0) AS actosNorte, \
    \ ROUND(sum(IFNULL(CASE WHEN tipo='E' AND cps.zona=1 THEN base8 ELSE 0 END*IFNULL(tc,1),0)), 0) AS devNorte, \
    \ ROUND(sum(IFNULL(CASE WHEN tipo='I' AND metodoPago='PUE' AND cps.zona=2 THEN base8 ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=2 THEN IFNULL(pagoBaseIVA8,0) ELSE 0 END), 0) AS actosSur, \
    \ ROUND(sum(IFNULL(CASE WHEN tipo='E' AND cps.zona=2 THEN base8 ELSE 0 END*IFNULL(tc,1),0)), 0) AS devSur, \
    \ ROUND(sum(IFNULL(CASE WHEN tipo='I' AND metodoPago='PUE' THEN base16 ELSE 0 END*IFNULL(tc,1),0)+IFNULL(pagoBaseIVA16,0)), 0) AS actosIVA16,  \
    \ ROUND(sum(IFNULL(CASE WHEN tipo='E' THEN base16 ELSE 0 END*IFNULL(tc,1),0)), 0) AS devIVA16,  \

    \ 0 AS actosImpTangIVA16,0 AS devImpTangIVA16,0 AS actosImpIntangIVA16,0 AS devImpIntangIVA16, \

    \ ROUND(sum(CASE WHEN (rfcs.acreditable IS NULL OR rfcs.acreditable = 1) AND noConta IS NOT TRUE THEN IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=1 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=1 THEN IFNULL(pagoIVA8,0) ELSE 0 END ELSE 0 END), 0) AS exclusivoIVA8Norte,  \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable = 2) AND noConta IS NOT TRUE THEN (IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=1 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=1 THEN IFNULL(pagoIVA8,0) ELSE 0 END)*tasa_proporcion(${year},${month}) ELSE 0 END), 0) AS proporcionalIVA8Norte,  \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable IS NULL OR rfcs.acreditable = 1) AND noConta IS NOT TRUE THEN IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=2 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=2 THEN IFNULL(pagoIVA8,0) ELSE 0 END ELSE 0 END), 0) AS exclusivoIVA8Sur,  \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable = 2) AND noConta IS NOT TRUE THEN (IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=2 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=2 THEN IFNULL(pagoIVA8,0) ELSE 0 END)*tasa_proporcion(${year},${month}) ELSE 0 END), 0) AS proporcionalIVA8Sur,  \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable IS NULL OR rfcs.acreditable = 1) AND noConta IS NOT TRUE THEN IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') THEN IFNULL(iva16,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+IFNULL(pagoIVA16,0) ELSE 0 END), 0) AS exclusivoIVA16,  \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable = 2) AND noConta IS NOT TRUE THEN (IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') THEN IFNULL(iva16,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+IFNULL(pagoIVA16,0))*tasa_proporcion(${year},${month}) ELSE 0 END), 0) AS proporcionalIVA16,  \

    \ 0 AS exclusivoImpTangIVA16,0 AS proporcionImpTangIVA16,0 AS exclusivoImpIntangIVA16,0 AS proporcionImpIntangIVA16, \

    \ ROUND(sum(CASE WHEN (rfcs.acreditable = 2) AND noConta IS NOT TRUE THEN (IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=1 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+(CASE WHEN cps.zona=1 THEN IFNULL(pagoIVA8,0) ELSE 0 END))*(1-tasa_proporcion(${year},${month})) ELSE 0 END), 0) AS noAcreditableProporcionNorte, \
    \ ROUND(sum(CASE WHEN noConta IS TRUE THEN IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=1 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=1 THEN IFNULL(pagoIVA8,0) ELSE 0 END ELSE 0 END), 0) AS noAcreditableNoRequisitosNorte, \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable = 3) AND noConta IS NOT TRUE THEN IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=1 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=1 THEN IFNULL(pagoIVA8,0) ELSE 0 END ELSE 0 END), 0) AS noAcreditableExentoNorte, \
    \ 0 AS noAcreditableNoObjetoNorte, \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable = 2) AND noConta IS NOT TRUE THEN (IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=2 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+(CASE WHEN cps.zona=2 THEN IFNULL(pagoIVA8,0) ELSE 0 END))*(1-tasa_proporcion(${year},${month})) ELSE 0 END), 0) AS noAcreditableProporcionSur, \
    \ ROUND(sum(CASE WHEN noConta IS TRUE THEN IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=2 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=2 THEN IFNULL(pagoIVA8,0) ELSE 0 END ELSE 0 END), 0) AS noAcreditableNoRequisitosSur, \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable = 3) AND noConta IS NOT TRUE THEN IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') AND cps.zona=2 THEN IFNULL(iva8,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+CASE WHEN cps.zona=2 THEN IFNULL(pagoIVA8,0) ELSE 0 END ELSE 0 END), 0) AS noAcreditableExentoSur, \
    \ 0 AS noAcreditableNoObjetoSur, \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable = 2) AND noConta IS NOT TRUE THEN (IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') THEN IFNULL(iva16,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+IFNULL(pagoIVA16,0))*(1-tasa_proporcion(${year},${month})) ELSE 0 END), 0) AS noAcreditableProporcion16, \
    \ ROUND(sum(CASE WHEN noConta IS TRUE THEN IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') THEN IFNULL(iva16,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+IFNULL(pagoIVA16,0) ELSE 0 END), 0) AS noAcreditableNoRequisitos16, \
    \ ROUND(sum(CASE WHEN (rfcs.acreditable = 3) AND noConta IS NOT TRUE THEN IFNULL(CASE WHEN ((tipo='I' AND metodoPago='PUE') OR tipo='E') THEN IFNULL(iva16,0)*(CASE WHEN tipo='E' THEN -1 ELSE 1 END) ELSE 0 END*IFNULL(tc,1),0)+IFNULL(pagoIVA16,0) ELSE 0 END), 0) AS noAcreditableExento16, \
    \ 0 AS noAcreditableNoObjeto16, \

    \ 0 AS noAcreditableProporcion16ImpTang,0 AS noAcreditableNoRequisitos16ImpTang,0 AS noAcreditableExento16ImpTang,0 AS noAcreditableNoObjeto16ImpTang,0 AS noAcreditableProporcion16ImpInTang,0 AS noAcreditableNoRequisitos16ImpInTang,0 AS noAcreditableExento16ImpInTang,0 AS noAcreditableNoObjeto16ImpInTang, \
  
    \ ROUND(sum(IFNULL(retIVA*IFNULL(tc,1),0)+IFNULL(pagoRetIVA,0)), 0) AS IVARET, \
    \ 0 AS actosImportExcentos, \
    \ ROUND(sum(IFNULL(CASE WHEN tipo='I' AND metodoPago='PUE' THEN baseExento*IFNULL(tc,1) ELSE 0 END,0)+IFNULL(pagoBaseIVAExcento,0)), 0) AS actosExentos, \
    \ ROUND(sum(IFNULL(CASE WHEN tipo='I' AND metodoPago='PUE' THEN base0*IFNULL(tc,1) ELSE 0 END,0)+IFNULL(pagoBaseIVA0,0)), 0) AS actosCero, \
    \ 0 AS actosNoObjetoNacional, \
    \ 0 AS actosNoObjetoExtranjero, \
    \ 'si' AS manifiesto \
    
    \ FROM cfdis  \
    \ LEFT JOIN cfditools.cps ON cfditools.cps.cp=cfdis.domicilioFiscalEmisor \
    \ LEFT JOIN rfcs ON emisorRfc=rfc \
    \ WHERE (metodoPago='PUE' OR tipo='P' OR tipo='E') AND activo IS TRUE AND YEAR(fechaPeriodo)=${year} AND MONTH(fechaPeriodo) LIKE ${month} AND origen='Recibido'  \
    \ GROUP BY anio,mes,emisorNombre,emisorRfc  \
    \ HAVING  actosNorte>0 OR devNorte>0 OR actosSur>0 OR devSur>0 OR actosIVA16>0 OR devIVA16>0;"
    ]
