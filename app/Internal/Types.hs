{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}

module Internal.Types where
import GHC.Generics (Generic)
import Data.Char (toLower)
import Text.Read
import Text.ParserCombinators.ReadPrec
import Control.Applicative ((<|>))
import Text.Read.Lex (numberToRational, numberToInteger)
import Data.Maybe (fromMaybe)

--Un tipo X es un tipo desconocido, un XML invalido
data TipoDocto = None | I | E | P | N | T | A | X deriving (Show,Read,Eq)
data ReportType = Rcfdi | Rpivot | Rreport deriving (Show,Read,Eq)
data PivotData = PivotData [[(String,Int)]] [Field] [[String]] deriving (Show,Read)
data ClaveSAT = ClaveSAT String String String deriving (Read,Show)


emptyPivotData :: PivotData
emptyPivotData = PivotData [] [] []

data Field = FText    {fName :: String, dbType :: String, fLabel :: String, fXpath :: [([String],String)], pdfX :: Double,  pdfY :: Double, pdfW :: Double, pdfAlign :: String, fOnList :: [TipoDocto], fOnPdf :: [TipoDocto], fEditable :: Bool} |
             FTextBox {fName :: String, dbType :: String, fLabel :: String, fXpath :: [([String],String)], pdfX :: Double,  pdfY :: Double, pdfW :: Double, pdfAlign :: String, fOnList :: [TipoDocto], fOnPdf :: [TipoDocto], fEditable :: Bool} |
             FMoney   {fName :: String, dbType :: String, fLabel :: String, fXpath :: [([String],String)], fDecimals :: Integer,  fTc :: Maybe String,  pdfX :: Double,  pdfY :: Double, pdfW :: Double, pdfAlign :: String, fOnList :: [TipoDocto], fOnPdf :: [TipoDocto], fEditable :: Bool} |
             FPercent {fName :: String, dbType :: String, fLabel :: String, fXpath :: [([String],String)], pdfX :: Double,  pdfY :: Double, pdfW :: Double, pdfAlign :: String, fOnList :: [TipoDocto], fOnPdf :: [TipoDocto], fEditable :: Bool} |
             FDouble  {fName :: String, dbType :: String, fLabel :: String, fXpath :: [([String],String)], pdfX :: Double,  pdfY :: Double, pdfW :: Double, pdfAlign :: String, fOnList :: [TipoDocto], fOnPdf :: [TipoDocto], fEditable :: Bool} |
             FInteger {fName :: String, dbType :: String, fLabel :: String, fXpath :: [([String],String)], pdfX :: Double,  pdfY :: Double, pdfW :: Double, pdfAlign :: String, fOnList :: [TipoDocto], fOnPdf :: [TipoDocto], fEditable :: Bool} |
             FLabel   {fName :: String,                   fLabel :: String,                                pdfX :: Double,  pdfY :: Double, pdfW :: Double, pdfAlign :: String, fOnPdf :: [TipoDocto]} |
             FSAT     {fName :: String, dbType :: String, fLabel :: String, fTipoSAT :: String, fXpath :: [([String],String)], pdfX :: Double,  pdfY :: Double, pdfW :: Double, pdfAlign :: String, fOnList :: [TipoDocto], fOnPdf :: [TipoDocto]} |
             FIL      {fName :: String,                                     fXpath :: [([String],String)], pdfX :: Double,  pdfY :: Double, pdfW :: Double, pdfAlign :: String, fOnPdf :: [TipoDocto]}
             deriving (Show)

numericFields :: [Field] -> [Field]
numericFields = filter isNumericField
isNumericField :: Field -> Bool
isNumericField FMoney{} = True
isNumericField FPercent{} = True
isNumericField FDouble{} = True
isNumericField FInteger{} = True
isNumericField _ = False

data Pivot = Pivot {pColumn :: [String], pRows :: [String], pValue :: [String]} deriving (Show,Read)
data Table = Table {tName :: String, sqlName :: String, tParentId::String, tAnds :: String, tableXmlPath :: String, tOnList :: [TipoDocto], tOnPdf :: [TipoDocto], tSubTables :: [String], tPivot :: Maybe Pivot, tMax :: Integer, tableFields :: [Field]} |
             TableH {tName :: String, sqlName :: String, tParentId::String, tAnds :: String, tableXmlPath :: String, tOnList :: [TipoDocto], tOnPdf :: [TipoDocto], tSubTables :: [String], tPivot :: Maybe Pivot, tMax :: Integer, tableFields :: [Field]} |
             TableV2 {tName :: String, tJoin::String, tAnds :: String, tableXmlPath :: String, tOnList :: [TipoDocto], tOnPdf :: [TipoDocto], tSubTables :: [String], tPivot :: Maybe Pivot, tMax :: Integer, tableFields :: [Field]} deriving (Show,Read)
