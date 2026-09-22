{-# LANGUAGE OverloadedStrings #-}


module Sellos (getKey,getCert,getRfc,getNombre,getTipo,signSHA256,signSHA1,sha1B64,getB64Cert,vigente,getFielCsd,validar,
                validarFiel,validarCsd,getFinVigencia,getFinVigenciaSql,getFiel,getCsd,getInitVigencia,getNoCert,CSD,FIEL) where

import Crypto.Store.PKCS8 ( readKeyFileFromMemory, recover, toProtectionPassword)
import Crypto.Store.X509 ( readSignedObjectFromMemory)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BS8
import qualified Data.ByteString.Base64 as B64
import Data.ByteString.Lazy (readFile,ByteString, index)
import Data.ByteString.Lazy.Char8 (unpack)
import Data.ByteString.Lazy.Base64 ( encodeBase64' )
import Data.X509 (SignedCertificate, PrivKey(PrivKeyRSA), PubKey(PubKeyRSA), Certificate (certSubjectDN,certPubKey, certExtensions, certValidity, certSerial),
    DistinguishedName (getDistinguishedElements),Extensions (Extensions), ASN1CharacterString (getCharacterStringRawData),getCertificate)
import Codec.Crypto.RSA.Pure (hashSHA1,hashSHA256,rsassa_pkcs1_v1_5_sign,sign,verify)
import Crypto.Types.PubKey.RSA (PrivateKey,PublicKey)
import Crypto.Store.Error (StoreError(DecryptionFailed,ParseFailure))
import qualified Crypto.Hash.SHA1 as SHA1
import Data.Hourglass (timePrint, TimeFormatString (TimeFormatString), TimeFormatElem (Format_Year4, Format_Text, Format_Month2, Format_Day2), Timeable (timeGetElapsed))
import System.Hourglass (timeCurrent)
import Data.Maybe (fromJust)
import Data.Either.Extra (fromRight')
import Data.Word (Word8)
import Data.Bits (shiftR, (.&.))

type KeyPath = String
type CerPath = String
type FielPass = String
type CSD = (PrivateKey,Certificate,String)
type FIEL = (PrivateKey,Certificate,String)

getFielCsd :: KeyPath -> CerPath -> FielPass -> IO (Either String (PrivateKey,Certificate,String))
getFielCsd keyPath cerPath pass = do
    cert <- getCert cerPath
    b64Cert <- getB64Cert cerPath
    key <- getKey keyPath pass
    return $ case cert of
        Nothing -> Left "archivo .cer invalido"
        Just c -> case key of
            Left err -> Left err
            Right k -> Right (k, c,b64Cert)
getFiel :: KeyPath -> CerPath -> FielPass -> IO (Either String (PrivateKey,Certificate,String))
getFiel keyPath cerPath pass = do
    cert <- getCert cerPath
    b64Cert <- getB64Cert cerPath
    key <- getKey keyPath pass
    valid <- validarFiel key cert
    return $ case cert of
        Nothing -> Left "archivo .cer invalido"
        Just c -> case key of
            Left err -> Left err
            Right k -> case valid of
                Nothing -> Right (k, c,b64Cert)
                Just err -> Left err
getCsd :: KeyPath -> CerPath -> FielPass -> IO (Either String (PrivateKey,Certificate,String))
getCsd keyPath cerPath pass = do
    cert <- getCert cerPath
    b64Cert <- getB64Cert cerPath
    key <- getKey keyPath pass
    valid <- validarCsd key cert
    return $ case cert of
        Nothing -> Left "archivo .cer invalido"
        Just c -> case key of
            Left err -> Left err
            Right k -> case valid of
                Nothing -> Right (k, c,b64Cert)
                Just err -> Left err

getKey :: String -> String ->  IO (Either String PrivateKey)
getKey keyPath pass = do
    pemKey <- getPEMKey keyPath
    let rawKey = readKeyFileFromMemory $ BS8.pack pemKey
        key' = if null rawKey then Left $ ParseFailure "Archivo .key incorrecto" else recover (toProtectionPassword $ BS8.pack pass) $ head rawKey
        key = getPrivateKey key'
    return key

getPrivateKey :: Either StoreError PrivKey -> Either String PrivateKey
getPrivateKey e = case e of
    Left err -> case err of
        ParseFailure s -> Left s
        DecryptionFailed -> Left "Contraseña invalida"
        _ -> Left "Error desconocido en archivo .key"
    Right pk -> case pk of
        PrivKeyRSA x -> Right (read (show x) :: Crypto.Types.PubKey.RSA.PrivateKey) --Se transforma
        _ -> Left "Llave privada desconocida"

getCert :: String ->  IO (Maybe Certificate)
getCert cerPath = do
    pemCer <- getPEMCer cerPath
    let c' = readSignedObjectFromMemory $ BS8.pack pemCer :: [SignedCertificate]
        c= if null c' then Nothing else Just $ getCertificate $ head c'
    return c

getRfc :: Certificate -> String
getRfc cert = rfc
    where (_,rfc') = if length (getDistinguishedElements $ certSubjectDN cert) == 6 -- Personas morales 5 elementos 6 para fisicas
            then
                getDistinguishedElements (certSubjectDN cert) !! 3
            else
                getDistinguishedElements (certSubjectDN cert) !! 5
          tmpRfc = BS8.unpack $ getCharacterStringRawData rfc'
          rfc = if length tmpRfc >13 then head $ words tmpRfc else tmpRfc

splitToBytes :: Integer -> [Word8]
splitToBytes 0 = []
splitToBytes n = fromIntegral (n .&. 0xFF) : splitToBytes (n `shiftR` 8)

getNoCert :: Certificate -> String
getNoCert cert = map (toEnum . fromEnum) $ reverse $ splitToBytes $ certSerial cert

getNombre :: Certificate -> String
getNombre cert = BS8.unpack (getCharacterStringRawData nombre)
    where (_,nombre) = getDistinguishedElements (certSubjectDN cert) !! 1

getTipo :: Certificate -> String
getTipo cert = if length exts > 2 then "FIEL" else "CSD"
    where Extensions (Just exts) = certExtensions cert

isFiel :: Certificate -> Bool
isFiel cert = getTipo cert == "FIEL"

isCsd :: Certificate -> Bool
isCsd cert = getTipo cert == "CSD"

getInitVigencia :: Certificate -> String
getInitVigencia cert = let (start,_) = certValidity cert
    in timePrint (TimeFormatString [Format_Day2,Format_Text '/',Format_Month2,Format_Text '/',Format_Year4]) start

getFinVigencia :: Certificate -> String
getFinVigencia cert = let (_,fin) = certValidity cert
    in timePrint (TimeFormatString [Format_Day2,Format_Text '/',Format_Month2,Format_Text '/',Format_Year4]) fin

getFinVigenciaSql :: Certificate -> String
getFinVigenciaSql cert = let (_,fin) = certValidity cert
    in timePrint (TimeFormatString [Format_Year4,Format_Text '-',Format_Month2,Format_Text '-',Format_Day2]) fin

vigente :: Certificate -> IO Bool
vigente cert = do
    let (_,fin) = certValidity cert
    t <- timeCurrent
    return $ timeGetElapsed fin > t

validar :: PrivateKey -> Certificate -> Bool
validar k c =
    let pk = case certPubKey c of
            PubKeyRSA pk' -> pk'
        Right s = sign k "Hola mundo!"
    in case verify (read (show pk) :: Crypto.Types.PubKey.RSA.PublicKey) "Hola mundo!" s of
        Left _ -> False
        Right r -> r

getB64Cert :: String -> IO String
getB64Cert path = do
    der <- BS.readFile path
    return $ BS8.unpack $ B64.encodeBase64' der

getPEMKey :: String -> IO String
getPEMKey path = do
    der <- Data.ByteString.Lazy.readFile path
    let x = encodeBase64' der
    return $ unlines ["-----BEGIN ENCRYPTED PRIVATE KEY-----",unpack x,"-----END ENCRYPTED PRIVATE KEY-----"]

getPEMCer :: String -> IO String
getPEMCer path = do
    der <- Data.ByteString.Lazy.readFile path
    let x = encodeBase64' der
    return $ unlines ["-----BEGIN CERTIFICATE-----",unpack x,"-----END CERTIFICATE-----"]

signSHA1 :: PrivateKey -> ByteString -> ByteString
signSHA1 key dat = case sello of
    Right s -> encodeBase64' s
    Left _ -> ""
    where sello = rsassa_pkcs1_v1_5_sign hashSHA1 key dat

signSHA256 :: PrivateKey -> ByteString -> ByteString
signSHA256 key dat = case sello of
    Right s -> encodeBase64' s
    Left _ -> ""
    where sello = rsassa_pkcs1_v1_5_sign hashSHA256 key dat

sha1B64 :: BS.ByteString -> String
sha1B64 s = BS8.unpack $ B64.encodeBase64' $ SHA1.hash s


validarFiel :: Either String PrivateKey -> Maybe Certificate -> IO (Maybe String)
validarFiel (Left e) _  = return $ Just e
validarFiel _ Nothing  = return $ Just "Archivo .cer invalido"
validarFiel (Right k) (Just c) = if validar k c then
        if not $ isFiel c then
            return $ Just "Los archivos no son de tipo FIEL."
        else do
            v <- vigente c
            if not v then
                return $ Just "La FIEL se encuentra vencida."
            else
                return Nothing
    else
        return $ Just "La pareja de archivos no corresponden, probablemente mezclados."

validarCsd :: Either String PrivateKey -> Maybe Certificate -> IO (Maybe String)
validarCsd (Left e) _  = return $ Just e
validarCsd _ Nothing  = return $ Just "Archivo .cer invalido"
validarCsd (Right k) (Just c) = if validar k c then
        if not $ isCsd c then
            return $ Just "Los archivos no son de tipo CSD."
        else do
            v <- vigente c
            if not v then
                return $ Just "El CSD se encuentra vencido."
            else
                return Nothing
    else
        return $ Just "La pareja de archivos no corresponden, probablemente mezclados."