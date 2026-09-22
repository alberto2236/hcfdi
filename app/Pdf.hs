{-# LANGUAGE OverloadedStrings #-}


module Pdf where

import Graphics.PDF
import Data.Text (Text,length,pack,unpack)
import qualified Data.Text.Lazy as LT (unpack,pack)
import Control.Monad (when)
import Data.List.Split ( chunksOf, splitOn )
import qualified Data.Text as T (pack)
import qualified Text.XML.Light.Types as XMLT
import Text.XML.Light (Element)
import Text.Read (readMaybe)
import Data.Maybe (fromMaybe, fromJust)
import System.FilePath ((</>))
import System.Directory.Internal.Prelude (catMaybes, toUpper)
import Formatting (format)
import Formatting.Formatters ( fixed, commas )
import Data.Text.Lazy (strip)
import Fields
import Xml
import Internal.Types
import Internal.SAT
import Data.List (sortBy)
import Data.Function (on)
import Data.List (groupBy)
import qualified Codec.QRCode
import Codec.QRCode (defaultQRCodeOptions, ErrorLevel (M), TextEncoding (Utf8WithoutECI), QRImage (..))
import Codec.QRCode.JuicyPixels (toImage)
import Codec.QRCode.Data.QRImage (QRImage)
import qualified Data.Vector as V
import qualified Data.Vector.Generic as G
import Codec.Picture (savePngImage, DynamicImage (ImageRGB8), writePng)
import Text.Printf (printf)
import Data.ByteString.Lazy (ByteString)
import Data.List (isSuffixOf)
import System.IO (stderr)
import System.IO (hPutStrLn)

data Align = Left | Center | Right deriving (Show,Read)

type X = Double
type Y = Double
type W = Double
type Bold = Bool
type MultiLine = Bool
type PageNo = Integer
data PdfText = PdfText PageNo X Y W Bold MultiLine Align Text deriving (Show)
data PdfTableContext = PdfTableContext {ptcTable :: Table, ptcPage :: Integer,ptcDelta :: Double, ptcRowCount :: Integer, ptcX :: Double, ptcW :: Double, ptcMultiLine :: Bool, ptcMultiPage :: Bool, ptcFont :: PDFFont, ptcFontSmall :: PDFFont, ptcFontBold :: PDFFont, ptcRest :: Int}

getPdfContext :: IO PdfTableContext
getPdfContext = do
  Prelude.Right font <- mkStdFont Helvetica
  Prelude.Right fontBold <- mkStdFont Helvetica_Bold
  let pdfFont = PDFFont font pdfFontSize
      pdfFontSmall = PDFFont font pdfFontSizeSmall
      pdfFontBold = PDFFont fontBold pdfFontSize
  return PdfTableContext {ptcPage = 1, ptcDelta = 0, ptcRowCount = 1, ptcX = 0, ptcW = 0, ptcMultiLine=False, ptcMultiPage=False , ptcFont = pdfFont, ptcFontSmall=pdfFontSmall, ptcFontBold=pdfFontBold, ptcRest=0}


pdfFontSize :: FontSize
pdfFontSize = 10

pdfFontSizeSmall :: FontSize
pdfFontSizeSmall = pdfFontSize `div` 2

docH :: Double
docH = 792
docW :: Double
docW = 612

qr :: String -> Maybe QRImage
qr str = do
  let options = defaultQRCodeOptions M
      Just qrImg = Codec.QRCode.encode options Utf8WithoutECI str
      juicyImage = toImage 10 4 qrImg
  -- writePng "haskell_qrcode.png" (juicyImage)
  return qrImg

drawModule :: Double -> Double -> Double -> Int -> Int -> Draw ()
drawModule startX startY moduleSize row col = do
    -- HPDF origin (0,0) is bottom-left, so we subtract row index to draw top-down
    let x = startX + (fromIntegral col * moduleSize)
    let y = startY - (fromIntegral row * moduleSize)

    -- Configure and stroke/fill the block
    strokeColor (Rgb 0 0 0)
    fill $ Rectangle (x :+ y) ((x + moduleSize) :+ (y - moduleSize))

drawQRCode :: QRImage -> Double -> Double -> Double -> Draw ()
drawQRCode qrImg startX startY moduleSize = do
    let width = qrImageSize qrImg
        matrix = qrImageData qrImg

    -- Iterate through the 2D matrix structure
    mapM_ (\row ->
        mapM_ (\col ->
            -- Look up pixel state (True is black, False is white)
            let idx = row * width + col
            in when ((G.convert matrix) V.! idx) (drawModule startX startY moduleSize row col)
          ) [0 .. width - 1]
       ) [0 .. width - 1]

drawShapes :: Integer -> String -> Draw ()
drawShapes page qrStr = do
      setWidth 0.5
      strokeColor black
      stroke $ Rectangle (9 :+ 10) ((docW-10) :+ (docH-20))
      when (page==1) $ do
        stroke $ Line 10 (docH-130) (docW-10) (docH-130)
        stroke $ Line 10 (docH-600) (docW-10) (docH-600)
        let Just qrImg = qr qrStr
        drawQRCode qrImg 15 128 2

getPage :: PdfText -> PageNo
getPage (PdfText p _ _ _ _ _ _ _) = p

pdf :: PdfTableContext -> [PdfText] -> String -> Maybe String -> Bool -> String -> IO (Maybe ByteString)
pdf ptCtx texts uuid pdfFileName debug qrStr = do
  let documentInfo = standardDocInfo
      defaultPageSize = PDFRect 0 0 docW docH
  case pdfFileName of
    Just name -> do
      runPdf name documentInfo defaultPageSize realBuild
      return Nothing
    Nothing -> do
      return $ Just $ pdfByteString documentInfo defaultPageSize realBuild
  where realBuild :: PDF ()
        realBuild = do
          let pages = foldr (\(PdfText page _ _ _ _ _ _ _) acc -> if page `elem` acc then acc else page:acc) [] texts
              pageTexts = concatMap (getPageTexts uuid $ fromIntegral $ Prelude.length pages) pages
              sortedByPage = sortBy (compare `on` getPage) (texts++pageTexts)
              groupedByPage = groupBy ((==) `on` getPage) sortedByPage
              pdfFont = ptcFont ptCtx
              pdfFontSmall = ptcFontSmall ptCtx
              pdfFontBold = ptcFontBold ptCtx
          mapM_ (buildPage pdfFont pdfFontSmall pdfFontBold debug qrStr) groupedByPage


getPageTexts :: String -> Integer -> Integer -> [PdfText]
getPageTexts uuid totalPages page = [PdfText page 18 770 100 False False Center $ T.pack $ "Pagina: " ++ show page ++ "/" ++ show totalPages , PdfText page 450 775 150 False True Center $ T.pack uuid]

buildPage :: PDFFont -> PDFFont -> PDFFont -> Bool -> String -> [PdfText] -> PDF ()
buildPage pdfFont pdfFontSmall pdfFontBold debug qrStr texts = do
  page <- addPage Nothing
  drawWithPage page $ do
        -- drawText $ text pdfFont 20.0 12.0 "Pagina: 1/1"
        drawShapes (getPage $ head texts) qrStr
        strokeColor red
        setWidth 0.1
        mapM_ (draw debug (pdfFont,pdfFontBold,pdfFontSmall)) texts

draw :: Bool -> (PDFFont, PDFFont, PDFFont) -> PdfText -> Draw ()
draw debug (fontNormal,fontBold,fontSmall) (PdfText p x y w b ml a s) = do
  drawLines font (align x s w font a) (docH-y-fromIntegral fontSize') (if ml then getTextBoxText s w font else getText s w font)
  when debug $ do
    stroke $ Rectangle (x :+ (docH-y-fromIntegral fontSize')) ((x+w) :+ (docH-y))
  where font
          | ml = fontSmall
          | b = fontBold
          | otherwise = fontNormal
        fontSize' = if ml then pdfFontSizeSmall else pdfFontSize

drawLines :: PDFFont -> PDFFloat -> PDFFloat -> [Text] -> Draw ()
drawLines font@(PDFFont _ size) x y (t:xs) = do
          drawText $ text font x y t
          drawLines font x (y-fromIntegral size) xs
drawLines _ _ _ [] = return ()



getText :: Text -> PDFFloat -> PDFFont -> [Text]
getText t w f = if width>(w+0.5) then [finalText]  else [t]
  where width = textWidth f t
        charWidth = width / fromIntegral (Data.Text.length t)
        chars' = round (w / charWidth)
        chars = if chars' > 3 then chars' - 3 else 0
        cuted = take chars (unpack t)
        finalText = pack $ cuted ++ "..."
getTextBoxText :: Text -> PDFFloat -> PDFFont -> [Text]
getTextBoxText t w f = if width>(w+0.5) then finalText  else [t]
  where width = textWidth f t
        charWidth = width / fromIntegral (Data.Text.length t)
        chars' = round (w / charWidth)
        chars = if chars' > 3 then chars' - 3 else 0
        finalText = map pack $ chunksOf chars (unpack t)

align :: Double -> Text -> Double -> PDFFont -> Align -> Double
align x text' w font a = case a of
            Pdf.Left -> x
            Pdf.Center -> x+((w-width)/2)
            _ -> x+(w-width)
    where width = textWidth font text'




formatMoney :: Double -> String
formatMoney number = "$" ++ formatDouble number

formatPercent :: Double -> String
formatPercent number = formatDouble (number*100) ++ "%"

formatDouble :: Double -> String
formatDouble number = LT.unpack (format commas intPart) ++ "." ++ last parts
    where parts = splitOn "." (LT.unpack $ format (fixed 2) number)
          intPart :: Integer
          intPart = read $ head parts

format' :: [ClaveSAT] -> Field -> String -> String
format' claves f s = if null s then s else case f of
    FMoney {} -> maybe "###" formatMoney (readMaybe s)
    FDouble {} -> maybe "###" formatDouble (readMaybe s)
    FPercent {} -> maybe "###" formatPercent (readMaybe s)
    FSAT {} -> claveSat claves (fTipoSAT f) s
    FIL {} -> numToText (read s)
    _ -> s


getAlig :: Field -> Align
getAlig f = fromMaybe Pdf.Left (readMaybe $ pdfAlign f)


isMultiLine :: Field -> Bool
isMultiLine FTextBox{} = True
isMultiLine _ = False

buildPdf :: Context -> PdfTableContext -> Maybe String -> [XMLT.Content] -> IO (Maybe ByteString)
buildPdf ctx ptCtx path_ xml = do
    let pdfTexts = map (\f -> (PdfText 1 (pdfX f) (pdfY f) (pdfW f) False (isMultiLine f) (getAlig f) . T.pack . format' (cClavesSAT ctx) f . fromMaybe "" . (xpath xml . Xml.path' (getVersion xml) . fXpath)) f) fields
        tablesTexts = concatMap (\t -> if tipoDocto `elem` tOnPdf t then if tName t == "partidas" then tableTexts ctx ptCtx{ptcMultiPage=cPdf ctx == FullPDF || cPdf ctx == MultipagePDF,ptcMultiLine=cPdf ctx == FullPDF || cPdf ctx == MultilinePDF,ptcTable=t} xml 0.0 t else  tableTexts ctx ptCtx{ptcTable=t} xml 0.0 t  else []) (cTables ctx)
        labelTexts = map (\f -> (PdfText 1 (pdfX f) (pdfY f) (pdfW f) True False (getAlig f) . T.pack . fLabel) f) labels
        formatedTotal = printf "%017.6f" (read $ getTotal xml :: Float) :: String
        sello = fromMaybe "-unknown-" $ getSello xml
        qrStr = "https://verificacfdi.facturaelectronica.sat.gob.mx/default.aspx?id="++fromMaybe "" (getUuid xml)++"&re="++fromMaybe "" (getRfcEmisor xml)++"&rr="++fromMaybe "" (getRfcReceptor xml)++"&tt="++formatedTotal++"&fe="++drop (Prelude.length sello - 8) sello
        fileName = case path_ of
                    Nothing -> Nothing
                    Just p -> if "pdf" `isSuffixOf` p then Just p else 
                                Just $ p </> (fromMaybe "unknown.pdf" (getUuid xml) ++ ".pdf")
    if (not.cfdiValido) xml then do
      hPutStrLn stderr (show path_++" XML invalido")
      return Nothing
    else
      pdf ptCtx (pdfTexts++tablesTexts++labelTexts) (fromMaybe "unknown" (getUuid xml)) fileName (cDebug ctx) qrStr
    where fields = filter (\f -> tipoDocto `elem` fOnPdf f) (pdfFields $ cFields ctx)
          tipoDocto = read (fromMaybe "I"  (getTipo xml))
          labels = filter (\f -> tipoDocto `elem` fOnPdf f) (pdfLabels $ cFields ctx)




tableTexts :: Context -> PdfTableContext -> [XMLT.Content] -> Double -> Table -> [PdfText]
tableTexts ctx ptCtx xml tableDelta t = do
        if isTableH t then headers 1 ++ buildTexts visibleFields elems ptCtx{ptcX= pdfX firstField,ptcW=rowWidth,ptcRowCount=2,ptcDelta=ptcDelta ptCtx+fromIntegral pdfFontSize,ptcRest=Prelude.length xml} --1 (tableDelta + fromIntegral pdfFontSize) 1
        else buildTexts visibleFields elems ptCtx{ptcX= pdfX firstField,ptcW=rowWidth}
    where elems = getElems xml $ path $ tableXmlPath t
          rowWidth=sum (map pdfW visibleFields)
          tipoDocto = read (fromMaybe "I"  (getTipo xml))
          headers page = concatMap (\f -> addTableHeader ctx ptCtx f [fLabel f] page tableDelta ) visibleFields
          visibleFields@(firstField:_) = filter (\f -> tipoDocto `elem` fOnPdf f) $ tableFields t
          buildTexts fields@(f:_) (element:restElems) tableCtx =
            let (row,newPage,newDelta,newRowCount) = buildTableRow ctx (getVersion xml) tableCtx element fields
                newContext = tableCtx{ptcPage=newPage,ptcDelta=newDelta,ptcRowCount=newRowCount,ptcRest=Prelude.length restElems}
                newPageHeaders = if ptcPage tableCtx /= newPage && ptcMultiPage tableCtx then concatMap (\f -> addTableHeader ctx newContext f [fLabel f] (ptcPage newContext) ((pdfY f * (-1)) + (fromIntegral pdfFontSize*2)) ) visibleFields else []
                -- subTablesDelta = foldr (\(PdfText _ _ y _ _ _ _ _) acc -> max y acc) 0.0 row + (fromIntegral pdfFontSize - pdfY f)
                -- subTablesTxts = addSubTables ctx ptCtx xml 0 (subTablesDelta+pdfY f) $ catMaybes $ map (getTable (cTables ctx)) (tSubTables t)
                -- nextDelta
                --   | needPage = (pdfY f * (-1)) + (fromIntegral pdfFontSize*3) --tableDelta
                --   | null subTablesTxts = subTablesDelta
                --   | otherwise = foldr (\(PdfText _ _ y _ _ _ _ _) acc -> max y acc) 0.0 subTablesTxts + (fromIntegral pdfFontSize - pdfY f)
                -- nextPage
                --   |  needPage = page+1
                --   |  otherwise = page
                -- rowsAdded = (nextDelta-delta)/(fromIntegral pdfFontSize)
                -- nextRowCount = if needPage then 0 else (rowCount+round rowsAdded)
                -- pageHeaders = if needPage then map (\(PdfText p x y w b ml a t) -> PdfText p x (fromIntegral pdfFontSize*2) w b ml a t) $ headers nextPage else []
            -- in row ++ subTablesTxts ++ pageHeaders ++ buildTexts fields restElems nextPage nextDelta nextRowCount
            in if ptcMultiPage tableCtx || ptcPage tableCtx==1 then row ++ newPageHeaders ++ buildTexts fields restElems newContext else []
          buildTexts _ _ _  = []




-- addSubTables :: Context -> PdfContext -> [XMLT.Content] -> Integer -> Double -> [Table] -> [PdfText]
-- addSubTables ctx ptCtx xml page delta (t:xs) =
--     let txts = tableTextsLimit ctx ptCtx xml delta t
--         nextDelta = if null txts then delta else foldr (\(PdfText _ _ y _ _ _ _ _) acc -> max y acc) 0.0 txts + fromIntegral pdfFontSize
--     in txts ++ addSubTables ctx ptCtx xml page nextDelta xs
-- addSubTables _ _ _ _ _ [] = []

splitW :: PDFFloat -> String -> PDFFont -> [String] -> [String]
splitW w (x:xs) font (y:ys) = if textWidth font (pack $ x:y) < w then splitW w xs font ((y++[x]):ys) else splitW w (x:xs) font ("":y:ys)
splitW w [] font result = reverse result

splitLongLines :: Field -> PDFFont -> Text -> PDFFloat -> [String]
splitLongLines field font t w = if not $ isNumericField field then finalText else [unpack t]
    where finalText = splitW w (unpack t) font [""]

buildTableRow :: Context -> String -> PdfTableContext -> Element -> [Field] -> ([PdfText],Integer,Double,Integer)
buildTableRow ctx version ptCtx xml fields = do
    join ([],0,0,0) $ concatMap (\(f) -> do
            buildTableCell ctx ptCtx f $ textData f
        ) fields
    where textData f = if ptcMultiLine ptCtx then concatMap (\l -> splitLongLines f (ptcFont ptCtx) (T.pack l) (pdfW f)) (lines $ (fromMaybe "" . getStrVal) f) else [(fromMaybe "" . getStrVal) f]
          getStrVal FLabel{fLabel=label} = Just label
          getStrVal f = (xpath' xml . Xml.path' version . fXpath) f
          join (rt,rp,rd,rrc) ((text,page,delta,rowCount):xs) = join (text:rt,if page>rp then page else rp,if (delta>rd && page==rp) || page>rp then delta else rd,if (rowCount>rrc && page==rp) || page>rp then rowCount else rrc) xs
          join result [] = result

newPageNeeded :: Integer -> Table -> Integer -> Bool
newPageNeeded page t rowCount = if page == 1 then rowCount == abs (tMax t) && tMax t > 0 else rowCount == 75 && tMax t > 0

buildTableCell :: Context -> PdfTableContext -> Field -> [String] -> [(PdfText,Integer,Double,Integer)]
buildTableCell ctx ptCtx f (l:xs) =  if pageNeeded && (not.ptcMultiPage) ptCtx then [(PdfText (ptcPage ptCtx) (ptcX ptCtx) (pdfY f + ptcDelta ptCtx) (ptcW ptCtx) True False Pdf.Center  (T.pack $ "+ "++(show $ ptcRest ptCtx)++" ..."), newPage, newDelta, newRowCount)] else (PdfText (ptcPage ptCtx) (pdfX f) (pdfY f + ptcDelta ptCtx) (pdfW f) (getBold f) (isMultiLine f) (getAlig f)  (T.pack $ format' (cClavesSAT ctx) f l), newPage, newDelta, newRowCount) : buildTableCell ctx ptCtx{ptcPage=newPage,ptcRowCount=newRowCount,ptcDelta=newDelta} f xs
    where getBold FLabel{} = True
          getBold _ = False
          pageNeeded = newPageNeeded (ptcPage ptCtx) (ptcTable ptCtx) (ptcRowCount ptCtx)
          newPage =     if pageNeeded then ptcPage ptCtx+1 else ptcPage ptCtx
          newDelta =    if pageNeeded then (pdfY f * (-1)) + (fromIntegral pdfFontSize*3) else ptcDelta ptCtx+fromIntegral pdfFontSize
          newRowCount = if pageNeeded then 2 else ptcRowCount ptCtx+1

buildTableCell _ _ _ [] = []
addTableHeader :: Context -> PdfTableContext-> Field -> [String] -> Integer -> Double -> [PdfText]
addTableHeader ctx ptCtx f (l:xs) page delta =  PdfText page (pdfX f) (pdfY f + delta) (pdfW f) True (isMultiLine f) (getAlig f)  (T.pack l) : addTableHeader ctx ptCtx f xs page (delta+fromIntegral pdfFontSize)
addTableHeader _ _ _ [] _ _ = []

numToText :: Double -> String
numToText number = toUpper (head importeConLetra) : tail importeConLetra
  where parts = splitOn "." (LT.unpack $ format (fixed 2) number)
        intPart :: Integer
        intPart = read $ head parts
        decPart :: String
        decPart = if Prelude.length parts>1 then last parts else "00"
        importeConLetra = LT.unpack $ strip $ LT.pack $ numToTextInt intPart ++ " " ++ decPart ++ "/100 "

numToTextInt :: Integer -> String
numToTextInt n
  | n==0 = ""
  | n==1 = "uno"
  | n==2 = "dos"
  | n==3 = "tres"
  | n==4 = "cuatro"
  | n==5 = "cinco"
  | n==6 = "seis"
  | n==7 = "siete"
  | n==8 = "ocho"
  | n==9 = "nueve"
  | n==10 = "diez"
  | n==11 = "once"
  | n==12 = "doce"
  | n==13 = "trece"
  | n==14 = "catorce"
  | n==15 = "quice"
  | n>15 && n < 20 = "dieci"++numToTextInt (n-10)
  | n>=20 && n<30 = if n==20 then "veinte" else "veinti"++numToTextInt (n-20)
  | n>=30 && n<40 = if n==30 then "treinta" else "treinta y "++numToTextInt (n-30)
  | n>=40 && n<50 = if n==40 then "cuarenta" else "cuarenta y "++numToTextInt (n-40)
  | n>=50 && n<60 = if n==50 then "cincuenta" else "cincuenta y "++numToTextInt (n-50)
  | n>=60 && n<70 = if n==60 then "sesenta" else "sesenta y "++numToTextInt (n-60)
  | n>=70 && n<80 = if n==70 then "setenta" else "setenta y "++numToTextInt (n-70)
  | n>=80 && n<90 = if n==80 then "ochenta" else "ochenta y "++numToTextInt (n-80)
  | n>=90 && n<100 = if n==90 then "noventa" else "noventa y "++numToTextInt (n-90)
  | n>=100 && n<200 = if n==100 then "cien" else "ciento "++numToTextInt (n-100)
  | n>=200 && n<300 = if n==200 then "doscientos" else "doscientos "++numToTextInt (n-200)
  | n>=300 && n<400 = if n==300 then "trescientos" else "trescientos "++numToTextInt (n-300)
  | n>=400 && n<500 = if n==400 then "cuatrocientos" else "cuatrocientos "++numToTextInt (n-400)
  | n>=500 && n<600 = if n==500 then "quinientos" else "quinientos "++numToTextInt (n-500)
  | n>=600 && n<700 = if n==600 then "seiscientos" else "seiscientos "++numToTextInt (n-600)
  | n>=700 && n<800 = if n==700 then "setecientos" else "setecientos "++numToTextInt (n-700)
  | n>=800 && n<900 = if n==800 then "ochocientos" else "ochocientos "++numToTextInt (n-800)
  | n>=900 && n<1000 = if n==900 then "novecientos" else "novecientos "++numToTextInt (n-900)
  | n>=1000 && n<1000000 = (if millares>1 then numToTextInt millares else "")++" mil "++numToTextInt (n-(millares*1000))
  | n>=1000000 = if millones>1 then numToTextInt millones++" millones "++numToTextInt (n-(millones*1000000)) else "un millon "++numToTextInt (n-(millones*1000000))
  | otherwise = "???"
  where millares = div n 1000
        millones = div n 1000000
