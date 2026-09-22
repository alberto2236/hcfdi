{-# LANGUAGE OverloadedStrings #-}


module Fields  where

import Internal.Types

noneDocs :: [TipoDocto]
noneDocs=[]



--Si se mueve el orden de estos campos hay que editar los indices en Reg (react)
specialFields :: [Field]
specialFields = [
  FText "path" "TEXT" "PATH" [] 0 0 0 "Left" noneDocs noneDocs False,
  FText "idEmpresa" "INT" "idEmpresa" []0 0 0 "Left" noneDocs noneDocs False,
  FText "origen" "CHAR(25)" "Origen" [] 0 0 0 "Left" noneDocs noneDocs False,
  FInteger "noConta" "bool" "NoCont" [] 0 0 0 "Left" noneDocs noneDocs False,
  FText "fechaPeriodo" "CHAR(50)" "Fecha periodo" [] 0 0 0 "Left" noneDocs noneDocs False,
  FText "blackList" "INT" "Lista negra" [] 0 0 0 "Left" noneDocs noneDocs False,
  FText "color" "varchar(15)" "Color" [] 0 0 0 "Left" noneDocs noneDocs False,
  FText "valStr" "varchar(50)" "ValStr" [] 0 0 0 "Left" noneDocs noneDocs False
  ]
idField :: Field
idField = FInteger "id" "INT" "ID" [] 0 0 0 "Left" noneDocs noneDocs False
specialTableFields :: [Field]
specialTableFields = [
    FText "idParent" "CHAR(50)" "idPago" [] 0 0 0 "Left" noneDocs noneDocs False
  ]


getTable :: [Table] -> String -> Maybe Table
getTable tables name = if not $ null finded then Just $ head finded else Nothing
          where finded = [t | t <- tables, tName t == name ]

isTableH :: Table -> Bool
isTableH TableH{} = True
isTableH _ = False

pdfLabels :: [Field] -> [Field]
pdfLabels =  filter isLabel
isLabel :: Field -> Bool
isLabel FLabel {} = True
isLabel _ = False
isIL :: Field -> Bool
isIL FIL {} = True
isIL _ = False
pdfFields :: [Field] -> [Field]
pdfFields fields =[f | f <- fields,  not (isLabel f) && pdfX f > 0 && pdfY f > 0 ]
xmlFields :: [Field] -> [Field]
xmlFields fields =[f | f <- fields,  not (isLabel f) &&  not (isIL f) && (not . null) (fXpath f)]
dbFields :: [Field] -> [Field]
dbFields fields =[f | f <- fields, not (isLabel f) &&  not (isIL f)]
getField :: [Field] -> String -> Maybe Field
getField fields name = if not $ null finded then Just $ head finded else Nothing
          where finded = [f | f <- fields,  not (isLabel f) && fName f == name ]
rmSpecialFields :: [Field] -> [Field]
rmSpecialFields = filter (not . (`elem` specialFields))

indexOf :: [Field] -> String -> Int
indexOf fields name = let taked = takeWhile (\f -> fName f /= name) fields
                      in if length taked == length fields then -1 else length taked 

onList :: [Field] -> TipoDocto -> [Field]
onList fields tipo = filter (\f -> tipo `elem` fOnList f) fields




justA :: [Field] -> [Field]
justA fields = specialFields ++ filter (\f -> A `elem` fOnList f) fields


moveFields :: String -> Double -> Double -> IO ()
moveFields path x y = do
  fieldsStr <- readFile path
  let fields = map read (lines fieldsStr) :: [Field]
      updatedFields = map (\f -> f{pdfX=pdfX f+x,pdfY=pdfY f + y}) fields
  mapM_ print updatedFields


