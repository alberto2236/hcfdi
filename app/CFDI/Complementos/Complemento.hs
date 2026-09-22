{-# LANGUAGE ExistentialQuantification #-}

module CFDI.Complementos.Complemento where
import Text.XML.Light (Element)
import Text.XML.Light.Types (Attr)


data CualquierComplemento = forall a. Complemento a => CualquierComplemento a

crearComplemento :: CualquierComplemento -> Element
crearComplemento  (CualquierComplemento comp) = crearComplemento' comp
getNameSpaces :: CualquierComplemento -> [Maybe Attr]
getNameSpaces (CualquierComplemento comp) = getNameSpaces' comp
getSchema :: CualquierComplemento -> String
getSchema (CualquierComplemento comp) = getSchema' comp


class Complemento t where
    crearComplemento' :: t -> Element
    getNameSpaces' :: t -> [Maybe Attr]
    getSchema' :: t -> String
