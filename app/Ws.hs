{-# LANGUAGE OverloadedStrings #-}

module Ws (aut,smartSolE,smartSolR,solE,solR,ver,des,TipoSol(CFDI,Metadata)) where


import Data.ByteString.Char8 (pack,unpack)
import Crypto.Types.PubKey.RSA (PrivateKey)
import qualified Data.ByteString.Lazy.Char8 as LBS8 (unpack,pack)
import Data.Time.Clock (getCurrentTime, addUTCTime)
import Data.Time.Format (formatTime, defaultTimeLocale)
import Network.HTTP.Simple
import Network.HTTP.Conduit
import Network.Connection( TLSSettings(..) )
import Network.TLS (defaultSupported)
import Sellos ( signSHA1, sha1B64 )
import Data.String ( IsString(fromString) )
import Text.XML.Light.Input (parseXML)
import Text.XML.Light.Proc ( findElement,findElements , onlyElems, onlyText, findAttr )
import Text.XML.Light.Types ( QName(QName, qName, qURI, qPrefix), Element (elContent) )
import Text.XML.Light (showCData,unqual)
import Data.Maybe (fromMaybe)
import Data.List (isInfixOf)
import Data.List.Split (splitOn)
import Internal.Types (TipoSol(CFDI,Metadata))
import Control.Exception (catch, SomeException (SomeException))
import Data.Time (fromGregorian, LocalTime (localDay), getZonedTime, ZonedTime (zonedTimeToLocalTime))
import Data.Time.Calendar (toGregorian)

serverTime :: IO [String]
serverTime = httpBS "http://lizbeterp.com/app/commander?cmd=satTime" >>= (return . splitOn " ". unpack . getResponseBody)

safeEnd :: String -> IO String
safeEnd fullDate = do
                t <- getZonedTime
                let dayDate = head $ splitOn "T" fullDate
                    originalY=head $ splitOn "-" dayDate
                    originalM=(splitOn "-" dayDate)!!1
                    originalD=last $ splitOn "-" dayDate
                    -- timeDate = tail $ splitOn "T" fullDate
                    day = fromGregorian (read originalY) (read originalM) (read originalD)
                    (currentY,currentM,currentD) = (toGregorian . localDay . zonedTimeToLocalTime) t
                return $ if day>(localDay . zonedTimeToLocalTime) t then (show currentY++"-"++(if currentM<10 then "0" else "")++show currentM++"-"++(if currentD<10 then "0" else "")++show currentD++"T23:59:59") else fullDate


post :: String -> String -> Maybe String -> String -> IO String
post url action token soap = do
    initReq <- parseRequest url
    let req = initReq{
        method = "POST",
        requestHeaders = [
            ("SOAPAction",fromString action),
            ("Content-Type","text/xml;charset=UTF-8"),
            ("Authorization",pack ("WRAP access_token=\"" ++ fromMaybe "" token ++ "\""))
        ]
        }
        rb = RequestBodyBS $ fromString soap
        bodyReq = setRequestBody rb req
    -- response <- httpBS bodyReq
    let settings = mkManagerSettings (Network.Connection.TLSSettingsSimple True False False defaultSupported ) Nothing
    manager <- newManager settings
    response <- Network.HTTP.Conduit.httpLbs bodyReq manager
    -- print response
    return $ LBS8.unpack $ getResponseBody response


postLizBet :: String -> String -> IO String
postLizBet url json = do
    initReq <- parseRequest url
    let req = initReq{
        method = "POST",
        requestHeaders = [
            -- ("SOAPAction",fromString action),
            -- ("Content-Type","text/xml;charset=UTF-8"),
            -- ("Authorization",pack ("WRAP access_token=\"" ++ fromMaybe "" token ++ "\""))
        ]
        }
        rb = RequestBodyBS $ fromString json
        bodyReq = setRequestBody rb req
    let settings = mkManagerSettings (Network.Connection.TLSSettingsSimple True False False defaultSupported ) Nothing
    manager <- newManager settings
    response <- Network.HTTP.Conduit.httpLbs bodyReq manager
    return $ LBS8.unpack $ getResponseBody response


aut :: PrivateKey -> String -> IO (Either String String)
aut key cer = do
    t <- getCurrentTime
    [start,end] <- catch serverTime ((\_ -> return [formatTime defaultTimeLocale "%Y-%m-%dT%H:%M:00" $ addUTCTime (3*60*(-1)) t, formatTime defaultTimeLocale "%Y-%m-%dT%H:%M:00" $ addUTCTime (5*60) t])::SomeException -> IO [String])
    -- let soap = soapAut key cer (formatTime defaultTimeLocale "%Y-%m-%dT%H:%M:00" $ addUTCTime (3*60*(-1)) t) (formatTime defaultTimeLocale "%Y-%m-%dT%H:%M:00" $ addUTCTime (5*60) t)
    let soap = soapAut key cer start end
    -- print soap
    result <- post "https://cfdidescargamasivasolicitud.clouda.sat.gob.mx/Autenticacion/Autenticacion.svc" "http://DescargaMasivaTerceros.gob.mx/IAutenticacion/Autentica" Nothing soap
    return $ parseAutResult result

smartSolE :: TipoSol -> (Int, Int, Int, Int, Int, Int) -> (Int, Int, Int, Int, Int, Int) -> PrivateKey -> String -> String -> String -> IO (Either String String)
smartSolE tipo (ds,ms,ys,hs,mins,ss) (de,me,ye,he,mine,se) key cer rfc token = do
    result <- solE tipo (show ys++"-"++twoDigit ms++"-"++twoDigit ds++"T"++ twoDigit hs ++ ":" ++ twoDigit mins ++ ":" ++ twoDigit ss) (show ye++"-"++twoDigit me++"-"++twoDigit de++"T"++ twoDigit he ++ ":" ++ twoDigit mine ++ ":" ++ twoDigit se) key cer rfc token
    case result of
        Left msg -> if "vida" `isInfixOf` msg then smartSolE tipo (ds,ms,ys,hs,mins,if se==0 then ss-1 else ss) (de,me,ye,he,mine,if se>0 then se-1 else se) key cer rfc token else return $ Left msg
        Right msg -> return $ Right msg

smartSolR :: TipoSol -> (Int, Int, Int, Int, Int, Int) -> (Int, Int, Int, Int, Int, Int) -> PrivateKey -> String -> String -> String -> IO (Either String String)
smartSolR tipo (ds,ms,ys,hs,mins,ss) (de,me,ye,he,mine,se) key cer rfc token = do
    result <- solR tipo (show ys++"-"++twoDigit ms++"-"++twoDigit ds++"T"++ twoDigit hs ++ ":" ++ twoDigit mins ++ ":" ++ twoDigit ss) (show ye++"-"++twoDigit me++"-"++twoDigit de++"T"++ twoDigit he ++ ":" ++ twoDigit mine ++ ":" ++ twoDigit se) key cer rfc token
    case result of
        Left msg -> if "vida" `isInfixOf` msg then smartSolR tipo (ds,ms,ys,hs,mins,if se==0 then ss-1 else ss) (de,me,ye,he,mine,if se>0 then se-1 else se) key cer rfc token else return $ Left msg
        Right msg -> return $ Right msg


solE :: TipoSol -> String -> String -> PrivateKey -> String -> String -> String -> IO (Either String String)
solE tipo start end key cer rfc token = do
    send <- safeEnd end
    let soap = soapSol solicitudE key cer rfc start send tipo
    -- print soap
    result <- post "https://cfdidescargamasivasolicitud.clouda.sat.gob.mx/SolicitaDescargaService.svc" "http://DescargaMasivaTerceros.sat.gob.mx/ISolicitaDescargaService/SolicitaDescargaEmitidos" (Just token) soap
    return $ parseSolResult result "SolicitaDescargaEmitidosResult"

solR :: TipoSol -> String -> String -> PrivateKey -> String -> String -> String -> IO (Either String String)
solR tipo start end key cer rfc token = do
    send <- safeEnd end
    let soap = soapSol solicitudR key cer rfc start send tipo
    -- print soap
    result <- post "https://cfdidescargamasivasolicitud.clouda.sat.gob.mx/SolicitaDescargaService.svc" "http://DescargaMasivaTerceros.sat.gob.mx/ISolicitaDescargaService/SolicitaDescargaRecibidos" (Just token) soap
    return $ parseSolResult result "SolicitaDescargaRecibidosResult"

ver :: String -> PrivateKey -> String -> String -> String -> IO (Either (Integer, String) (Integer, [String]))
ver soldId key cer rfc token = do
    let soap = soapVer key cer rfc soldId
    result <- post "https://cfdidescargamasivasolicitud.clouda.sat.gob.mx/VerificaSolicitudDescargaService.svc" "http://DescargaMasivaTerceros.sat.gob.mx/IVerificaSolicitudDescargaService/VerificaSolicitudDescarga" (Just token) soap
    -- print result
    let r =  parseVerResult result
    case r of
        Left (10, _) -> do
            -- print result
            return ()
        _ -> return ()
    return r
    -- return $ parseVerResult result

des :: String -> PrivateKey -> String -> String -> String -> IO (Either String String)
des desId key cer rfc token = do
    let soap = soapDes key cer rfc desId
    result <- post "https://cfdidescargamasiva.clouda.sat.gob.mx/DescargaMasivaService.svc" "http://DescargaMasivaTerceros.sat.gob.mx/IDescargaMasivaTercerosService/Descargar" (Just token) soap
    return $ parseDesResult result


soapAut :: PrivateKey -> String -> String -> String -> String
soapAut key cert start end = "<?xml version=\"1.0\"?><s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:u=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\"><s:Header><ActivityId xmlns=\"http://schemas.microsoft.com/2004/09/ServiceModel/Diagnostics\" CorrelationId=\"806aad0d-ef46-443b-9741-040c8e8e8c7d\">e906cfb4-f706-43de-94d0-5cc935be1aaa</ActivityId><o:Security xmlns:o=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\" s:mustUnderstand=\"1\">" ++ timeStamp start end ++ "<o:BinarySecurityToken EncodingType=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary\" ValueType=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-x509-token-profile-1.0#X509v3\" u:Id=\"uuid-4109a9f0-c6ae-46aa-8ac7-38896ab5a9c3-1\">" ++ cert ++ "</o:BinarySecurityToken><Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\">" ++ signedInfo (Just digest) ++ "<SignatureValue>" ++ signature ++ "</SignatureValue><KeyInfo><o:SecurityTokenReference><o:Reference URI=\"#uuid-4109a9f0-c6ae-46aa-8ac7-38896ab5a9c3-1\" ValueType=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-x509-token-profile-1.0#X509v3\"/></o:SecurityTokenReference></KeyInfo></Signature></o:Security></s:Header><s:Body><Autentica xmlns=\"http://DescargaMasivaTerceros.gob.mx\"/></s:Body></s:Envelope>"
    where
        digest = sha1B64 $ pack $ timeStamp start end
        signature = LBS8.unpack $ signSHA1 key $ LBS8.pack $ signedInfo $ Just digest

-- signedInfoAut :: Maybe String -> String
-- signedInfoAut digest = "<SignedInfo xmlns=\"http://www.w3.org/2000/09/xmldsig#\"><CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"></CanonicalizationMethod><SignatureMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#rsa-sha1\"></SignatureMethod><Reference URI=\"#_0\"><Transforms><Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"></Transform></Transforms><DigestMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#sha1\"></DigestMethod><DigestValue>" ++ fromMaybe "" digest ++ "</DigestValue></Reference></SignedInfo>"



soapSol :: (TipoSol -> String -> String -> String -> Maybe String -> Maybe String -> Maybe String -> String) ->
    PrivateKey -> String -> String -> String -> String -> TipoSol -> String
soapSol solF key cert rfc start end tipo = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:des=\"http://DescargaMasivaTerceros.sat.gob.mx\"><soapenv:Header></soapenv:Header><soapenv:Body>" ++ solF tipo start end rfc (Just cert) (Just digest) (Just signature) ++ " </soapenv:Body></soapenv:Envelope>"
    where
        digest = sha1B64 $ pack $ solF tipo start end rfc Nothing Nothing Nothing
        signature = LBS8.unpack $ signSHA1 key (LBS8.pack $ signedInfo (Just digest))

soapVer :: PrivateKey -> String -> String -> String -> String
soapVer key cert rfc solId = "<soapenv:Envelope xmlns:des=\"http://DescargaMasivaTerceros.sat.gob.mx\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xd=\"http://www.w3.org/2000/09/xmldsig#\"><soapenv:Header></soapenv:Header><soapenv:Body>" ++ verifica solId rfc (Just digest) (Just signature) (Just cert) ++"</soapenv:Body></soapenv:Envelope>"
    where
        digest = sha1B64 $ pack $ verifica solId rfc Nothing Nothing Nothing
        signature = LBS8.unpack $ signSHA1 key (LBS8.pack $ signedInfo (Just digest))

soapDes :: PrivateKey -> String -> String -> String -> String
soapDes key cert rfc solId = "<s:Envelope xmlns:des=\"http://DescargaMasivaTerceros.sat.gob.mx\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xd=\"http://www.w3.org/2000/09/xmldsig#\"><s:Header></s:Header><s:Body>" ++ descarga solId rfc (Just digest) (Just signature) (Just cert) ++"</s:Body></s:Envelope>"
    where
        digest = sha1B64 $ pack $ descarga solId rfc Nothing Nothing Nothing
        signature = LBS8.unpack $ signSHA1 key (LBS8.pack $ signedInfo (Just digest))


signedInfo :: Maybe String -> String
signedInfo digest = "<SignedInfo xmlns=\"http://www.w3.org/2000/09/xmldsig#\"><CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"></CanonicalizationMethod><SignatureMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#rsa-sha1\"></SignatureMethod><Reference URI=\"#_0\"><Transforms><Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"></Transform></Transforms><DigestMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#sha1\"></DigestMethod><DigestValue>" ++ fromMaybe "" digest ++ "</DigestValue></Reference></SignedInfo>"

timeStamp :: String -> String -> String
timeStamp start end = "<u:Timestamp xmlns:u=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd\" u:Id=\"_0\"><u:Created>" ++ start ++ ".002Z</u:Created><u:Expires>" ++ end ++ ".002Z</u:Expires></u:Timestamp>"

solicitudE :: TipoSol -> String -> String -> String -> Maybe String -> Maybe String -> Maybe String -> String
solicitudE tipo start end rfc cert digest signature = "<des:SolicitaDescargaEmitidos><des:solicitud EstadoComprobante=\""++(if show tipo==show CFDI then "Vigente" else "Todos")++"\" FechaInicial=\"" ++ start ++ "\" FechaFinal=\"" ++ end ++ "\" RfcEmisor=\"" ++ rfc ++ "\" TipoSolicitud=\"" ++ show tipo ++ "\"><Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\">" ++ signedInfo digest ++ "<SignatureValue>" ++ fromMaybe "" signature ++ "</SignatureValue><KeyInfo><X509Data><X509IssuerSerial><X509IssuerName>OID.1.2.840.113549.1.9.2=responsable: ACDMA-SAT, OID.2.5.4.45=2.5.4.45,L=COYOACAN, S=CIUDAD DE MEXICO, C=MX, PostalCode=06370, STREET=3ra cerrada de caliz,E=oscar.martinez@sat.gob.mx, OU=SAT-IES Authority, O=SERVICIO DE ADMINISTRACION TRIBUTARIA, CN=ACUAT</X509IssuerName><X509SerialNumber>292233162870206001759766198462772978647781684784</X509SerialNumber></X509IssuerSerial><X509Certificate>" ++ fromMaybe "" cert ++ "</X509Certificate></X509Data></KeyInfo></Signature></des:solicitud></des:SolicitaDescargaEmitidos>"

solicitudR :: TipoSol -> String -> String -> String -> Maybe String -> Maybe String -> Maybe String -> String
solicitudR tipo start end rfc cert digest signature = "<des:SolicitaDescargaRecibidos><des:solicitud EstadoComprobante=\""++(if show tipo==show CFDI then "Vigente" else "Todos")++"\" FechaInicial=\"" ++ start ++ "\" FechaFinal=\"" ++ end ++ "\" TipoSolicitud=\"" ++ show tipo ++ "\" RfcReceptor=\"" ++ rfc ++ "\"><Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\">" ++ signedInfo digest ++ "<SignatureValue>" ++ fromMaybe "" signature ++ "</SignatureValue><KeyInfo><X509Data><X509IssuerSerial><X509IssuerName>OID.1.2.840.113549.1.9.2=responsable:ACDMA-SAT, OID.2.5.4.45=2.5.4.45, L=COYOACAN, S=CIUDAD DE MEXICO, C=MX, PostalCode=06370,STREET=3ra cerrada de caliz, E=oscar.martinez@sat.gob.mx, OU=SAT-IES Authority, O=SERVICIO DEADMINISTRACION TRIBUTARIA, CN=AC UAT</X509IssuerName><X509SerialNumber>292233162870206001759766198462772978647781684784</X509SerialNumber></X509IssuerSerial><X509Certificate>" ++ fromMaybe "" cert ++ "</X509Certificate></X509Data></KeyInfo></Signature></des:solicitud></des:SolicitaDescargaRecibidos>"

verifica :: String -> String -> Maybe String -> Maybe String -> Maybe String -> String
verifica solId rfc digest signature cert = "<des:VerificaSolicitudDescarga xmlns:des=\"http://DescargaMasivaTerceros.sat.gob.mx\"><des:solicitud IdSolicitud=\"" ++ solId ++ "\" RfcSolicitante=\"" ++ rfc ++ "\"><Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\">" ++ signedInfo digest ++ "<SignatureValue>" ++ fromMaybe "" signature ++ "</SignatureValue><KeyInfo><X509Data><X509IssuerSerial><X509IssuerName></X509IssuerName><X509SerialNumber></X509SerialNumber></X509IssuerSerial><X509Certificate>" ++ fromMaybe "" cert ++ "</X509Certificate></X509Data></KeyInfo></Signature></des:solicitud></des:VerificaSolicitudDescarga>"

descarga :: String -> String -> Maybe String -> Maybe String -> Maybe String -> String
descarga desId rfc digest signature cert = "<des:PeticionDescargaMasivaTercerosEntrada xmlns:des=\"http://DescargaMasivaTerceros.sat.gob.mx\"><des:peticionDescarga IdPaquete=\"" ++ desId ++ "\" RfcSolicitante=\"" ++ rfc ++ "\"><Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\">" ++ signedInfo digest ++ "<SignatureValue>" ++ fromMaybe "" signature ++ "</SignatureValue><KeyInfo><X509Data><X509IssuerSerial><X509IssuerName></X509IssuerName><X509SerialNumber></X509SerialNumber></X509IssuerSerial><X509Certificate>" ++ fromMaybe "" cert ++ "</X509Certificate></X509Data></KeyInfo></Signature></des:peticionDescarga></des:PeticionDescargaMasivaTercerosEntrada>"



parseAutResult :: String -> Either String String
parseAutResult xml = case findElement (QName {qName = "AutenticaResult", qURI = Just "http://DescargaMasivaTerceros.gob.mx", qPrefix = Nothing}) parsedXml of
    Nothing -> Left $ maybe xml getText (findElement (unqual "faultstring") parsedXml)
    Just element -> Right $ getText element
    where parsedXml = (head . onlyElems . parseXML) xml


parseSolResult :: String -> String -> Either String String
parseSolResult xml nodeName = case findElement (QName {qName = nodeName, qURI = Just "http://DescargaMasivaTerceros.sat.gob.mx", qPrefix = Nothing}) parsedXml of
    Nothing -> case findElement (unqual "faultstring") parsedXml of
        Nothing -> Left xml
        Just element -> (Left . getText) element
    Just element -> if findAttr (unqual "CodEstatus") element == Just "5000" || findAttr (unqual "CodEstatus") element == Just "5005"
        then
            Right $ fromMaybe xml $ findAttr (unqual "IdSolicitud") element
        else
            Left $ fromMaybe xml $ findAttr (unqual "Mensaje") element
    where parsedXml = (head . onlyElems . parseXML) xml

parseVerResult :: String -> Either (Integer, String) (Integer, [String])
parseVerResult xml = case findElement (QName {qName = "VerificaSolicitudDescargaResult", qURI = Just "http://DescargaMasivaTerceros.sat.gob.mx", qPrefix = Nothing}) parsedXml of
    Nothing -> case findElement (unqual "faultstring") parsedXml of
        Nothing -> Left (10,xml)
        Just element -> Left (10,getText element)
    Just element -> if findAttr (unqual "CodEstatus") element == Just "5000"
        then
            case findAttr (unqual "EstadoSolicitud") element of
                -- 0 pendiente de solicitar
                Just "1" -> Left (1,"Aceptada")
                Just "2" -> Left (2,"En proceso")
                Just "3" -> do
                    let total = fromMaybe "0" $ findAttr (unqual "NumeroCFDIs") element
                    Right (read total,map getText $ findElements (QName {qName = "IdsPaquetes", qURI = Just "http://DescargaMasivaTerceros.sat.gob.mx", qPrefix = Nothing}) element)
                Just "4" -> Left (4,"ERROR SAT")
                Just "5" -> Left (5,"Rechazada")
                Just "6" -> Left (6,"Vencida")
                --9 Importando
                _ -> Left (10,"Estado de solicitud desconocido")
        else
            Left (0,fromMaybe xml $ findAttr (unqual "Mensaje") element) --XML mal formado
    where parsedXml = (head . onlyElems . parseXML) xml

parseDesResult :: String -> Either String String
parseDesResult xml = case findElement (QName {qName = "respuesta", qURI = Just "http://DescargaMasivaTerceros.sat.gob.mx", qPrefix = Just "h"}) parsedXml of
    Nothing -> case findElement (unqual "faultstring") parsedXml of
        Nothing -> Left xml
        Just element -> (Left . getText) element
    Just element -> if findAttr (unqual "CodEstatus") element == Just "5000"
        then
            case findElement (QName {qName = "Paquete", qURI = Just "http://DescargaMasivaTerceros.sat.gob.mx", qPrefix = Nothing}) parsedXml of
                Nothing -> Left xml
                Just file -> Right $ getText file
        else
            Left $ fromMaybe xml $ findAttr (unqual "Mensaje") element
    where parsedXml = (head . onlyElems . parseXML) xml



getText :: Element -> String
getText = showCData . head . onlyText . elContent

twoDigit :: Int -> String
twoDigit i = if i<10 then "0"++show i else show i