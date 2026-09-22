# hcfdi

Herramienta de linea de comandos para varias operaciones referentes a la factura electronica en Mexico. Se pueden sellar y timbrar archivos XML, generar PDFs, reportes en csv/excel, descargar masivamente desde el SAT, validar certificados y E.firmas, etc... 

La aplicacion esta escrita completame en haskell y compilada para Windows, Linux y MAC


## Compilacion
``` bash
git clone https://github.com/alberto2236/hcfdi.git
cd hcfdi
cabal build
cabal install
```

## Binarios
- Windows: https://github.com/alberto2236/hcfdi.git
- Linux: https://github.com/alberto2236/hcfdi.git
- Mac: https://github.com/alberto2236/hcfdi.git
  
## Generar PDFs
``` bash
#Genera el PDF de un XML en especifico
hcfdi pdf archivo.xml
#Genera el PDF de todos los XML encontratos en la ruta especificada y de forma recursiva
hcfdi pdf ruta/carpeta
#Genera el PDF de todos los XML de un archivo .zip
hcfdi pdf ruta/archivo.zip
```

## Generar csv/excel
``` bash
#Genera el CSV de un XML en especifico
hcfdi csv general archivo.xml > resultado.csv
#Genera el CSV de todos los XML encontratos en la ruta especificada y de forma recursiva
hcfdi csv general ruta/carpeta > resultado.csv
#Genera el CSV de todos los XML de un archivo .zip
hcfdi csv general ruta/archivo.zip > resultado.csv
#Genera el CSV con el detalle de complementos de pago, cfdis relacionados, importes etc...
hcfdi csv pagos ruta/carpeta > resultado.csv
#Genera el CSV con el detalle de nomina, ingresos, egresos y otros pagos.
hcfdi csv nomina ruta/carpeta > resultado.csv
#Genera el CSV con el detalle de partidas.
hcfdi csv partidas ruta/carpeta > resultado.csv
```


## Operaciones con el WebService del SAT
 ```bash
#Solicitamos los XML emitidos entre el periodo de -i a -f
hcfdi ws solE -c archivo/csd.cer -k archivo/csd.ckey -p contraseña -i "2023-02-01T00:00:00" -f "2023-02-28T23:59:59"
asd-123-qwe
#Verificamos el estatus de la solicitud previa
hcfdi ws ver -I asd-123-qwe
ASD-123-QWE_01
ASD-123-QWE_02
#Se descarga el paquete ASD-123-QWE_01.zip
hcfdi ws des -I ASD-123-QWE_01
```

## Validacion de CSD y E.firma
Obtenemos la informacion de un certificado, como RFC, vigencia, tipo, etc...
``` bash
hcfdi csd info -c archivo/csd.cer 
```
Valida una pareja de archivos de un CSD o de una E.firma
``` bash
hcfdi csd val -c archivo/csd.cer -k archivo/csd.ckey -p contraseña 
```
Sella un archivo XML
``` bash
hcfdi csd sellar -c archivo/csd.cer -k archivo/csd.ckey -p contraseña archivo.xml
```
