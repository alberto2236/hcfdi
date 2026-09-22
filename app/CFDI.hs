{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}


module CFDI where

import Text.XML.Light
import Data.Maybe
-- import Text.XML.HXT.Core
import Text.XML.HXT.XSLT               ( xsltApplyStylesheetFromURI )
import Text.XML.HXT.Curl (withCurl)
import Text.XML.HXT.Core (runX)
import Text.XML.HXT.Arrow.XmlState
import Control.Arrow
import Text.XML.HXT.Arrow.ReadDocument
import Text.XML.HXT.Arrow.WriteDocument
import Sellos (signSHA256, getFiel, getCsd, signSHA1, getNoCert, CSD)
import qualified Data.ByteString.Lazy.Char8 as LBS8 (unpack,pack)
import qualified Data.ByteString.Char8 as BS8 (unpack,pack)
import Crypto.Types.PubKey.RSA (PrivateKey)
import Data.X509 (Certificate)
import System.Exit (die)
import Network.HTTP.Simple
import Network.HTTP.Conduit
import Data.String (fromString)
import Data.Time.Clock (getCurrentTime)
import Data.Time.Format (defaultTimeLocale, formatTime)
import Data.Time (getZonedTime)
import CFDI.Complementos.Pago
import CFDI.Types
import CFDI.Complementos.Complemento (CualquierComplemento (..), Complemento (getNameSpaces', crearComplemento'), getNameSpaces, getSchema, crearComplemento)
import CFDI.Utils




class DOCSAT t where
    toXml :: t -> String
    sellar :: CSD -> t -> IO t

cfdiName :: String -> QName
cfdiName nombre = QName nombre Nothing $ Just "cfdi"


loadFiel :: IO (PrivateKey,Data.X509.Certificate,String)
loadFiel = do
    let keyPath = "/Users/alberto/Documents/csd.key"
        cerPath = "/Users/alberto/Documents/csd.cer"
        pass = "trancilvania_2236_SAT"
    fiel' <- getCsd keyPath cerPath pass
    case fiel' of
        Left msg -> die msg
        Right fiel -> return fiel

fechaCFDI :: IO String
fechaCFDI = do
    formatTime defaultTimeLocale "%Y-%m-%dT%H:%M:%S" <$> getZonedTime

crearEgreso40 :: Generales -> Emisor -> Receptor -> [Concepto] -> CFDI
crearEgreso40 generales emisor receptor conceptos = CFDI40 "E"
            generales
            []
            emisor
            receptor
            conceptos
            Nothing
            []
crearIngreso40 :: Generales -> Emisor -> Receptor -> [Concepto] -> CFDI
crearIngreso40 generales emisor receptor conceptos = CFDI40 "I"
            generales
            []
            emisor
            receptor
            conceptos
            Nothing
            []


generalesIngreso :: Generales
generalesIngreso = Generales{gExportacion="01",gFecha="",gSerie=Nothing,gFolio=Nothing,
                        gFormaPago=Just "99",gMetodoPago=Just "PPD",gMoneda="MXN",gTipoCambio=Just "1",
                        gDescuento=Nothing,gSubTotal="0",gTotal="0"}
generalesPago :: Generales
generalesPago = Generales{gExportacion="01",gFecha="",gSerie=Nothing,gFolio=Nothing,
                        gFormaPago=Nothing,gMetodoPago=Nothing,gMoneda="XXX",gTipoCambio=Nothing,
                        gDescuento=Nothing,gSubTotal="0",gTotal="0"}

