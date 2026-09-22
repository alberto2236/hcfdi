
module Internal.SAT where

import Internal.Types
import qualified Data.ByteString as BS (readFile,writeFile)
import Network.HTTP.Simple (parseRequest, httpBS, getResponseBody)

claveSat :: [ClaveSAT] -> String -> String -> String
claveSat claves t c = if null match then c else c ++ " " ++ descripcion
    where match = filter (\(ClaveSAT t' c' _) -> t==t' && c==c') claves
          (ClaveSAT _ _ descripcion) = head match

columns :: [Int]
columns = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]

splitCSV :: String -> [String] -> [String]
splitCSV "" result = result
splitCSV string result = let splited = getFullField string []
                         in fst splited : splitCSV ((safeTail.snd) splited) result
    where safeTail dat = if null dat then [] else tail dat
          safeHead dat = if null dat then 'X' else head dat
          safeLast dat = if null dat then 'X' else last dat
          getFullField :: String -> String -> (String,String)
          getFullField [] rest = (rest,[])
          getFullField str rsltFull@('\"':xs) = let splited = break (== ',') (safeTail str)
                                                in if (safeLast.fst) splited == '\"' then (rsltFull++fst splited,snd splited) else getFullField (snd splited) (rsltFull++fst splited)
          getFullField str [] = let splited = break (== ',') str
                                in if (safeHead.fst) splited == '\"' && (safeLast.fst) splited == '\"' then splited  else 
                                    if (safeHead.fst) splited == '\"' then getFullField (snd splited) (fst splited) else splited

getBlackList :: IO ()
getBlackList = do
    let url = "http://omawww.sat.gob.mx/cifras_sat/Documents/Listado_Completo_69-B.csv"
    req <- parseRequest url
    resp <- httpBS req
    let newVersionFile = getResponseBody resp
    BS.writeFile "blacklist.csv" newVersionFile