data Report = Report {rName :: String, rTable :: String, rLabel :: String, rReportType :: ReportType, rNavigate :: String, rOnList :: String, rEmpresa :: Bool, rMonth :: Bool, rTipo :: Bool, rOrigen :: Bool, rStatus :: Bool} deriving (Show,Read)


data ContextPDF = NonePDF | ShortPDF | MultilinePDF | MultipagePDF | FullPDF deriving (Read,Show,Eq)

data Context = Context {cDebug :: Bool, cFields :: [Field], cTables :: [Table], cClavesSAT :: [ClaveSAT], cPdf::ContextPDF, cDb::Bool} deriving (Show)
data QueryContext = QueryContext {qcTable :: Maybe Table, qcFields :: [Field], qcEmpresa :: Empresa, qcYear :: String, qcMonth :: String, qcTipo :: String, qcOrigen :: String, qcStatus :: String,
                        qcAnds :: String, qcOrder :: String, qcPage :: Integer, qcMxn :: Bool, qcFecha :: Maybe String} deriving (Show)


data TipoSol = CFDI | Metadata deriving (Show,Generic,Read)
data TipoSolicitud = Emitidos | Recibidos | Manual deriving (Show,Generic,Read)
data Empresa = Empresa {idEmpresa::Integer, rfc::String, nombre::String, directorio::String, vigencia::String, activa::Bool} deriving (Show,Generic)
data Solicitud = Solicitud {idSol :: Integer, idSolEmpresa :: Integer, solYear :: Integer, solMonth :: Integer, solDay :: String, solTipo :: TipoSolicitud, idSat :: String, satTipo :: TipoSol, solStatus::String,
      idStatus::Int, empresaNombre :: String} deriving (Show,Generic)
data User = User {userId::Integer, userName::String, userUser::String, userPasspass::String, userEmpresas::String, userDoctos::String} deriving (Show,Generic)
data Rfc = Rfc {rfcRfc::String, rfcNombre::String, rfcAcreditable::String} deriving (Show,Generic)


data Operador = IGUAL | DIFERENTE | MAYOR | MENOR | MAYORIGUAL | MENORIGUAL
data Validacion = Validacion {nivel::Integer, descripcion::String, condiciones::[(String,Operador,String)], color::String}

freeLic :: Integer
freeLic = -1
localLic :: Integer
localLic = 0
redLic :: Integer
redLic = 1
data Licencia = Licencia {licUsuarios :: Integer, licEmpresas :: Integer, licVersion::Integer} deriving (Show)




instance Eq Field where
  (==) :: Field -> Field -> Bool
  f1 == f2 = map toLower (fName f1) == map toLower (fName f2)
  (/=) :: Field -> Field -> Bool
  f1 /= f2 = not (f1 == f2)

instance Eq Table where
  (==) :: Table -> Table -> Bool
  f1 == f2 = map toLower (tName f1) == map toLower (tName f2)
  (/=) :: Table -> Table -> Bool
  f1 /= f2 = not (f1 == f2)

instance Eq Report where
  (==) :: Report -> Report -> Bool
  f1 == f2 = map toLower (rName f1) == map toLower (rName f2)
  (/=) :: Report -> Report -> Bool
  f1 /= f2 = not (f1 == f2)


data Orden = Orden {id::String,img_src::String, total :: String} deriving (Show,Generic)



readField :: String -> IO (Maybe Field)
readField str = do
  case readMaybe str of
    Nothing -> do
      print str
      return Nothing
    Just f -> return $ Just f