main :: IO ()
main = do
    csd <- loadFiel
    fecha <- fechaCFDI
    let cfdi = (crearEgreso40
                generalesIngreso{gFecha=fecha,gSerie=Just "F",gFolio=Just "8765",
                    gFormaPago=Just "99",gMetodoPago=Just "PPD",gMoneda="MXN",gTipoCambio=Just "1",
                    gDescuento=Just "43.10",gSubTotal="215.52",gTotal="200.01"}
                (Emisor "ALBERTO SANDOVAL SOTELO" "SASA841007CR8" "612" "14100")
                (Receptor "GALES-AP" "GAL191112RK8" "601" "54753" "G03")
                [
                Concepto "1.00" (Just "Pieza") "H87" "43232400" (Just "P25") "Paquete de 25 timbres Para: RAQUEL DEL ROSARIO RUIZ MORELL" "215.52" (Just "43.10") "215.52" "02"
                    [
                        Traslado "172.42" "27.59" "002" 0.160000 "Tasa"
                    ]
                ]
                ){cfdiRelacionados = [
                    Relacion "04" ["60C0D800-B0D6-4CA8-9A3F-DC86FB660075","60C0D800-B0D6-4CA8-9A3F-DC86FB660076","60C0D800-B0D6-4CA8-9A3F-DC86FB660077"],
                    Relacion "01" ["60C0D800-B0D6-4CA8-9A3F-DC86FB660074","60C0D800-B0D6-4CA8-9A3F-DC86FB660073","60C0D800-B0D6-4CA8-9A3F-DC86FB660072"]
                ]}
    -- let cfdi = crearPago20
    --             generalesPago{gExportacion="01",gFecha=fecha,gSerie=Just "P",gFolio=Just "0001"}
    --             (Emisor "ALBERTO SANDOVAL SOTELO" "SASA841007CR8" "612" "14100")
    --             (Receptor "GALES-AP" "GAL191112RK8" "601" "54753" "CP01")
    --             (crearComplementoPago20{cpPagos=[
    --                 Pago "2026-08-17T10:14:00" "03" "MXN" "1" "1.16" [
    --                     DocumentoRelacionado {drSerie="F", drFolio="8727", drIdDocumento="F83EDC41-52F7-4EEA-A518-1408141958EB", drImpPagado="1.16",
    --                         drImpSaldoAnt="1.16" ,drImpSaldoInsoluto="0.00",drNumParcialidad="1",drMoneda="MXN",drEquivalencia="1",drObjetoImp="02",
    --                         drImpuestos=[
    --                             Traslado "1.00" "0.16" "002" 0.16 "Tasa"
    --                         ]
    --                         }
    --                 ]
    --             ]
    --             })
    cfdiSellado <- sellar csd cfdi
    cfdiTimbrado <- timbrar "http://lizbeterp.com/app/api/timbrado?key=demo" (toXml cfdiSellado)
    putStrLn cfdiTimbrado

timbrar :: String -> String -> IO String
timbrar url xml = do
    initReq <- parseRequest url
    let req = initReq{
            method = "POST"
        }
        rb = RequestBodyBS $ fromString xml
        bodyReq = setRequestBody rb req
    response <- httpBS bodyReq
    -- print response
    return $ BS8.unpack $ getResponseBody response
cadena40 :: String -> IO String
cadena40 = cadenaOriginal "4.0.xslt"
cadenaOriginal ::  String -> String -> IO String
cadenaOriginal xslt xml = do
  cadena <- runX $
    configSysVars [withCurl []]
    >>>
    readString  [
                  withCheckNamespaces yes
                ] xml
    >>>
    xsltApplyStylesheetFromURI xslt
    >>>
    writeDocumentToString []
  return $ head cadena



