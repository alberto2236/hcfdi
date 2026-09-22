{-# LANGUAGE InstanceSigs #-}

module CFDI.Types where
import CFDI.Complementos.Complemento


data Generales = Generales {gExportacion::String,gFecha::String,gSerie::Maybe String,gFolio::Maybe String,
                            gFormaPago::Maybe String,gMetodoPago::Maybe String,gMoneda::String,gTipoCambio::Maybe String,
                            gDescuento::Maybe String,gSubTotal::String,gTotal::String} deriving (Show)
data Sello = Sello {sNoCertificado::String,sCertificado::String,sSello::String} deriving (Show)
data Emisor = Emisor {eNombre::String, eRfc::String, eRegimen::String, eDomicilio::String} deriving (Show)
data Receptor = Receptor {rNombre::String, rRfc::String, rRegimen::String, rDomicilio::String, rUso::String} deriving (Show)

data Impuestos = Traslado {impBase::String, impImporte::String, impImpuesto::String, impTasaOCuota::Float, impTipoFactor::String} |
                 Retencion {impBase::String, impImporte::String, impImpuesto::String, impTasaOCuota::Float, impTipoFactor::String} deriving (Show)

data CFDI = CFDI40 {cfdiTipo::String,cfdiGenerales::Generales,cfdiRelacionados::[Relacion],
                        cfdiEmisor::Emisor,cfdiReceptor::Receptor,cfdiConceotos::[Concepto],
                        cfdiSello::Maybe Sello,cfdiComplementos::[CualquierComplemento]}

type UUID = String
data Concepto = Concepto {cCantidad::String, cUnidad::Maybe String, cClaveUnidad::String, cClaveProdServ::String, cNoIdentificacion::Maybe String, cDescripcion::String, cValorUnitario::String, cDescuento::Maybe String, cImporte::String, cObjetoImp::String, cImpuestos::[Impuestos]} deriving (Show)

type TipoRelacion = String
data Relacion = Relacion TipoRelacion [UUID] deriving (Show)


instance Eq Impuestos where
    (==) :: Impuestos -> Impuestos -> Bool
    Traslado{impTasaOCuota=tasa,impImpuesto=impuesto} == Traslado{impTasaOCuota=tasa',impImpuesto=impuesto'} = tasa==tasa' && impuesto==impuesto'
    Retencion{impTasaOCuota=tasa,impImpuesto=impuesto} == Retencion{impTasaOCuota=tasa',impImpuesto=impuesto'} = tasa==tasa' && impuesto==impuesto'
    _ == _ = False
(|+|) :: Impuestos -> Impuestos -> Impuestos
imp |+| imp' = imp{impBase=show (read (impBase imp)+read (impBase imp')),impImporte=show (read (impImporte imp)+read (impImporte imp'))}

esTraslado :: Impuestos -> Bool
esTraslado (Traslado{}) = True
esTraslado _ = False

esRetencion :: Impuestos -> Bool
esRetencion (Retencion{}) = True
esRetencion _ = False