instance Read Field where
  readPrec = parens $ do
    Ident o <- lexP
    case o of
      "FText" -> readFields FText {fName = "", dbType  = "", fLabel  = "", fXpath = [], pdfX = 0,  pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [], fOnPdf = [], fEditable=False}
      "FTextBox" -> readFields FTextBox {fName = "", dbType  = "", fLabel  = "", fXpath = [], pdfX = 0,  pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [], fOnPdf = [], fEditable=False}
      "FMoney" -> readFields FMoney {fName = "", dbType  = "", fLabel  = "", fXpath = [], fDecimals = 2,  fTc = Nothing, pdfX = 0,  pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [], fOnPdf = [], fEditable=False}
      "FPercent" -> readFields FPercent {fName = "", dbType  = "", fLabel  = "", fXpath = [], pdfX = 0,  pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [], fOnPdf = [], fEditable=False}
      "FDouble" -> readFields FDouble {fName = "", dbType  = "", fLabel  = "", fXpath = [], pdfX = 0,  pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [], fOnPdf = [], fEditable=False}
      "FInteger" -> readFields FInteger {fName = "", dbType  = "", fLabel  = "", fXpath = [], pdfX = 0,  pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [], fOnPdf = [], fEditable=False}
      "FLabel" -> readFields FLabel {fName = "", fLabel  = "", pdfX = 0,  pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnPdf = []}
      "FSAT" -> readFields FSAT {fName = "", dbType  = "", fLabel  = "", fTipoSAT = "", fXpath = [], pdfX = 0,  pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [], fOnPdf = []}
      "FIL" -> readFields FIL {fName = "", fXpath = [], pdfX = 0,  pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnPdf = []}
      otherwise -> pfail
      
    where readFields :: Field -> ReadPrec Field
          readFields field = do
            lex <- lexP
            case lex of
              EOF -> return field
              Punc "}" -> return field
              Punc "{" -> readFields field
              Punc "," -> readFields field
              Ident fieldName -> do
                Punc "=" <- lexP
                newField <- readValue field fieldName
                readFields newField
              _ -> pfail
          readValue field fieldName = do
            case fieldName of
              "fName" -> do
                String v <- lexP
                return field{fName=v}
              "dbType" -> do
                String v <- lexP
                return field{dbType=v}
              "fLabel" -> do
                String v <- lexP
                return field{fLabel=v}
              "fXpath" -> do
                v <- readXpath []
                return field{fXpath=v}
              "pdfX" -> do
                Number v <- lexP
                return field{pdfX=(fromRational.numberToRational) v}
              "pdfY" -> do
                Number v <- lexP
                return field{pdfY=(fromRational.numberToRational) v}
              "pdfW" -> do
                Number v <- lexP
                return field{pdfW=(fromRational.numberToRational) v}
              "pdfAlign" -> do
                String v <- lexP
                return field{pdfAlign=v}
              "fOnList" -> do
                v <- readOnList []
                return field{fOnList=v}
              "fOnPdf" -> do
                v <- readOnList []
                return field{fOnPdf=v}
              "fDecimals" -> do
                Number v <- lexP
                return field{fDecimals=fromMaybe 0 (numberToInteger v)}
              "fTc" -> do
                Ident maybe <- lexP
                v <- case maybe of
                  "Just" -> do
                    String tc <- lexP
                    return $ Just tc
                  _ -> return Nothing
                return field{fTc=v}
              "fTipoSAT" -> do
                String v <- lexP
                return field{fTipoSAT=v}
              "fEditable" -> do
                Ident v <- lexP
                return field{fEditable=read v}
              _ -> pfail

          readOnList :: [TipoDocto] -> ReadPrec [TipoDocto]
          readOnList list = do
            lex <- lexP
            case lex of
              EOF -> return list
              Punc "]" -> return list
              Punc "[" -> readOnList list
              Punc "," -> readOnList list
              Ident item -> do
                readOnList $ read item:list
              _ -> pfail

          readXpath :: [([String],String)] -> ReadPrec [([String],String)]
          readXpath list = do
            lex <- lexP
            case lex of
              EOF -> return list
              Punc "]" -> return list
              Punc "[" -> readXpath list
              Punc "(" -> do
                versiones <- readStringList []
                Punc "," <- lexP
                String path <- lexP
                rest <- readXpath list
                return $ (versiones,path):rest
              Punc "," -> readXpath list
              Punc ")" -> readXpath list
              _ -> pfail


          readStringList :: [String] -> ReadPrec [String]
          readStringList list = do
            lex <- lexP
            case lex of
              EOF -> return list
              Punc "]" -> return list
              Punc "," -> readStringList list
              Punc "[" -> readStringList list
              String item -> do
                rest <- readStringList list
                return $ item:rest
              _ -> pfail