instance DOCSAT CFDI where
    sellar :: CSD -> CFDI -> IO CFDI
    sellar (key,cert,b64cert) cfdi = do
        cadena <- cadena40 $ toXml (cfdi{cfdiSello=Just $ Sello (getNoCert cert) b64cert ""})
        let sello = LBS8.unpack $ signSHA256 key $ LBS8.pack cadena
        return $ cfdi{cfdiSello=Just $ Sello (getNoCert cert) b64cert sello}

    toXml :: CFDI -> String
    toXml (CFDI40 tipo generales relacionados emisor receptor conceptos (Just (Sello noCert cert sello)) complementos)  = do
        let xml=node (cfdiName "Comprobante") (catMaybes
                    (concatMap getNameSpaces complementos++[
                        Just $ Attr (QName "cfdi" Nothing $ Just "xmlns") "http://www.sat.gob.mx/cfd/4", Just $ Attr (QName "xsi" Nothing $ Just "xmlns") "http://www.w3.org/2001/XMLSchema-instance",
                        Just $ Attr (QName "schemaLocation" Nothing $ Just "xsi") ("http://www.sat.gob.mx/cfd/4 http://www.sat.gob.mx/sitio_internet/cfd/4/cfdv40.xsd " ++ concatMap getSchema complementos),
                        attr "TipoDeComprobante" tipo, attr "Version" "4.0", attr "LugarExpedicion" (eDomicilio emisor),
                        attr "Exportacion" (gExportacion generales), attr "Fecha" (gFecha generales), maybeAttr "Serie" (gSerie generales), maybeAttr "Folio" (gFolio generales),
                        maybeAttr "FormaPago" (gFormaPago generales), maybeAttr "MetodoPago" (gMetodoPago generales), attr "Moneda" (gMoneda generales), maybeAttr "TipoCambio" (gTipoCambio generales),
                        maybeAttr "Descuento" (gDescuento generales), attr "SubTotal" (gSubTotal generales), attr "Total" (gTotal generales),
                        attr "NoCertificado" noCert, attr "Certificado" cert, attr "Sello" sello
                    ]),
                catMaybes (
                    map crearRelacionado relacionados++[
                    Just $ node (cfdiName "Emisor") $ catMaybes [attr "Nombre" (eNombre emisor),attr "Rfc" (eRfc emisor),attr "RegimenFiscal" (eRegimen emisor)],
                    Just $ node (cfdiName "Receptor") $ catMaybes [attr "Nombre" (rNombre receptor),attr "Rfc" (rRfc receptor),attr "DomicilioFiscalReceptor" (rDomicilio receptor),attr "RegimenFiscalReceptor" (rRegimen receptor), attr "UsoCFDI" (rUso receptor)],
                    Just $ node (cfdiName "Conceptos") $ map crearConcepto conceptos,
                    if (not.null) traslados || (not.null) retenciones then
                                Just $ node (cfdiName "Impuestos") (
                                    catMaybes [
                                        maybeAttr "TotalImpuestosRetenidos" totalRetenciones,
                                        maybeAttr "TotalImpuestosTrasladados" totalTraslados
                                    ],
                                    catMaybes [
                                        if (not.null) traslados then Just $ node (cfdiName "Traslados") $ map (crearTraslado (cfdiName "Traslado") "") traslados else Nothing,
                                        if (not.null) retenciones then Just $ node (cfdiName "Retenciones") $ map (crearRetencion (cfdiName "Retencion") "") retenciones else Nothing
                                    ])
                              else Nothing
                ]++[if null complementos then Nothing else
                    Just $ node (cfdiName "Complemento") $ map crearComplemento complementos
                ])
                )
        ppTopElement xml
        where totalesImpuestos = getImpuestosConceptos conceptos
              retenciones = filter esRetencion totalesImpuestos
              traslados = filter esTraslado totalesImpuestos
              totalRetenciones = Just $ show $ round2Dec $ foldr (\impuesto a -> a+read (impImporte impuesto)) 0 retenciones
              totalTraslados =  Just $ show $ round2Dec $ foldr (\impuesto a -> a+read (impImporte impuesto)) 0 traslados
              crearConcepto (Concepto cantidad unidad claveUnidad claveProdServ noIdentificacion descripcion valorUnitario descuento importe objetoImp impuestos) =
                node (cfdiName "Concepto") (catMaybes [
                    attr "Cantidad" cantidad,maybeAttr "Unidad" unidad,attr "ClaveUnidad" claveUnidad,attr "ClaveProdServ" claveProdServ,
                    maybeAttr "NoIdentificacion" noIdentificacion,attr "Descripcion" descripcion,attr "ValorUnitario" valorUnitario,
                    maybeAttr "Descuento" descuento,attr "Importe" importe,attr "ObjetoImp" objetoImp
                ],
                    catMaybes [if (not.null) traslados || (not.null) retenciones then
                                Just $ node (cfdiName "Impuestos") $ catMaybes [
                                    if (not.null) traslados then Just $ node (cfdiName "Traslados") $ map (crearTraslado (cfdiName "Traslado") "") traslados else Nothing,
                                    if (not.null) retenciones then Just $ node (cfdiName "Retenciones") $ map (crearRetencion (cfdiName "Retencion") "") retenciones else Nothing
                                ]
                              else Nothing]
                )
                where traslados = filter esTraslado impuestos
                      retenciones = filter esRetencion impuestos
              crearRelacionado (Relacion tipo uuids) = Just $
                node (cfdiName "CfdiRelacionados")  ([Attr (unqual "TipoRelacion") tipo] ,
                map (\uuid -> node (cfdiName "CfdiRelacionado") [Attr (unqual "UUID") uuid]) uuids)
              getImpuestosConceptos :: [Concepto] -> [Impuestos]
              getImpuestosConceptos = agruparImpuestos . concatMap cImpuestos

