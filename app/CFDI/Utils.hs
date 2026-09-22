module CFDI.Utils where
import CFDI.Types
import Text.XML.Light (Attr (..), unqual, Node (node))
import Data.Maybe (catMaybes)

attr :: String -> String -> Maybe Attr
attr name val = Just $ Attr (unqual name) val
maybeAttr :: String -> Maybe String -> Maybe Attr
maybeAttr name (Just val) = Just $ Attr (unqual name) val
maybeAttr name Nothing = Nothing
agruparImpuestos :: [Impuestos] -> [Impuestos]
agruparImpuestos = foldr (\v a -> if v `elem` a then map (\i -> if i == v then i |+| v else i) a else v:a) []

round2Dec :: Float -> Float
round2Dec x = fromIntegral (round (x * 100)) / 100
crearTraslado name ending (Traslado base importe impuesto tasaOCuota tipoFactor) =
    node name $ catMaybes [
        attr ("Base"++ending) base,attr ("Importe"++ending) importe,attr ("Impuesto"++ending) impuesto,attr ("TasaOCuota"++ending) (show tasaOCuota),attr ("TipoFactor"++ending) tipoFactor
    ]
crearRetencion name ending (Retencion base importe impuesto tasaOCuota tipoFactor) =
    node name $ catMaybes [
        attr ("Base"++ending) base,attr ("Importe"++ending) importe,attr ("Impuesto"++ending) impuesto,attr ("TasaOCuota"++ending) (show tasaOCuota),attr ("TipoFactor"++ending) tipoFactor
    ]

