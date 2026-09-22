{-# LANGUAGE InstanceSigs #-}

module CFDI.Complementos.Pago where
import CFDI.Types
import Text.XML.Light
import CFDI.Complementos.Complemento (Complemento (..), CualquierComplemento (CualquierComplemento))
import Data.Maybe (catMaybes)
import CFDI.Utils (agruparImpuestos, attr, round2Dec, crearTraslado, crearRetencion)

data PagoTotales = PagoTotales{tMontoTotalPagos::Double,tTotalRetencionesIVA::Double,tTotalRetencionesISR::Double,tTotalRetencionesIEPS::Double,
                                tTotalTrasladosBaseIVA16::Double,tTotalTrasladosImpuestoIVA16::Double,tTotalTrasladosBaseIVA8::Double,tTotalTrasladosImpuestoIVA8::Double,
                                tTotalTrasladosBaseIVA0::Double,tTotalTrasladosImpuestoIVA0::Double,tTotalTrasladosBaseIVAExento::Double} deriving (Show)
data Pago = Pago{pFechaPago::String,pFormaDePago::String,pMoneda::String,pTipoCambio::String,pMonto::String,pDoctos::[DocumentoRelacionado]} deriving (Show)
data DocumentoRelacionado = DocumentoRelacionado{drSerie::String,drFolio::String,drIdDocumento::String,drImpPagado::String,
                            drImpSaldoAnt::String,drImpSaldoInsoluto::String,drNumParcialidad::String,drMoneda::String,drEquivalencia::String,
                            drObjetoImp::String,drImpuestos::[Impuestos]} deriving (Show)
data ComplementoPago = ComplementoPago20 {cNameSpaces::[Maybe Attr], cSchema::String,cpPagos::[Pago]} deriving (Show)

pago20Name :: String -> QName
pago20Name nombre =  QName nombre Nothing $ Just "pago20"


crearPago20 :: Generales -> Emisor -> Receptor -> ComplementoPago -> CFDI
crearPago20 generales emisor receptor pago = CFDI40 "P"
            generales
            []
            emisor
            receptor
            [Concepto "1" Nothing "ACT" "84111506" Nothing "Pago" "0" Nothing "0" "01" []]
            Nothing
            [CualquierComplemento pago]

crearComplementoPago20 :: ComplementoPago
crearComplementoPago20 = ComplementoPago20 {cNameSpaces=[Just $ Attr (QName "pago20" Nothing $ Just "xmlns") "http://www.sat.gob.mx/Pagos20"],
                                cSchema=" http://www.sat.gob.mx/Pagos20 http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos20.xsd",
                                cpPagos=[]
                                }

instance Complemento ComplementoPago where
    getNameSpaces' :: ComplementoPago -> [Maybe Attr]
    getNameSpaces' = cNameSpaces
    getSchema' :: ComplementoPago -> String
    getSchema' = cSchema
    crearComplemento' :: ComplementoPago -> Element
    crearComplemento' pago@ComplementoPago20{cpPagos=pagos} =  node (pago20Name "Pagos") (catMaybes [attr "Version" "2.0"] ,
        node (pago20Name "Totales") (attTotales pago) : map crearPago pagos
        )
        where   crearPago pago = node (pago20Name "Pago") (catMaybes [attr "FechaPago" (pFechaPago pago),attr "FormaDePagoP" (pFormaDePago pago),attr "MonedaP" (pMoneda pago),attr "Monto" (pMonto pago),attr "TipoCambioP" (pTipoCambio pago)] , 
                                catMaybes $
                                map (Just . crearDoctoRelacionado) (pDoctos pago) ++
                                [if ((not.null) traslados || (not.null) retenciones) then
                                Just $ node (pago20Name "ImpuestosP") (
                                    catMaybes [
                                        if (not.null) traslados then Just $ node (pago20Name "TrasladosP") $ map (crearTraslado (pago20Name "TrasladoP") "P") traslados else Nothing,
                                        if (not.null) retenciones then Just $ node (pago20Name "RetencionesP") $ map (crearRetencion (pago20Name "RetencionP") "P") retenciones else Nothing
                                    ])
                                else Nothing]
                                )
                --Este bloque se repite en partidas
                  where totalesImpuestos = getImpuestosPago pago
                        retenciones = filter esRetencion totalesImpuestos
                        traslados = filter esTraslado totalesImpuestos
                crearDoctoRelacionado doctoRelacionado = node (pago20Name "DoctoRelacionado") $ (catMaybes [
                    attr "Folio" (drFolio doctoRelacionado),
                    attr "Serie" (drSerie doctoRelacionado),
                    attr "IdDocumento" (drIdDocumento doctoRelacionado),
                    attr "ImpPagado" (drImpPagado doctoRelacionado),
                    attr "ImpSaldoAnt" (drImpSaldoAnt doctoRelacionado),
                    attr "ImpSaldoInsoluto" (drImpSaldoInsoluto doctoRelacionado),
                    attr "NumParcialidad" (drNumParcialidad doctoRelacionado),
                    attr "MonedaDR" (drMoneda doctoRelacionado),
                    attr "EquivalenciaDR" (drEquivalencia doctoRelacionado),
                    attr "ObjetoImpDR" (drObjetoImp doctoRelacionado)
                    ],
                    catMaybes [if ((not.null) trasladosDr || (not.null) retencionesDr) then
                                Just $ node (pago20Name "ImpuestosDR") $ catMaybes [
                                    if (not.null) trasladosDr then Just $ node (pago20Name "TrasladosDR") $ map (crearTraslado (pago20Name "TrasladoDR") "DR") trasladosDr else Nothing,
                                    if (not.null) retencionesDr then Just $ node (pago20Name "RetencionesDR") $ map (crearRetencion (pago20Name "RetencionDR") "DR") retencionesDr else Nothing
                                ]
                            else Nothing]
                    )
                    where   trasladosDr=filter esTraslado (drImpuestos doctoRelacionado)
                            retencionesDr=filter esRetencion (drImpuestos doctoRelacionado)
                attTotales pago = let (PagoTotales{tMontoTotalPagos=montoTotalPagos,tTotalRetencionesIVA=totalRetencionesIVA,tTotalRetencionesISR=totalRetencionesISR,tTotalRetencionesIEPS=totalRetencionesIEPS,
                                    tTotalTrasladosBaseIVA16=totalTrasladosBaseIVA16,tTotalTrasladosImpuestoIVA16=totalTrasladosImpuestoIVA16,tTotalTrasladosBaseIVA8=totalTrasladosBaseIVA8,tTotalTrasladosImpuestoIVA8=totalTrasladosImpuestoIVA8,
                                    tTotalTrasladosBaseIVA0=totalTrasladosBaseIVA0,tTotalTrasladosImpuestoIVA0=totalTrasladosImpuestoIVA0,tTotalTrasladosBaseIVAExento=totalTrasladosBaseIVAExento}) = totalesPagos (cpPagos pago)
                                in catMaybes [attr "MontoTotalPagos" (show montoTotalPagos),
                                    if totalRetencionesIVA>0 then attr "TotalRetencionesIVA" (show totalRetencionesIVA) else Nothing,
                                    if totalRetencionesISR>0 then attr "TotalRetencionesISR" (show totalRetencionesISR) else Nothing,
                                    if totalRetencionesIEPS>0 then attr "TotalRetencionesIEPS" (show totalRetencionesIEPS) else Nothing,
                                    if totalTrasladosBaseIVA16>0 then attr "TotalTrasladosBaseIVA16" (show totalTrasladosBaseIVA16) else Nothing,
                                    if totalTrasladosImpuestoIVA16>0 then attr "TotalTrasladosImpuestoIVA16" (show totalTrasladosImpuestoIVA16) else Nothing,
                                    if totalTrasladosBaseIVA8>0 then attr "TotalTrasladosBaseIVA8" (show totalTrasladosBaseIVA8) else Nothing,
                                    if totalTrasladosImpuestoIVA8>0 then attr "TotalTrasladosImpuestoIVA8" (show totalTrasladosImpuestoIVA8) else Nothing,
                                    if totalTrasladosBaseIVA0>0 then attr "TotalTrasladosBaseIVA0" (show totalTrasladosBaseIVA0) else Nothing,
                                    if totalTrasladosImpuestoIVA0>0 then attr "TotalTrasladosImpuestoIVA0" (show totalTrasladosImpuestoIVA0) else Nothing,
                                    if totalTrasladosBaseIVAExento>0 then attr "TotalTrasladosBaseIVAExento" (show totalTrasladosBaseIVAExento) else Nothing
                                    ]
                totalesPagos :: [Pago] -> PagoTotales
                totalesPagos pago = foldr (\v a -> totalesRelacionados (pDoctos v) a{tMontoTotalPagos=read $ pMonto v}) (PagoTotales 0 0 0 0 0 0 0 0 0 0 0) pago
                totalesRelacionados :: [DocumentoRelacionado] -> PagoTotales -> PagoTotales
                totalesRelacionados doctosRelacionados totales = foldr (totalesImpuestosPagos . drImpuestos) totales doctosRelacionados
                totalesImpuestosPagos :: [Impuestos] -> PagoTotales -> PagoTotales
                totalesImpuestosPagos impuestos (PagoTotales a b c d e f g h i j k) =
                    let traslados = filter esTraslado impuestos
                        retenciones =  filter esRetencion impuestos
                        PagoTotales z y x w v t s r q p o = foldr sumarTraslado (PagoTotales 0 0 0 0 0 0 0 0 0 0 0) traslados
                        PagoTotales z' y' x' w' v' t' s' r' q' p' o' = foldr sumarRetencion (PagoTotales 0 0 0 0 0 0 0 0 0 0 0) retenciones
                    in PagoTotales (a+z+z') (b+y+y') (c+x+x') (d+w+w') (e+v+v') (f+t+t') (g+s+s') (h+r+r') (i+q+q') (j+p+p') (k+o+o')
                sumarTraslado :: Impuestos -> PagoTotales -> PagoTotales
                sumarTraslado (Traslado base importe "002" 0.16 _) totales = totales{tTotalTrasladosBaseIVA16=tTotalTrasladosBaseIVA16 totales+read base,tTotalTrasladosImpuestoIVA16=tTotalTrasladosImpuestoIVA16 totales + read importe}
                sumarTraslado (Traslado base importe "002" 0.08 _) totales = totales{tTotalTrasladosBaseIVA8=tTotalTrasladosBaseIVA8 totales+read base,tTotalTrasladosImpuestoIVA8=tTotalTrasladosImpuestoIVA8 totales + read importe}
                sumarTraslado (Traslado base importe "002" 0.0 _) totales = totales{tTotalTrasladosBaseIVA0=tTotalTrasladosBaseIVA0 totales+read base,tTotalTrasladosImpuestoIVA0=tTotalTrasladosImpuestoIVA0 totales + read importe}
                sumarTraslado (Traslado base importe "002" _ "Exento") totales = totales{tTotalTrasladosBaseIVAExento=tTotalTrasladosBaseIVAExento totales+read base}
                sumarTraslado _ totales = totales
                sumarRetencion :: Impuestos -> PagoTotales -> PagoTotales
                sumarRetencion (Retencion _ importe "001" _ _) totales = totales{tTotalRetencionesISR=tTotalRetencionesISR totales + read importe}
                sumarRetencion (Retencion _ importe "002" _ _) totales = totales{tTotalRetencionesIVA=tTotalRetencionesIVA totales + read importe}
                sumarRetencion (Retencion _ importe "003" _ _) totales = totales{tTotalRetencionesIEPS=tTotalRetencionesIEPS totales + read importe}
                getImpuestosPago :: Pago -> [Impuestos]
                getImpuestosPago = agruparImpuestos . (concatMap drImpuestos . pDoctos)