module DefaultData where

import Internal.Types


defaultFields :: [Field]
defaultFields=[
        FText {fName = "estatus", dbType = "VARCHAR(25)", fLabel = "Estatus", fXpath = [], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "fechaCancel", dbType = "VARCHAR(50)", fLabel = "Fecha Cancelacion", fXpath = [], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FLabel {fName = "lblVersion", fLabel = "Version: ", pdfX = 510.0, pdfY = 40.0, pdfW = 50.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblTipoComprobante", fLabel = "Comprobante: ", pdfX = 350.0, pdfY = 40.0, pdfW = 100.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblSerieNumero", fLabel = "Folio: ", pdfX = 400.0, pdfY = 30.0, pdfW = 50.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblCSD", fLabel = "No. CSD: ", pdfX = 400.0, pdfY = 50.0, pdfW = 50.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FText {fName = "csd", dbType = "VARCHAR(50)", fLabel = "CSD", fXpath = [(["3.2"],"/Comprobante/@noCertificado"),(["3.3","4.0"],"/Comprobante/@NoCertificado")], pdfX = 450.0, pdfY = 50.0, pdfW = 150.0, pdfAlign = "Left", fOnList = [], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FLabel {fName = "lblCertificadoSAT", fLabel = "Certificado SAT: ", pdfX = 350.0, pdfY = 60.0, pdfW = 100.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FText {fName = "certificadosat", dbType = "VARCHAR(50)", fLabel = "Certificado SAT", fXpath = [(["3.2"],"/Comprobante/Complemento/TimbreFiscalDigital/@noCertificadoSAT"),(["3.3","4.0"],"/Comprobante/Complemento/TimbreFiscalDigital/@NoCertificadoSAT")], pdfX = 450.0, pdfY = 60.0, pdfW = 150.0, pdfAlign = "Left", fOnList = [], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FLabel {fName = "lblRFC PAC", fLabel = "RFC PAC: ", pdfX = 400.0, pdfY = 70.0, pdfW = 50.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblFechaExpedicion", fLabel = "Fecha Expedicion: ", pdfX = 350.0, pdfY = 80.0, pdfW = 100.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblFechaCertificacion", fLabel = "Fecha Certificacion: ", pdfX = 350.0, pdfY = 90.0, pdfW = 100.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblTipoRelacion", fLabel = "Relacion: ", pdfX = 250.0, pdfY = 100.0, pdfW = 100.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblCFDIRelacionados", fLabel = "CFDI Relacionados: ", pdfX = 250.0, pdfY = 110.0, pdfW = 100.0, pdfAlign = "Right", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblEmisorNombre", fLabel = "Emisor:", pdfX = 10.0, pdfY = 20.0, pdfW = 50.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblEmisorRFC", fLabel = "RFC:", pdfX = 10.0, pdfY = 30.0, pdfW = 50.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblDomicilioFiscalEmisor", fLabel = "Dom Fis:", pdfX = 10.0, pdfY = 50.0, pdfW = 50.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblEmisorRegimenFiscal", fLabel = "Regimen:", pdfX = 10.0, pdfY = 40.0, pdfW = 50.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblReceptorNombre", fLabel = "Receptor:", pdfX = 10.0, pdfY = 70.0, pdfW = 50.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblReceptorRFC", fLabel = "RFC:", pdfX = 10.0, pdfY = 80.0, pdfW = 50.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblReceptorDomicilioFiscal", fLabel = "Dom. Fis:", pdfX = 10.0, pdfY = 90.0, pdfW = 50.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblReceptorRegimenFiscal", fLabel = "Regimen:", pdfX = 10.0, pdfY = 100.0, pdfW = 50.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblReceptorUsoCFDI", fLabel = "Uso CFDI:", pdfX = 10.0, pdfY = 110.0, pdfW = 50.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblFormaPago", fLabel = "Forma pago: ", pdfX = 10.0, pdfY = 610.0, pdfW = 120.0, pdfAlign = "Right", fOnPdf = [I,E]},
        FLabel {fName = "lblMoneda", fLabel = "Moneda: ", pdfX = 10.0, pdfY = 620.0, pdfW = 120.0, pdfAlign = "Right", fOnPdf = [I,E,A]},
        FLabel {fName = "lblTipoCambio", fLabel = "Tipo de Cambio: ", pdfX = 180.0, pdfY = 620.0, pdfW = 100.0, pdfAlign = "Right", fOnPdf = [I,E,A]},
        FLabel {fName = "lblSubTotal", fLabel = "Sub Total: ", pdfX = 470.0, pdfY = 600.0, pdfW = 60.0, pdfAlign = "Right", fOnPdf = [I,E]},
        FLabel {fName = "lblTotal", fLabel = "Total: ", pdfX = 470.0, pdfY = 690.0, pdfW = 60.0, pdfAlign = "Right", fOnPdf = [I,E]},
        FLabel {fName = "lblDescuento", fLabel = "Descuento:", pdfX = 470.0, pdfY = 610.0, pdfW = 60.0, pdfAlign = "Right", fOnPdf = [I,E]},
        FLabel {fName = "lblSelloCFD", fLabel = "Sello CFDI: ", pdfX = 125.0, pdfY = 710.0, pdfW = 100.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FTextBox {fName = "selloCFD", dbType = "TEXT", fLabel = "Sello CFDI", fXpath = [(["3.2"],"/Comprobante/Complemento/TimbreFiscalDigital/@selloCFD"),(["3.3","4.0"],"/Comprobante/Complemento/TimbreFiscalDigital/@SelloCFD")], pdfX = 125.0, pdfY = 720.0, pdfW = 470.0, pdfAlign = "Left", fOnList = [], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FLabel {fName = "lblSelloSAT", fLabel = "Sello SAT: ", pdfX = 125.0, pdfY = 740.0, pdfW = 100.0, pdfAlign = "Left", fOnPdf = [I,E,P,N,T,A]},
        FTextBox {fName = "selloSAT", dbType = "TEXT", fLabel = "Sello SAT", fXpath = [(["3.2"],"/Comprobante/Complemento/TimbreFiscalDigital/@selloSAT"),(["3.3","4.0"],"/Comprobante/Complemento/TimbreFiscalDigital/@SelloSAT")], pdfX = 125.0, pdfY = 750.0, pdfW = 470.0, pdfAlign = "Left", fOnList = [], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FLabel {fName = "lblRepresentacion", fLabel = " Este documento es una representaci\243n impresa de un CFDI ", pdfX = 150.0, pdfY = 770.0, pdfW = 300.0, pdfAlign = "Center", fOnPdf = [I,E,P,N,T,A]},
        FLabel {fName = "lblCondiciones", fLabel = "Condiciones: ", pdfX = 10.0, pdfY = 630.0, pdfW = 120.0, pdfAlign = "Right", fOnPdf = [I,E]},
        FIL {fName = "importeLetra", fXpath = [(["3.3","4.0"],"/Comprobante/@Total")], pdfX = 125.0, pdfY = 700.0, pdfW = 470.0, pdfAlign = "Left", fOnPdf = [I,E,N]},
        FIL {fName = "importeLetraPago", fXpath = [(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@MontoTotalPagos")], pdfX = 125.0, pdfY = 700.0, pdfW = 470.0, pdfAlign = "Left", fOnPdf = [P]},



        FLabel {fName = "lblCtaOrdenante", fLabel = "Cta. Ordenante:", pdfX = 10.0, pdfY = 600.0, pdfW = 90.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblCtaBeneficiario", fLabel = "Cta. Beneficiario:", pdfX = 10.0, pdfY = 610.0, pdfW = 90.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblNumOperacion", fLabel = "Num. Operacion:", pdfX = 10.0, pdfY = 620.0, pdfW = 90.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblFechaPago", fLabel = "Fecha De Pago: ", pdfX = 10.0, pdfY = 630.0, pdfW = 90.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblFormaDePago", fLabel = "Forma De Pago: ", pdfX = 10.0, pdfY = 640.0, pdfW = 90.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblVersionPago", fLabel = "Version: ", pdfX = 10.0, pdfY = 650.0, pdfW = 90.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblPagoRetIVA", fLabel = "Ret. IVA:", pdfX = 300.0, pdfY = 600.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblPagoRetISR", fLabel = "Ret. ISR:", pdfX = 300.0, pdfY = 610.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblPagoRetIEPS", fLabel = "Ret. IEPS:", pdfX = 300.0, pdfY = 620.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblBaseIVA0", fLabel = "Base IVA 0%:", pdfX = 300.0, pdfY = 630.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblBaseIVAExcento", fLabel = "IVA Exento", pdfX = 300.0, pdfY = 640.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblBaseIVA16", fLabel = "B. IVA 16%:", pdfX = 450.0, pdfY = 600.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblImpuestoIva16", fLabel = "IVA 16%:", pdfX = 450.0, pdfY = 610.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblBaseIVA8", fLabel = "B. IVA 8%:", pdfX = 450.0, pdfY = 620.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblImpuestoIva8", fLabel = "IVA 8%:", pdfX = 450.0, pdfY = 630.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblMontoTotal", fLabel = "Monto:", pdfX = 450.0, pdfY = 680.0, pdfW = 60.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblMonedaPago", fLabel = "Moneda:", pdfX = 450.0, pdfY = 670.0, pdfW = 60.0, pdfAlign = "Left", fOnPdf = [P]},
        FLabel {fName = "lblTipoCambioP", fLabel = "Tipo Cambio:", pdfX = 450.0, pdfY = 660.0, pdfW = 70.0, pdfAlign = "Left", fOnPdf = [P]},


        FLabel {fName = "lblVersionNom", fLabel = "Versi\243n: ", pdfX = 10.0, pdfY = 605.0, pdfW = 80.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblTipoRegimenNom", fLabel = "Tipo Regim\233n: ", pdfX = 10.0, pdfY = 615.0, pdfW = 80.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblFechaPagoNom", fLabel = "Fecha Pago: ", pdfX = 10.0, pdfY = 625.0, pdfW = 80.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblFechaInicioPNom", fLabel = "Fecha Inicio P: ", pdfX = 220.0, pdfY = 625.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblFechaFinPNom", fLabel = "Fecha Final P: ", pdfX = 410.0, pdfY = 625.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblAntiguedadNom", fLabel = "Antiguedad: ", pdfX = 10.0, pdfY = 635.0, pdfW = 80.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblRiesgoPuestoNom", fLabel = "Riesgo Puesto: ", pdfX = 10.0, pdfY = 645.0, pdfW = 80.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblEntidadNom", fLabel = "Entidad: ", pdfX = 10.0, pdfY = 655.0, pdfW = 80.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblCurpNom", fLabel = "CURP: ", pdfX = 10.0, pdfY = 665.0, pdfW = 80.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblSalarioBaseCotizadoNom", fLabel = "S.B.C: ", pdfX = 10.0, pdfY = 675.0, pdfW = 80.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblRegistroPatronalNom", fLabel = "Registro Patronal: ", pdfX = 220.0, pdfY = 605.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblNumeroSegSocNom", fLabel = "N.S.S: ", pdfX = 220.0, pdfY = 615.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblPeriodicidadPNom", fLabel = "Periodicidad Pago: ", pdfX = 220.0, pdfY = 635.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblPuestoNom", fLabel = "Puesto: ", pdfX = 220.0, pdfY = 645.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblNumeroEmpleadoNom", fLabel = "N\176 Empleado: ", pdfX = 220.0, pdfY = 655.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblTipoJornadaNom", fLabel = "Tipo de Jornada: ", pdfX = 220.0, pdfY = 665.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblDeptoNom", fLabel = "Depto: ", pdfX = 220.0, pdfY = 675.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblTipoContratoNom", fLabel = "Tipo de Contrato: ", pdfX = 410.0, pdfY = 605.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblSDINom", fLabel = "S.D.I: ", pdfX = 410.0, pdfY = 615.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblSubsidioCausadoNom", fLabel = " Subsidio Causado: ", pdfX = 410.0, pdfY = 635.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblBancoNom", fLabel = "Banco: ", pdfX = 410.0, pdfY = 645.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblNumeroCtaNom", fLabel = "Numero de Cuenta: ", pdfX = 410.0, pdfY = 655.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblDiasPagadosNom", fLabel = "Dias Pagados: ", pdfX = 410.0, pdfY = 665.0, pdfW = 110.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblTotalPercepciones", fLabel = "Total Percepciones: ", pdfX = 10.0, pdfY = 585.0, pdfW = 100.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblTotalDeducciones", fLabel = "Total Deducciones: ", pdfX = 210.0, pdfY = 585.0, pdfW = 100.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblTotalN", fLabel = "Total: ", pdfX = 410.0, pdfY = 585.0, pdfW = 90.0, pdfAlign = "Right", fOnPdf = [N]},
        FLabel {fName = "lblPercepciones", fLabel = "Percepciones", pdfX = 260.0, pdfY = 170.0, pdfW = 70.0, pdfAlign = "Center", fOnPdf = [N]},
        FLabel {fName = "lblDeducciones", fLabel = "Deducciones", pdfX = 260.0, pdfY = 320.0, pdfW = 70.0, pdfAlign = "Center", fOnPdf = [N]},
        FLabel {fName = "lblOtrosPagos", fLabel = "Otros Pagos", pdfX = 260.0, pdfY = 490.0, pdfW = 70.0, pdfAlign = "Center", fOnPdf = [N]},
        FLabel {fName = "lblMetodoPago", fLabel = "Metodo Pago: ", pdfX = 10.0, pdfY = 600.0, pdfW = 120.0, pdfAlign = "Right", fOnPdf = [I,E]}
        
    ] ++ cliFields

cliFields :: [Field]
cliFields = [
        
        FText {fName = "version", dbType = "VARCHAR(10)", fLabel = "Version", fXpath = [(["3.2"],"/Comprobante/@version"),(["3.3","4.0"],"/Comprobante/@Version")], pdfX = 560.0, pdfY = 40.0, pdfW = 20.0, pdfAlign = "Left", fOnList = [A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FSAT {fName = "tipo", dbType = "VARCHAR(15)", fLabel = "Tipo", fTipoSAT = "TipoDeComprobante", fXpath = [(["3.2"],"/Comprobante/@tipoDeComprobante"),(["3.3","4.0"],"/Comprobante/@TipoDeComprobante")], pdfX = 450.0, pdfY = 40.0, pdfW = 60.0, pdfAlign = "Left", fOnList = [A], fOnPdf = [I,E,P,N,T,A]},
        FText {fName = "serie", dbType = "VARCHAR(50)", fLabel = "Serie", fXpath = [(["3.2"],"/Comprobante/@serie"),(["3.3","4.0"],"/Comprobante/@Serie")], pdfX = 450.0, pdfY = 30.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "folio", dbType = "VARCHAR(50)", fLabel = "Folio", fXpath = [(["3.2"],"/Comprobante/@folio"),(["3.3","4.0"],"/Comprobante/@Folio")], pdfX = 520.0, pdfY = 30.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "uuid", dbType = "VARCHAR(50)", fLabel = "Folio Fiscal", fXpath = [(["3.2","3.3","4.0"],"/Comprobante/Complemento/TimbreFiscalDigital/@UUID")], pdfX = 350.0, pdfY = 20.0, pdfW = 250.0, pdfAlign = "Center", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "rfcpac", dbType = "VARCHAR(15)", fLabel = "RFC PAC", fXpath = [(["3.2"],"/Comprobante/Complemento/TimbreFiscalDigital/@rfcProvCertif"),(["3.3","4.0"],"/Comprobante/Complemento/TimbreFiscalDigital/@RfcProvCertif")], pdfX = 450.0, pdfY = 70.0, pdfW = 150.0, pdfAlign = "Left", fOnList = [], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "fecha", dbType = "VARCHAR(25)", fLabel = "Fecha Expedicion", fXpath = [(["3.2"],"/Comprobante/@fecha"),(["3.3","4.0"],"/Comprobante/@Fecha")], pdfX = 450.0, pdfY = 80.0, pdfW = 150.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "fechacertificacion", dbType = "VARCHAR(25)", fLabel = "Fecha Certificacion", fXpath = [(["3.2"],"/Comprobante/Complemento/TimbreFiscalDigital@fechaTimbrado"),(["3.3","4.0"],"/Comprobante/Complemento/TimbreFiscalDigital/@FechaTimbrado")], pdfX = 450.0, pdfY = 90.0, pdfW = 150.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FSAT {fName = "relacionTipo", dbType = "VARCHAR(10)", fLabel = "Relacion", fTipoSAT = "TipoRelacion", fXpath = [(["3.2"],"/Comprobante/cfdiRelacionados/@tipoRelacion"),(["3.3","4.0"],"/Comprobante/CfdiRelacionados/@TipoRelacion")], pdfX = 350.0, pdfY = 100.0, pdfW = 250.0, pdfAlign = "Left", fOnList = [I,E,P,N,T], fOnPdf = [I,E,P,N,T]},
        FText {fName = "cfdiRelacionado", dbType = "VARCHAR(50)", fLabel = "UUID Relacionado",  fXpath = [(["3.2"],"/Comprobante/cfdiRelacionados/CfdiRelacionado/@UUID"),(["3.3","4.0"],"/Comprobante/CfdiRelacionados/CfdiRelacionado/@UUID")], pdfX = 350.0, pdfY = 100.0, pdfW = 250.0, pdfAlign = "Left", fOnList = [I,E,P,N,T], fOnPdf = [], fEditable=False},
        FText {fName = "emisorNombre", dbType = "TEXT", fLabel = "Emisor", fXpath = [(["3.2"],"/Comprobante/Emisor/@nombre"),(["3.3","4.0"],"/Comprobante/Emisor/@Nombre")], pdfX = 60.0, pdfY = 20.0, pdfW = 300.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "emisorRfc", dbType = "VARCHAR(15)", fLabel = "Emisor RFC", fXpath = [(["3.2"],"/Comprobante/Emisor/@rfc"),(["3.3","4.0"],"/Comprobante/Emisor/@Rfc")], pdfX = 60.0, pdfY = 30.0, pdfW = 150.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "domicilioFiscalEmisor", dbType = "VARCHAR(8)", fLabel = "D.F. Emisor", fXpath = [(["3.2"],"/Comprobante/@lugarExpedicion"),(["3.3","4.0"],"/Comprobante/@LugarExpedicion")], pdfX = 60.0, pdfY = 50.0, pdfW = 150.0, pdfAlign = "Left", fOnList = [], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FSAT {fName = "emisorRegimenFiscal", dbType = "VARCHAR(10)", fLabel = "Regimen Emisor", fTipoSAT = "RegimenFiscal", fXpath = [(["3.2"],"/Comprobante/Emisor/@regimenFiscal"),(["3.3","4.0"],"/Comprobante/Emisor/@RegimenFiscal")], pdfX = 60.0, pdfY = 40.0, pdfW = 300.0, pdfAlign = "Left", fOnList = [I,E,P,N,T], fOnPdf = [I,E,P,N,T,A]},
        FText {fName = "receptorNombre", dbType = "TEXT", fLabel = "Receptor", fXpath = [(["3.2"],"/Comprobante/Receptor/@nombre"),(["3.3","4.0"],"/Comprobante/Receptor/@Nombre")], pdfX = 60.0, pdfY = 70.0, pdfW = 300.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "receptorRfc", dbType = "VARCHAR(15)", fLabel = "Receptor RFC", fXpath = [(["3.2"],"/Comprobante/Receptor/@rfc"),(["3.3","4.0"],"/Comprobante/Receptor/@Rfc")], pdfX = 60.0, pdfY = 80.0, pdfW = 150.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "domicilioFiscalReceptor", dbType = "VARCHAR(15)", fLabel = "D.F. Receptor", fXpath = [(["3.2"],"/Comprobante/Receptor/@domicilioFiscalReceptor"),(["3.3","4.0"],"/Comprobante/Receptor/@DomicilioFiscalReceptor")], pdfX = 60.0, pdfY = 90.0, pdfW = 150.0, pdfAlign = "Left", fOnList = [], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FSAT {fName = "receptorRegimenFiscal", dbType = "VARCHAR(10)", fLabel = "Regimen Receptor", fTipoSAT = "RegimenFiscal", fXpath = [(["3.2"],"/Comprobante/Receptor/@regimenFiscalReceptor"),(["3.3","4.0"],"/Comprobante/Receptor/@RegimenFiscalReceptor")], pdfX = 60.0, pdfY = 100.0, pdfW = 200.0, pdfAlign = "Left", fOnList = [I,E,P,N,T], fOnPdf = [I,E,P,N,T,A]},
        FSAT {fName = "receptorUsoCFDI", dbType = "VARCHAR(10)", fLabel = "Uso CFDI", fTipoSAT = "UsoCFDI", fXpath = [(["3.2"],"/Comprobante/Receptor/@usoCFDI"),(["3.3","4.0"],"/Comprobante/Receptor/@UsoCFDI")], pdfX = 60.0, pdfY = 110.0, pdfW = 190.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A]},
        FSAT {fName = "metodoPago", dbType = "VARCHAR(5)", fLabel = "Metodo Pago", fTipoSAT = "MetodoPago", fXpath = [(["3.2"],"/Comprobante/@metodoPago"),(["3.3","4.0"],"/Comprobante/@MetodoPago")], pdfX = 130.0, pdfY = 600.0, pdfW = 290.0, pdfAlign = "Left", fOnList = [I,E], fOnPdf = [I,E]},
        FSAT {fName = "formaPago", dbType = "VARCHAR(10)", fLabel = "Forma Pago", fTipoSAT = "FormaPago", fXpath = [(["3.2"],"/Comprobante/@formaPago"),(["3.3","4.0"],"/Comprobante/@FormaPago")], pdfX = 130.0, pdfY = 610.0, pdfW = 290.0, pdfAlign = "Left", fOnList = [I,E], fOnPdf = [I,E]},
        FText {fName = "moneda", dbType = "VARCHAR(10)", fLabel = "Moneda", fXpath = [(["3.2"],"/Comprobante/@moneda"),(["3.3","4.0"],"/Comprobante/@Moneda")], pdfX = 130.0, pdfY = 620.0, pdfW = 50.0, pdfAlign = "Left", fOnList = [I,E,A], fOnPdf = [I,E,A], fEditable=False},
        FMoney {fName = "tc", dbType = "FLOAT DEFAULT 0", fLabel = "Tipo de Cambio", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/@tipoCambio"),(["3.3","4.0"],"/Comprobante/@TipoCambio")], pdfX = 280.0, pdfY = 620.0, pdfW = 140.0, pdfAlign = "Left", fOnList = [I,E,A], fOnPdf = [I,E,A], fEditable=False},
        FMoney {fName = "subTotal", dbType = "FLOAT DEFAULT 0", fLabel = "Sub total", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/@SubTotal")], pdfX = 530.0, pdfY = 600.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E,A], fOnPdf = [I,E,A], fEditable=False},
        FMoney {fName = "total", dbType = "FLOAT DEFAULT 0", fLabel = "Total", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/@Total")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E,A], fOnPdf = [I,E,A], fEditable=False},
        FMoney {fName = "descuento", dbType = "FLOAT DEFAULT 0", fLabel = "Descuento", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.2"],"/Comprobante/@descuento"),(["3.3","4.0"],"/Comprobante/@Descuento")], pdfX = 530.0, pdfY = 610.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [I,E], fEditable=False},
        FText {fName = "condicionesDePago", dbType = "VARCHAR(50)", fLabel = "Condiciones De Pago", fXpath = [(["3.2"],"/Comprobante/@condicionesDePago"),(["3.3","4.0"],"/Comprobante/@CondicionesDePago")], pdfX = 130.0, pdfY = 630.0, pdfW = 140.0, pdfAlign = "Left", fOnList = [I,E], fOnPdf = [I,E], fEditable=False},
        FMoney {fName = "ieps", dbType = "FLOAT DEFAULT 0", fLabel = "IEPS", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Traslados/Traslado[Impuesto=003]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "iva16", dbType = "FLOAT DEFAULT 0", fLabel = "IVA16", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Traslados/Traslado[Impuesto=002&&TasaOCuota=0.16]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "iva8", dbType = "FLOAT DEFAULT 0", fLabel = "IVA8", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Traslados/Traslado[Impuesto=002&&TasaOCuota=0.08]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "iva0", dbType = "FLOAT DEFAULT 0", fLabel = "IVA0", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Traslados/Traslado[Impuesto=002&&TipoFactor=\"Tasa\"&&TasaOCuota=0]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "baseIeps", dbType = "FLOAT DEFAULT 0", fLabel = "Base IEPS", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Traslados/Traslado[Impuesto=003]/@Base")], pdfX = 530.0, pdfY = 650.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "base16", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA16", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Traslados/Traslado[Impuesto=002&&TasaOCuota=0.16]/@Base")], pdfX = 530.0, pdfY = 650.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "base8", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA8", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Traslados/Traslado[Impuesto=002&&TasaOCuota=0.08]/@Base")], pdfX = 530.0, pdfY = 650.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "base0", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA0", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Traslados/Traslado[Impuesto=002&&TipoFactor=\"Tasa\"&&TasaOCuota=0.00]/@Base")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "baseExento", dbType = "FLOAT DEFAULT 0", fLabel = "Base Exento", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Traslados/Traslado[Impuesto=002&&TipoFactor=\"Exento\"]/@Base")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "retIVA", dbType = "FLOAT DEFAULT 0", fLabel = "RetIVA", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Retenciones/Retencion[Impuesto=002]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "retISR", dbType = "FLOAT DEFAULT 0", fLabel = "RetISR", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Retenciones/Retencion[Impuesto=001]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "retIEPS", dbType = "FLOAT DEFAULT 0", fLabel = "RetIEPS", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Retenciones/Retencion[Impuesto=003]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "impuestosLocalesTras", dbType = "FLOAT DEFAULT 0", fLabel = "Imp. Loc. Tras.", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Complemento/ImpuestosLocales/TrasladosLocales/@Importe")], pdfX = 530.0, pdfY = 720.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "impuestosLocalesRet", dbType = "FLOAT DEFAULT 0", fLabel = "Imp. Loc. Ret.", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Complemento/ImpuestosLocales/RetencionesLocales/@Importe")], pdfX = 530.0, pdfY = 7200.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        

        FText {fName = "VersionPago", dbType = "VARCHAR(10)", fLabel = "Version Pago", fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/@version"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/@Version")], pdfX = 100.0, pdfY = 650.0, pdfW = 200.0, pdfAlign = "Left", fOnList = [P], fOnPdf = [P], fEditable=False},
        FSAT {fName = "formaDePago", dbType = "VARCHAR(10)", fLabel = "Forma Pago", fTipoSAT = "FormaPago", fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Pago/@formaDePagoP"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Pago/@FormaDePagoP")], pdfX = 100.0, pdfY = 640.0, pdfW = 200.0, pdfAlign = "Left", fOnList = [P], fOnPdf = [P]},
        FText {fName = "fechaPago", dbType = "VARCHAR(25)", fLabel = "Fecha Pago", fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Pago/@fechaPago"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Pago/@FechaPago")], pdfX = 100.0, pdfY = 630.0, pdfW = 200.0, pdfAlign = "Left", fOnList = [P], fOnPdf = [P], fEditable=False},
        FText {fName = "monedaPago", dbType = "VARCHAR(10)", fLabel = "Moneda Pago", fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Pago/@monedaP"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Pago/@MonedaP")], pdfX = 510.0, pdfY = 670.0, pdfW = 90.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "tcP", dbType = "FLOAT DEFAULT 0", fLabel = "Tipo Cambio", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Pago/@tipoCambioP"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Pago/@TipoCambioP")], pdfX = 520.0, pdfY = 660.0, pdfW = 80.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},        
        FText {fName = "NumOperacion", dbType = "VARCHAR(50)", fLabel = "Numero Operacion", fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/pago/@numOperacion"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Pago/@NumOperacion")], pdfX = 100.0, pdfY = 620.0, pdfW = 200.0, pdfAlign = "Left", fOnList = [P], fOnPdf = [P], fEditable=False},
        FText {fName = "ctaOrdenante", dbType = "VARCHAR(50)", fLabel = "Cuenta Ordenante", fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Pago/@ctaOrdenante"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Pago/@CtaOrdenante")], pdfX = 100.0, pdfY = 600.0, pdfW = 200.0, pdfAlign = "Left", fOnList = [P], fOnPdf = [P], fEditable=False},
        FText {fName = "ctaBeneficiario", dbType = "VARCHAR(50)", fLabel = "Cuenta Beneficiario", fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/pago/@ctaBeneficiario"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Pago/@CtaBeneficiario")], pdfX = 100.0, pdfY = 610.0, pdfW = 200.0, pdfAlign = "Left", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoMontoTotal", dbType = "FLOAT DEFAULT 0", fLabel = "Total", fDecimals = 2, fTc = Nothing, fXpath = [(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Pago/@Monto")], pdfX = 510.0, pdfY = 680.0, pdfW = 90.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoRetIVA", dbType = "FLOAT DEFAULT 0", fLabel = "RetIVA", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Totales/@totalRetencionesIVA"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@TotalRetencionesIVA")], pdfX = 370.0, pdfY = 600.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoRetISR", dbType = "FLOAT DEFAULT 0", fLabel = "RetISR", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Totales/@totalRetencionesISR"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@TotalRetencionesISR")], pdfX = 370.0, pdfY = 610.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoRetIEPS", dbType = "FLOAT DEFAULT 0", fLabel = "RetIEPS", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Totales/@totalRetencionesIEPS"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@TotalRetencionesIEPS")], pdfX = 370.0, pdfY = 620.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoBaseIVA0", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA0", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Totales/@totalTrasladosBaseIVA0"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@TotalTrasladosBaseIVA0")], pdfX = 370.0, pdfY = 630.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoBaseIVAExcento", dbType = "FLOAT DEFAULT 0", fLabel = "Base Exento", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Totales/@totalTrasladosBaseIVAExento"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@TotalTrasladosBaseIVAExento")], pdfX = 370.0, pdfY = 640.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoBaseIVA16", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA16", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Totales/@totalTrasladosBaseIVA16"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@TotalTrasladosBaseIVA16")], pdfX = 520.0, pdfY = 600.0, pdfW = 80.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoIVA16", dbType = "FLOAT DEFAULT 0", fLabel = "IVA16", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Totales/@totalTrasladosImpuestoIVA16"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@TotalTrasladosImpuestoIVA16")], pdfX = 520.0, pdfY = 610.0, pdfW = 80.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoBaseIVA8", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA8", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Totales/@totalTrasladosBaseIVA8"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@TotalTrasladosBaseIVA8")], pdfX = 520.0, pdfY = 620.0, pdfW = 80.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoIVA8", dbType = "FLOAT DEFAULT 0", fLabel = "IVA8", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Pagos/Totales/@totalTrasladosImpuestoIVA8"),(["3.3","4.0"],"/Comprobante/Complemento/Pagos/Totales/@TotalTrasladosImpuestoIVA8")], pdfX = 520.0, pdfY = 630.0, pdfW = 80.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},


        FText {fName = "versionNom", dbType = "VARCHAR(10)", fLabel = "Versi\243n Nomina", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/@version"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/@Version")], pdfX = 90.0, pdfY = 605.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "tipoRegimenNom", dbType = "VARCHAR(10)", fLabel = "Regimen Nomina", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@tipoRegimen"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@TipoRegimen")], pdfX = 90.0, pdfY = 615.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "fechaPagoNom", dbType = "VARCHAR(25)", fLabel = "Fecha Pago", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/@fechaPago"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/@FechaPago")], pdfX = 90.0, pdfY = 625.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "fechaInicialPagoNom", dbType = "VARCHAR(25)", fLabel = "Fecha Inicio Pago", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/@fechaInicialPago"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/@FechaInicialPago")], pdfX = 330.0, pdfY = 625.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "fechaFinPagoNom", dbType = "VARCHAR(25)", fLabel = "Fecha Final Pago", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/@fechaFinalPago"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/@FechaFinalPago")], pdfX = 520.0, pdfY = 625.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "riesgoPuestoNom", dbType = "VARCHAR(10)", fLabel = "Riesgo Puesto", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@riesgoPuesto"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@RiesgoPuesto")], pdfX = 90.0, pdfY = 645.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "entidadNom", dbType = "VARCHAR(10)", fLabel = "Entidad", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@claveEntFed"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@ClaveEntFed")], pdfX = 90.0, pdfY = 655.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "curpNom", dbType = "VARCHAR(50)", fLabel = "CURP", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@curp"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@Curp")], pdfX = 90.0, pdfY = 665.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "salarioBaseCotAporNom", dbType = "FLOAT DEFAULT 0", fLabel = "SBC", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@salarioBaseCotApor"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@SalarioBaseCotApor")], pdfX = 90.0, pdfY = 675.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "registroPatronalNom", dbType = "VARCHAR(50)", fLabel = "Registro Patronal", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/emisor/@registroPatronal"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Emisor/@RegistroPatronal")], pdfX = 330.0, pdfY = 605.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "periodicidadPagoNom", dbType = "VARCHAR(10)", fLabel = "Periodicidad Pago", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@periodicidadPago"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@PeriodicidadPago")], pdfX = 330.0, pdfY = 635.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "puestoNom", dbType = "VARCHAR(50)", fLabel = "Puesto", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@puesto"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@Puesto")], pdfX = 330.0, pdfY = 645.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "numEmpleadoNom", dbType = "VARCHAR(50)", fLabel = "N\176 Empleado", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@numEmpleado"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@NumEmpleado")], pdfX = 330.0, pdfY = 655.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "tipoContratoNom", dbType = "VARCHAR(10)", fLabel = "Tipo Contrato", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@tipoContrato"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@TipoContrato")], pdfX = 520.0, pdfY = 605.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "subsidioCausadoNom", dbType = "FLOAT DEFAULT 0", fLabel = "Subsidio Causado", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/OtrosPagos/OtroPago/SubsidioAlEmpleo/@subsidioCausado"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/OtrosPagos/OtroPago/SubsidioAlEmpleo/@SubsidioCausado")], pdfX = 520.0, pdfY = 635.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FDouble {fName = "numDiasPagadosNom", dbType = "FLOAT DEFAULT 0", fLabel = "Dias pagados", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/@numDiasPagados"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/@NumDiasPagados")], pdfX = 520.0, pdfY = 665.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "totalPercepciones", dbType = "FLOAT DEFAULT 0", fLabel = "Percepciones", fDecimals = 2, fTc = Nothing, fXpath = [(["3.3","4.0"],"/Comprobante/Complemento/Nomina/@TotalPercepciones")], pdfX = 110.0, pdfY = 585.0, pdfW = 100.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "totalDeducciones", dbType = "FLOAT DEFAULT 0", fLabel = "Deducciones", fDecimals = 2, fTc = Nothing, fXpath = [(["3.3","4.0"],"/Comprobante/Complemento/Nomina/@TotalDeducciones")], pdfX = 310.0, pdfY = 585.0, pdfW = 100.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "totalNomina", dbType = "FLOAT DEFAULT 0", fLabel = "Total", fDecimals = 2, fTc = Nothing, fXpath = [(["3.3","4.0"],"/Comprobante/@Total")], pdfX = 500.0, pdfY = 585.0, pdfW = 100.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "antiguedadNom", dbType = "VARCHAR(15)", fLabel = "Antiguedad", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@antig\252edad"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@Antig\252edad")], pdfX = 90.0, pdfY = 635.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "numSeguridadSocialNom", dbType = "VARCHAR(30)", fLabel = "NSS", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@numSeguridadSocial"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@NumSeguridadSocial")], pdfX = 330.0, pdfY = 615.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "tipojornada", dbType = "VARCHAR(10)", fLabel = "TipoJornada", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@tipoJornada"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@TipoJornada")], pdfX = 330.0, pdfY = 665.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "departamentoNom", dbType = "VARCHAR(50)", fLabel = "Departamento", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@departamento"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@Departamento")], pdfX = 330.0, pdfY = 675.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "sdiNom", dbType = "FLOAT DEFAULT 0", fLabel = "SDI", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@salarioDiarioIntegrado"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@SalarioDiarioIntegrado")], pdfX = 520.0, pdfY = 615.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "bancoNom", dbType = "VARCHAR(10)", fLabel = "Banco", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@banco"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@Banco")], pdfX = 520.0, pdfY = 645.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "cuentaBancariaNom", dbType = "VARCHAR(25)", fLabel = "Cuenta Bancaria", fXpath = [(["3.2"],"/Comprobante/Complemento/Nomina/Receptor/@cuentaBancaria"),(["3.3","4.0"],"/Comprobante/Complemento/Nomina/Receptor/@CuentaBancaria")], pdfX = 520.0, pdfY = 655.0, pdfW = 80.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False}
        
    ]

defaultTables :: [Table]
defaultTables=[
    Table {tName = "impuestosTotalesRetenidos", sqlName = "impuestosTotalesRetenidos", tParentId = "idParent", tAnds = "", tableXmlPath = "/Comprobante/Impuestos/Retenciones/Retencion", tOnList = [], tOnPdf = [I,E], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FLabel {fName = "lblRet", fLabel = "Retencion", pdfX = 350.0, pdfY = 640.0, pdfW = 90.0, pdfAlign = "Left", fOnPdf = [I,E]},
        FSAT {fName = "retImpuesto", dbType = "VARCHAR(10)", fLabel = "Impuesto", fTipoSAT = "Impuesto", fXpath = [(["3.2"],"/@impuesto"),(["3.3","4.0"],"/@Impuesto")], pdfX = 430.0, pdfY = 640.0, pdfW = 50.0, pdfAlign = "Left", fOnList = [I,E], fOnPdf = [I,E]},
        FMoney {fName = "retImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 530.0, pdfY = 640.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [I,E], fEditable=False}]},
    Table {tName = "impuestosTotalesTrasladados", sqlName = "impuestosTotalesTrasladados", tParentId = "idParent", tAnds = "", tableXmlPath = "/Comprobante/Impuestos/Traslados/Traslado", tOnList = [], tOnPdf = [I,E], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FLabel {fName = "lblTras", fLabel = "Trasladado", pdfX = 350.0, pdfY = 620.0, pdfW = 90.0, pdfAlign = "Left", fOnPdf = [I,E]},FSAT {fName = "trasImpuesto", dbType = "VARCHAR(10)", fLabel = "Impuesto", fTipoSAT = "Impuesto", fXpath = [(["3.2"],"/@impuesto"),(["3.3","4.0"],"/@Impuesto")], pdfX = 430.0, pdfY = 620.0, pdfW = 50.0, pdfAlign = "Left", fOnList = [I,E], fOnPdf = [I,E]},
        FPercent {fName = "trasTasa", dbType = "FLOAT DEFAULT 0", fLabel = "TasaOCuota", fXpath = [(["3.2"],"/@tasaOCuota"),(["3.3","4.0"],"/@TasaOCuota")], pdfX = 480.0, pdfY = 620.0, pdfW = 50.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [I,E], fEditable=False},
        FMoney {fName = "trasImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 530.0, pdfY = 620.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [I,E], fEditable=False}]},
    Table {tName = "impuestosLocalesRetenidos", sqlName = "impuestosLocalesRetenidos", tParentId = "idParent", tAnds = "", tableXmlPath = "/Comprobante/Complemento/ImpuestosLocales/RetencionesLocales", tOnList = [], tOnPdf = [I,E], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FText {fName = "impLocRetenido", dbType = "VARCHAR(50)", fLabel = "ImpLocRetenido", fXpath = [(["3.2"],"/@ImpLocRetenido"),(["3.3","4.0"],"/@ImpLocRetenido")], pdfX = 350.0, pdfY = 660.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [I,E], fOnPdf = [I,E], fEditable=False},
        FDouble {fName = "locRetTasa", dbType = "FLOAT DEFAULT 0", fLabel = "TasadeRetencion", fXpath = [(["3.2"],"/@tasadeRetencion"),(["3.3","4.0"],"/@TasadeRetencion")], pdfX = 480.0, pdfY = 660.0, pdfW = 45.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [I,E], fEditable=False},
        FMoney {fName = "locRetImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 530.0, pdfY = 660.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [I,E], fEditable=False}]},
    Table {tName = "impuestosLocalesTrasladados", sqlName = "impuestosLocalesTrasladados", tParentId = "idParent", tAnds = "", tableXmlPath = "/Comprobante/Complemento/ImpuestosLocales/TrasladosLocales", tOnList = [], tOnPdf = [I,E], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FText {fName = "impLocTrasladado", dbType = "VARCHAR(50)", fLabel = "ImpLocTrasladado", fXpath = [(["3.2"],"/@impLocTrasladado"),(["3.3","4.0"],"/@ImpLocTrasladado")], pdfX = 350.0, pdfY = 670.0, pdfW = 130.0, pdfAlign = "Left", fOnList = [I,E], fOnPdf = [I,E], fEditable=False},
        FDouble {fName = "locTrasTasa", dbType = "FLOAT DEFAULT 0", fLabel = "TasadeRetencion", fXpath = [(["3.2"],"/@tasadeTraslado"),(["3.3","4.0"],"/@TasadeTraslado")], pdfX = 480.0, pdfY = 670.0, pdfW = 45.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [I,E], fEditable=False},
        FMoney {fName = "locTrasImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 530.0, pdfY = 670.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [I,E], fEditable=False}]},
    Table {tName = "cfdisRelacionados", sqlName = "cfdisRelacionados", tParentId = "idParent", tAnds = "", tableXmlPath = "/Comprobante/CfdiRelacionados/CfdiRelacionado", tOnList = [I,E,P,N,T,A], tOnPdf = [I,E,P,N,T,A], tSubTables = [], tPivot = Nothing, tMax = 2, tableFields = [
        FText {fName = "relTipo", dbType = "VARCHAR(15)", fLabel = "Tipo relacion", fXpath = [(["3.3","4.0"],"/Comprobante/CfdiRelacionados/@TipoRelacion")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "uuidRelacionado", dbType = "VARCHAR(50)", fLabel = "UUID", fXpath = [(["3.3","4.0"],"/@UUID")], pdfX = 350.0, pdfY = 110.0, pdfW = 250.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "relUuidParent", dbType = "VARCHAR(50)", fLabel = "UUID", fXpath = [(["3.3","4.0"],"/Comprobante/Complemento/TimbreFiscalDigital/@UUID")], pdfX = 350.0, pdfY = 110.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False}
        ]},
    TableH {tName = "pagos", sqlName = "pagos", tParentId = "idParent", tAnds = "", tableXmlPath = "/Comprobante/Complemento/Pagos/Pago/DoctoRelacionado", tOnList = [P], tOnPdf = [P], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FText {fName = "pagoUuidFactura", dbType = "VARCHAR(50)", fLabel = "Folio factura", fXpath = [(["3.3","4.0"],"/@IdDocumento")], pdfX = 90.0, pdfY = 225.0, pdfW = 240.0, pdfAlign = "Left", fOnList = [P], fOnPdf = [P], fEditable=False},
        FText {fName = "pagoUuidPago", dbType = "VARCHAR(50)", fLabel = "Folio pago", fXpath = [(["3.3","4.0"],"/Comprobante/Complemento/TimbreFiscalDigital/@UUID")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [], fOnPdf = [], fEditable=False},
        FText {fName = "pagoSerie", dbType = "VARCHAR(35)", fLabel = "SerieDR", fXpath = [(["3.2"],"/@serie"),(["3.3","4.0"],"/@Serie")], pdfX = 10.0, pdfY = 225.0, pdfW = 40.0, pdfAlign = "Left", fOnList = [P], fOnPdf = [P], fEditable=False},
        FText {fName = "pagoFolio", dbType = "VARCHAR(35)", fLabel = "FolioDR", fXpath = [(["3.2"],"/@folio"),(["3.3","4.0"],"/@Folio")], pdfX = 50.0, pdfY = 225.0, pdfW = 40.0, pdfAlign = "Left", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoSaldoAnt", dbType = "FLOAT DEFAULT 0", fLabel = "S. Ant", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.2"],"/@impSaldoAnt"),(["3.3","4.0"],"/@ImpSaldoAnt")], pdfX = 330.0, pdfY = 225.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoImporte", dbType = "FLOAT DEFAULT 0", fLabel = "ImporteP", fDecimals = 2, fTc = Just "tcP", fXpath = [(["3.3","4.0"],"/@ImpPagado")], pdfX = 400.0, pdfY = 225.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoSaldoInsoluto", dbType = "FLOAT DEFAULT 0", fLabel = "Saldo", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.2"],"/@impSaldoInsoluto"),(["3.3","4.0"],"/@ImpSaldoInsoluto")], pdfX = 470.0, pdfY = 225.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FText {fName = "pagoMonedaDR", dbType = "VARCHAR(10)", fLabel = "MDR", fXpath = [(["3.2"],"/@monedaDR"),(["3.3","4.0"],"/@MonedaDR")], pdfX = 570.0, pdfY = 225.0, pdfW = 30.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "tcDr", dbType = "FLOAT DEFAULT 0", fLabel = "TcDR", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@equivalenciaDR"),(["3.3","4.0"],"/@EquivalenciaDR")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FText {fName = "pagoNumParcialidad", dbType = "VARCHAR(10)", fLabel = "Par", fXpath = [(["3.2"],"/@numParcialidad"),(["3.3","4.0"],"/@NumParcialidad")], pdfX = 540.0, pdfY = 225.0, pdfW = 30.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [P], fEditable=False},
        FMoney {fName = "pagoDRiva16", dbType = "FLOAT DEFAULT 0", fLabel = "IVA16DR", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.3","4.0"],"/ImpuestosDR/TrasladosDR/TrasladoDR[ImpuestoDR=002&&TasaOCuotaDR=0.16]/@ImporteDR")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [], fEditable=False},
        FMoney {fName = "pagoDRiva8", dbType = "FLOAT DEFAULT 0", fLabel = "IVA8DR", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.3","4.0"],"/ImpuestosDR/TrasladosDR/TrasladoDR[ImpuestoDR=002&&TasaOCuotaDR=0.08]/@ImporteDR")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [], fEditable=False},
        FMoney {fName = "pagoDRiva0", dbType = "FLOAT DEFAULT 0", fLabel = "IVA0DR", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.3","4.0"],"/ImpuestosDR/TrasladosDR/TrasladoDR[ImpuestoDR=002&&TasaOCuotaDR=0]/@ImporteDR")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [], fEditable=False},
        FMoney {fName = "pagoDRbase16", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA16DR", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.3","4.0"],"/ImpuestosDR/TrasladosDR/TrasladoDR[ImpuestoDR=002&&TasaOCuotaDR=0.16]/@BaseDR")], pdfX = 530.0, pdfY = 650.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [], fEditable=False},
        FMoney {fName = "pagoDRbase8", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA8DR", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.3","4.0"],"/ImpuestosDR/TrasladosDR/TrasladoDR[ImpuestoDR=002&&TasaOCuotaDR=0.08]/@BaseDR")], pdfX = 530.0, pdfY = 650.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [], fEditable=False},
        FMoney {fName = "pagoDRbase0", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA0DR", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.3","4.0"],"/ImpuestosDR/TrasladosDR/TrasladoDR[ImpuestoDR=002&&TasaOCuotaDR=0.00]/@BaseDR")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [], fEditable=False},
        FMoney {fName = "pagoDRretIVA", dbType = "FLOAT DEFAULT 0", fLabel = "RetIVADR", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.3","4.0"],"/ImpuestosDR/RetencionesDR/RetencionDR[ImpuestoDR=002]/@ImporteDR")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [], fEditable=False},
        FMoney {fName = "pagoDRretISR", dbType = "FLOAT DEFAULT 0", fLabel = "RetISRDR", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.3","4.0"],"/ImpuestosDR/RetencionesDR/RetencionDR[ImpuestoDR=001]/@ImporteDR")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [], fEditable=False},
        FMoney {fName = "pagoDRretIEPS", dbType = "FLOAT DEFAULT 0", fLabel = "RetIEPSDR", fDecimals = 2, fTc = Just "tcDr", fXpath = [(["3.3","4.0"],"/ImpuestosDR/RetencionesDR/RetencionDR[ImpuestoDR=003]/@ImporteDR")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [P], fOnPdf = [], fEditable=False}
        ]},
    TableH {tName = "pueConPago", sqlName = "pagos", tParentId = "idFactura", tAnds = "metodoPago='PUE' AND pagoImporte >0", tableXmlPath = "", tOnList = [], tOnPdf = [], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FMoney {fName = "pagoImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe pagado", fDecimals = 2, fTc = Just "tcP", fXpath = [], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "pagoUuidPago", dbType = "VARCHAR(50)", fLabel = "Folio pago", fXpath = [], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False}
        ]},
    TableH {tName = "ppdConSaldo", sqlName = "", tParentId = "", tAnds = "metodoPago='PPD' AND (total-IFNULL(importePagado,0))>1", tableXmlPath = "", tOnList = [], tOnPdf = [], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FMoney {fName = "importePagado", dbType = "FLOAT DEFAULT 0", fLabel = "Importe pagado", fDecimals = 2, fTc = Just "tc", fXpath = [], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FMoney {fName = "total-IFNULL(importePagado,0)", dbType = "FLOAT DEFAULT 0", fLabel = "Saldo", fDecimals = 2, fTc = Just "tc", fXpath = [], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False}]},
    TableV2 {tName = "onBlackList", tJoin = "INNER JOIN cfditools.blacklist ON cfdis.blacklist=blacklist.id", tAnds = "", tableXmlPath = "", tOnList = [], tOnPdf = [], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FText {fName = "nombre", dbType = "VARCHAR(25)", fLabel = "Nombre", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "Situacion", dbType = "VARCHAR(25)", fLabel = "Situacion", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "PresuncionSAT", dbType = "VARCHAR(25)", fLabel = "PresuncionSAT", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "PublicacionPresuncionSAT", dbType = "VARCHAR(25)", fLabel = "PublicacionPresuncionSAT", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "PresuncionDOF", dbType = "VARCHAR(25)", fLabel = "PresuncionDOF", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "PublicacionPresuncionDOF", dbType = "VARCHAR(25)", fLabel = "PublicacionPresuncionDOF", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "DesvirtuadosSAT", dbType = "VARCHAR(25)", fLabel = "DesvirtuadosSAT", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "PublicacionDesvirtuadosSAT", dbType = "VARCHAR(25)", fLabel = "PublicacionDesvirtuadosSAT", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "DesvirtuadosDOF", dbType = "VARCHAR(25)", fLabel = "DesvirtuadosDOF", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "PublicacionDesvirtuadosDOF", dbType = "VARCHAR(25)", fLabel = "PublicacionDesvirtuadosDOF", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "DefinitivosSAT", dbType = "VARCHAR(25)", fLabel = "DefinitivosSAT", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "PublicacionDefinitivosSAT", dbType = "VARCHAR(25)", fLabel = "PublicacionDefinitivosSAT", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "DefinitivosDOF", dbType = "VARCHAR(25)", fLabel = "DefinitivosDOF", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False},
        FText {fName = "PublicacionDefinitivosDOF", dbType = "VARCHAR(25)", fLabel = "PublicacionDefinitivosDOF", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False}
        ]},
    TableH {tName = "sustActiv", sqlName = "cfdisRelacionados", tParentId = "idRelacionado", tAnds = "activo=TRUE AND relTipo = '04'", tableXmlPath = "", tOnList = [], tOnPdf = [], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FText {fName = "relUuidParent", dbType = "VARCHAR(50)", fLabel = "Folio sustituto", fXpath = [], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False}]},
    TableH {tName = "invalidos", sqlName = "", tParentId = "", tAnds = "valStr!=''", tableXmlPath = "", tOnList = [], tOnPdf = [], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [ 
        FText {fName = "valStr", dbType = "varchar(50)", fLabel = "Validacion", fXpath = [], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [], fEditable=False}
        ]},
    TableH {tName = "partidas", sqlName = "partidas", tParentId = "idParent", tAnds = "", tableXmlPath = "/Comprobante/Conceptos/Concepto", tOnList = [I,E,P,N,T], tOnPdf = [I,E,P,N,T], tSubTables = [], tPivot = Nothing, tMax = 46, tableFields = [
        FDouble {fName = "partCantidad", dbType = "FLOAT DEFAULT 0", fLabel = "Cantidad", fXpath = [(["3.2"],"/@cantidad"),(["3.3","4.0"],"/@Cantidad")], pdfX = 10.0, pdfY = 130.0, pdfW = 50.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "partDescripcion", dbType = "TEXT", fLabel = "Descripcion", fXpath = [(["3.2"],"/@descripcion"),(["3.3","4.0"],"/@Descripcion")], pdfX = 180.0, pdfY = 130.0, pdfW = 230.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "partClaveUnidad", dbType = "VARCHAR(10)", fLabel = "UM", fXpath = [(["3.2"],"/@claveUnidad"),(["3.3","4.0"],"/@ClaveUnidad")], pdfX = 120.0, pdfY = 130.0, pdfW = 30.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "partClaveProdServ", dbType = "VARCHAR(25)", fLabel = "Clave", fXpath = [(["3.2"],"/@claveProdServ"),(["3.3","4.0"],"/@ClaveProdServ")], pdfX = 65.0, pdfY = 130.0, pdfW = 55.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FText {fName = "partObjetoImp", dbType = "VARCHAR(10)", fLabel = "ObjImp", fXpath = [(["3.2"],"/@objetoImp"),(["3.3","4.0"],"/@ObjetoImp")], pdfX = 150.0, pdfY = 130.0, pdfW = 30.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FMoney {fName = "partImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 530.0, pdfY = 130.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FMoney {fName = "partDescuento", dbType = "FLOAT DEFAULT 0", fLabel = "Dcto.", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.2"],"/@descuento"),(["3.3","4.0"],"/@Descuento")], pdfX = 410.0, pdfY = 130.0, pdfW = 50.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FMoney {fName = "partValorUnitario", dbType = "FLOAT DEFAULT 0", fLabel = "Unitario", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.2"],"/@valorUnitario"),(["3.3","4.0"],"/@ValorUnitario")], pdfX = 460.0, pdfY = 130.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FMoney {fName = "partIEPS", dbType = "FLOAT DEFAULT 0", fLabel = "IEPS", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Traslados/Traslado[Impuesto=003]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partIva16", dbType = "FLOAT DEFAULT 0", fLabel = "IVA16", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Traslados/Traslado[Impuesto=002&&TasaOCuota=0.16]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partIva8", dbType = "FLOAT DEFAULT 0", fLabel = "IVA8", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Traslados/Traslado[Impuesto=002&&TasaOCuota=0.08]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partIva0", dbType = "FLOAT DEFAULT 0", fLabel = "IVA0", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Traslados/Traslado[Impuesto=002&&TipoFactor=\"Tasa\"&&TasaOCuota=0]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partBaseIEPS", dbType = "FLOAT DEFAULT 0", fLabel = "Base IEPS", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Traslados/Traslado[Impuesto=003]/@Base")], pdfX = 530.0, pdfY = 650.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partBase16", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA16", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Traslados/Traslado[Impuesto=002&&TasaOCuota=0.16]/@Base")], pdfX = 530.0, pdfY = 650.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partBase8", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA8", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Traslados/Traslado[Impuesto=002&&TasaOCuota=0.08]/@Base")], pdfX = 530.0, pdfY = 650.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partBase0", dbType = "FLOAT DEFAULT 0", fLabel = "Base IVA0", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Traslados/Traslado[Impuesto=002&&TipoFactor=\"Tasa\"&&TasaOCuota=0.00]/@Base")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partBaseExento", dbType = "FLOAT DEFAULT 0", fLabel = "Base Exento", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Traslados/Traslado[Impuesto=002&&TipoFactor=\"Exento\"]/@Base")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partRetIVA", dbType = "FLOAT DEFAULT 0", fLabel = "RetIVA", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Retenciones/Retencion[Impuesto=002]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partRetISR", dbType = "FLOAT DEFAULT 0", fLabel = "RetISR", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Retenciones/Retencion[Impuesto=001]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "partRetIEPS", dbType = "FLOAT DEFAULT 0", fLabel = "RetIEPS", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Impuestos/Retenciones/Retencion[Impuesto=003]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False}
        ]},

    TableH {tName = "percepciones", sqlName = "nomina", tParentId = "idParent", tAnds = "nomSec=1", tableXmlPath = "/Comprobante/Complemento/Nomina/Percepciones/Percepcion", tOnList = [N], tOnPdf = [N], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FText {fName = "nomSec", dbType = "INTEGER", fLabel = "Seccion", fXpath = [(["3.2"],"1"),(["3.3","4.0"],"1")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomTipo", dbType = "VARCHAR(10)", fLabel = "Tipo", fXpath = [(["3.2"],"/@tipoPercepcion"),(["3.3","4.0"],"/@TipoPercepcion")], pdfX = 10.0, pdfY = 180.0, pdfW = 50.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "nomClave", dbType = "VARCHAR(10)", fLabel = "Clave", fXpath = [(["3.2"],"/@clave"),(["3.3","4.0"],"/@Clave")], pdfX = 60.0, pdfY = 180.0, pdfW = 50.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "nomConcepto", dbType = "VARCHAR(100)", fLabel = "Concepto", fXpath = [(["3.2"],"/@concepto"),(["3.3","4.0"],"/@Concepto")], pdfX = 110.0, pdfY = 180.0, pdfW = 290.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "nomImporteGravado", dbType = "FLOAT DEFAULT 0", fLabel = "Gravado", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importeGravado"),(["3.3","4.0"],"/@ImporteGravado")], pdfX = 400.0, pdfY = 180.0, pdfW = 100.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "nomImporteExcento", dbType = "FLOAT DEFAULT 0", fLabel = "Excento", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importeExcento"),(["3.3","4.0"],"/@ImporteExento")], pdfX = 500.0, pdfY = 180.0, pdfW = 100.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [N], fEditable=False}]},
    TableH {tName = "deducciones", sqlName = "nomina", tParentId = "idParent", tAnds = "nomSec=2", tableXmlPath = "/Comprobante/Complemento/Nomina/Deducciones/Deduccion", tOnList = [N], tOnPdf = [N], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FText {fName = "nomSec", dbType = "INTEGER", fLabel = "Seccion", fXpath = [(["3.2"],"2"),(["3.3","4.0"],"2")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomTipo", dbType = "VARCHAR(10)", fLabel = "Tipo", fXpath = [(["3.2"],"/@tipoDeduccion"),(["3.3","4.0"],"/@TipoDeduccion")], pdfX = 10.0, pdfY = 330.0, pdfW = 50.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "nomClave", dbType = "VARCHAR(10)", fLabel = "Clave", fXpath = [(["3.2"],"/@clave"),(["3.3","4.0"],"/@Clave")], pdfX = 60.0, pdfY = 330.0, pdfW = 50.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "nomConcepto", dbType = "VARCHAR(100)", fLabel = "Concepto ", fXpath = [(["3.2"],"/@concepto"),(["3.3","4.0"],"/@Concepto")], pdfX = 110.0, pdfY = 330.0, pdfW = 390.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "nomImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 500.0, pdfY = 330.0, pdfW = 100.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [N], fEditable=False}]},
    TableH {tName = "otrosPagos", sqlName = "nomina", tParentId = "idParent", tAnds = "nomSec=3", tableXmlPath = "/Comprobante/Complemento/Nomina/OtrosPagos/OtroPago", tOnList = [N], tOnPdf = [N], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FText {fName = "nomSec", dbType = "INTEGER", fLabel = "Seccion", fXpath = [(["3.2"],"3"),(["3.3","4.0"],"3")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomTipo", dbType = "VARCHAR(10)", fLabel = "Tipo", fXpath = [(["3.2"],"/@tipoOtroPago"),(["3.3","4.0"],"/@TipoOtroPago")], pdfX = 10.0, pdfY = 500.0, pdfW = 50.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "nomClave", dbType = "VARCHAR(10)", fLabel = "Clave", fXpath = [(["3.2"],"/@clave"),(["3.3","4.0"],"/@Clave")], pdfX = 60.0, pdfY = 500.0, pdfW = 50.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FText {fName = "nomConcepto", dbType = "VARCHAR(100)", fLabel = "Concepto", fXpath = [(["3.2"],"/@concepto"),(["3.3","4.0"],"/@Concepto")], pdfX = 110.0, pdfY = 500.0, pdfW = 390.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [N], fEditable=False},
        FMoney {fName = "nomImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 500.0, pdfY = 500.0, pdfW = 100.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [N], fEditable=False}]},
    TableH {tName = "nominaTodo", sqlName = "nomina", tParentId = "idParent", tAnds = "", tableXmlPath = "", tOnList = [], tOnPdf = [], tSubTables = [], tPivot = Nothing, tMax = 999, tableFields = [
        FText {fName = "CASE WHEN nomSec = 2 THEN 'Deduccion' ELSE 'Percepcion' END", dbType = "INTEGER", fLabel = "Seccion", fXpath = [], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomTipo", dbType = "VARCHAR(10)", fLabel = "Tipo", fXpath = [(["3.2"],"/@tipoOtroPago"),(["3.3","4.0"],"/@TipoOtroPago")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomClave", dbType = "VARCHAR(10)", fLabel = "Clave", fXpath = [(["3.2"],"/@clave"),(["3.3","4.0"],"/@Clave")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomConcepto", dbType = "VARCHAR(100)", fLabel = "Concepto", fXpath = [(["3.2"],"/@concepto"),(["3.3","4.0"],"/@Concepto")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FMoney {fName = "nomImporteGravado", dbType = "FLOAT DEFAULT 0", fLabel = "Gravado", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [], fEditable=False},
        FMoney {fName = "nomImporteExcento", dbType = "FLOAT DEFAULT 0", fLabel = "Excento", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [], fEditable=False},
        FMoney {fName = "nomImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [], fEditable=False}]},
    TableH {tName = "nomAcumMensual", sqlName = "nomina", tParentId = "idParent", tAnds = "", tableXmlPath = "", tOnList = [], tOnPdf = [], tSubTables = [], tPivot = Just (Pivot {pColumn = ["month(fecha)","nomConcepto"], pRows = ["receptorNombre","receptorRfc"], pValue = ["nomImporteGravado","nomImporteExcento","nomImporte"]}), tMax = 999, tableFields = [
        FText {fName = "month(fecha)", dbType = "", fLabel = "Mes", fXpath = [], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomTipo", dbType = "VARCHAR(10)", fLabel = "Tipo", fXpath = [(["3.2"],"/@tipoOtroPago"),(["3.3","4.0"],"/@TipoOtroPago")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomClave", dbType = "VARCHAR(10)", fLabel = "Clave", fXpath = [(["3.2"],"/@clave"),(["3.3","4.0"],"/@Clave")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomConcepto", dbType = "VARCHAR(100)", fLabel = "Concepto", fXpath = [(["3.2"],"/@concepto"),(["3.3","4.0"],"/@Concepto")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FMoney {fName = "nomImporteGravado", dbType = "FLOAT DEFAULT 0", fLabel = "Gravado", fDecimals=2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [], fEditable=False},
        FMoney {fName = "nomImporteExcento", dbType = "FLOAT DEFAULT 0", fLabel = "Excento", fDecimals=2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [], fEditable=False},
        FMoney {fName = "nomImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals=2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [], fEditable=False}]},
    TableH {tName = "nomAcum", sqlName = "nomina", tParentId = "idParent", tAnds = "", tableXmlPath = "", tOnList = [], tOnPdf = [], tSubTables = [], tPivot = Just (Pivot {pColumn = ["nomConcepto"], pRows = ["receptorNombre","receptorRfc"], pValue = ["nomImporteGravado","nomImporteExcento","nomImporte"]}), tMax = 999, tableFields = [
        FText {fName = "nomTipo", dbType = "VARCHAR(10)", fLabel = "Tipo", fXpath = [(["3.2"],"/@tipoOtroPago"),(["3.3","4.0"],"/@TipoOtroPago")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomClave", dbType = "VARCHAR(10)", fLabel = "Clave", fXpath = [(["3.2"],"/@clave"),(["3.3","4.0"],"/@Clave")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FText {fName = "nomConcepto", dbType = "VARCHAR(100)", fLabel = "Concepto", fXpath = [(["3.2"],"/@concepto"),(["3.3","4.0"],"/@Concepto")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Left", fOnList = [N], fOnPdf = [], fEditable=False},
        FMoney {fName = "nomImporteGravado", dbType = "FLOAT DEFAULT 0", fLabel = "Gravado", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [], fEditable=False},
        FMoney {fName = "nomImporteExcento", dbType = "FLOAT DEFAULT 0", fLabel = "Excento", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [], fEditable=False},
        FMoney {fName = "nomImporte", dbType = "FLOAT DEFAULT 0", fLabel = "Importe", fDecimals = 2, fTc = Nothing, fXpath = [(["3.2"],"/@importe"),(["3.3","4.0"],"/@Importe")], pdfX = 0.0, pdfY = 0.0, pdfW = 0.0, pdfAlign = "Right", fOnList = [N], fOnPdf = [], fEditable=False}
        ]},
    TableH {tName = "retenciones", sqlName = "", tParentId = "", tAnds = "(retISR > 0 OR retIVA > 0)", tableXmlPath = "", tOnList = [], tOnPdf = [], tSubTables = [], tPivot = Just (Pivot {pColumn = ["emisorRegimenFiscal"], pRows = ["emisorNombre","emisorRfc"], pValue = ["retISR","retIVA"]}), tMax = 999, tableFields = [
        FSAT {fName = "emisorRegimenFiscal", dbType = "VARCHAR(10)", fLabel = "Regimen Emisor", fTipoSAT = "RegimenFiscal", fXpath = [(["3.2"],"/Comprobante/Emisor/@regimenFiscal"),(["3.3","4.0"],"/Comprobante/Emisor/@RegimenFiscal")], pdfX = 60.0, pdfY = 40.0, pdfW = 300.0, pdfAlign = "Left", fOnList = [I,E,P,N,T], fOnPdf = [I,E,P,N,T,A]},
        FText {fName = "emisorNombre", dbType = "TEXT", fLabel = "Emisor", fXpath = [(["3.2"],"/Comprobante/Emisor/@nombre"),(["3.3","4.0"],"/Comprobante/Emisor/@Nombre")], pdfX = 60.0, pdfY = 20.0, pdfW = 300.0, pdfAlign = "Left", fOnList = [I,E,P,N,T,A], fOnPdf = [I,E,P,N,T,A], fEditable=False},
        FMoney {fName = "retISR", dbType = "FLOAT DEFAULT 0", fLabel = "RetISR", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Retenciones/Retencion[Impuesto=001]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False},
        FMoney {fName = "retIVA", dbType = "FLOAT DEFAULT 0", fLabel = "retIVA", fDecimals = 2, fTc = Just "tc", fXpath = [(["3.3","4.0"],"/Comprobante/Impuestos/Retenciones/Retencion[Impuesto=002]/@Importe")], pdfX = 530.0, pdfY = 690.0, pdfW = 70.0, pdfAlign = "Right", fOnList = [I,E], fOnPdf = [], fEditable=False}
        ]}
    ]

defaultReports :: [Report]
defaultReports=[
        Report {rName = "resumen", rTable = "totals", rLabel = "Resumen", rReportType = Rreport, rNavigate = "/cfdis/todos", rOnList = "", rEmpresa = False, rMonth= True, rTipo = False, rOrigen = True, rStatus = False},
        Report {rName = "impuestos", rTable = "impuestos", rLabel = "Impuestos", rReportType = Rreport, rNavigate = "/cfdis/todos", rOnList = "", rEmpresa = True, rMonth= True, rTipo = True, rOrigen = True, rStatus = False},
        Report {rName = "diot", rTable = "diot", rLabel = "DIOT", rReportType = Rreport, rNavigate = "/cfdis/todos", rOnList = "", rEmpresa = True, rMonth= True, rTipo = False, rOrigen = False, rStatus = False},
        Report {rName = "partidas", rTable = "partidas", rLabel = "Partidas", rReportType = Rcfdi, rNavigate = "/cfdis/ingreso", rOnList = "", rEmpresa = True, rMonth= True, rTipo = True, rOrigen = True, rStatus = True},
        Report {rName = "pagos", rTable = "pagos", rLabel = "Pagos", rReportType = Rcfdi, rNavigate = "/cfdis/pago", rOnList = "P", rEmpresa = True, rMonth= True, rTipo = True, rOrigen = True, rStatus = True},
        Report {rName = "pueConPago", rTable = "pueConPago", rLabel = "PUE con pago", rReportType = Rcfdi, rNavigate = "/cfdis/ingreso", rOnList = "", rEmpresa = True, rMonth= True, rTipo = True, rOrigen = True, rStatus = True},
        Report {rName = "ppdConSaldo", rTable = "ppdConSaldo", rLabel = "PPD con saldo", rReportType = Rcfdi, rNavigate = "/cfdis/ingreso", rOnList = "", rEmpresa = True, rMonth= True, rTipo = True, rOrigen = True, rStatus = True},
        Report {rName = "onBlackList", rTable = "onBlackList", rLabel = "En lista negra EFOS", rReportType = Rcfdi, rNavigate = "", rOnList = "", rEmpresa = True, rMonth= True, rTipo = True, rOrigen = True, rStatus = True},
        Report {rName = "invalidos", rTable = "invalidos", rLabel = "Invalidos", rReportType = Rcfdi, rNavigate = "", rOnList = "", rEmpresa = True, rMonth= True, rTipo = True, rOrigen = True, rStatus = True},
        Report {rName = "retenciones", rTable = "retenciones", rLabel = "Retenciones IVA/ISR", rReportType = Rpivot, rNavigate = "/cfdis/ingresos", rOnList = "", rEmpresa = True, rMonth= True, rTipo = False, rOrigen = True, rStatus = True},
        Report {rName = "nominaTodo", rTable = "nominaTodo", rLabel = "Nomina", rReportType = Rcfdi, rNavigate = "/cfdis/nomina", rOnList = "N", rEmpresa = True, rMonth= True, rTipo = True, rOrigen = True, rStatus = True},
        Report {rName = "nomAcum", rTable = "nomAcum", rLabel = "Nomina acumulados", rReportType = Rpivot, rNavigate = "/cfdis/nomina", rOnList = "N", rEmpresa = True, rMonth= True, rTipo = False, rOrigen = True, rStatus = True},
        Report {rName = "nomAcumMensual", rTable = "nomAcumMensual", rLabel = "Nomina acumulados mensual", rReportType = Rpivot, rNavigate = "/cfdis/nomina", rOnList = "N", rEmpresa = True, rMonth= True, rTipo = False, rOrigen = True, rStatus = True},
        Report {rName = "sustituidosActivos", rTable = "sustActiv", rLabel = "Sustituidos activos", rReportType = Rcfdi, rNavigate = "/cfdis/ingreso", rOnList = "", rEmpresa = True, rMonth= True, rTipo = True, rOrigen = True, rStatus = True}
    ]

defaultValidators :: [Validacion]
defaultValidators = [
    Validacion {nivel=1, descripcion="PUE con 99", condiciones = [("tipo",DIFERENTE,"E"),("metodoPago",IGUAL,"PUE"),("formaPago",IGUAL,"99")], color="orange"},
    Validacion {nivel=1, descripcion="PPD sin 99", condiciones = [("tipo",DIFERENTE,"E"),("metodoPago",IGUAL,"PPD"),("formaPago",DIFERENTE,"99")], color="orange"},
    --Validacion {nivel=5, descripcion="Efectivo < 2000", condiciones = [("origen",IGUAL,"Recibido"),("tipo",DIFERENTE,"E"),("formaPago",IGUAL,"01"),("total",MENOR,"2000")], color="orange"},
    --Validacion {nivel=5, descripcion="Efectivo < 2000", condiciones = [("origen",IGUAL,"Recibido"),("formaDePago",IGUAL,"01"),("total",MENOR,"2000")], color="orange"},
    Validacion {nivel=10, descripcion="Efectivo > 2000", condiciones = [("origen",IGUAL,"Recibido"),("tipo",DIFERENTE,"E"),("formaPago",IGUAL,"01"),("total",MAYOR,"2000")], color="red"},
    Validacion {nivel=10, descripcion="Efectivo > 2000", condiciones = [("origen",IGUAL,"Recibido"),("formaDePago",IGUAL,"01"),("total",MAYOR,"2000")], color="red"},
    Validacion {nivel=10, descripcion="No bancarizado", condiciones = [("origen",IGUAL,"Recibido"),("tipo",DIFERENTE,"E"),("metodoPago",IGUAL,"PUE"),("formaPago",DIFERENTE,"01"),("formaPago",DIFERENTE,"02"),("formaPago",DIFERENTE,"03"),("formaPago",DIFERENTE,"04"),("formaPago",DIFERENTE,"05"),("formaPago",DIFERENTE,"06"),("formaPago",DIFERENTE,"28"),("formaPago",DIFERENTE,"29")], color="red"},
    Validacion {nivel=10, descripcion="No bancarizado", condiciones = [("origen",IGUAL,"Recibido"),("formaDePago",DIFERENTE,"01"),("formaDePago",DIFERENTE,"02"),("formaDePago",DIFERENTE,"03"),("formaDePago",DIFERENTE,"04"),("formaDePago",DIFERENTE,"05"),("formaDePago",DIFERENTE,"06"),("formaDePago",DIFERENTE,"28"),("formaDePago",DIFERENTE,"29")], color="red"},
    Validacion {nivel=10, descripcion="Sin efectos S01", condiciones = [("origen",IGUAL,"Recibido"),("receptorUsoCFDI",IGUAL,"S01")], color="red"}
    ]



defaultTotalFields :: [Field]
defaultTotalFields = [
    FInteger {fName = "total", dbType = "", fLabel = "# CFDIs", fXpath = [([],"COUNT(uuid)")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [A], fOnPdf = [], fEditable=False},
    FInteger {fName = "activos", dbType = "", fLabel = "Activos", fXpath = [([],"SUM(CASE WHEN activo THEN 1 ELSE 0 END)")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [A], fOnPdf = [], fEditable=False},
    FInteger {fName = "cancelados", dbType = "", fLabel = "Cancelados", fXpath = [([],"SUM(CASE WHEN activo THEN 0 ELSE 1 END)")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [A], fOnPdf = [], fEditable=False},
    FInteger {fName = "blacklist", dbType = "", fLabel = "En lista negra", fXpath = [([],"SUM(CASE WHEN activo AND blackList > 0 THEN 1 ELSE 0 END)")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [A], fOnPdf = [], fEditable=False},
    FInteger {fName = "pueConPago", dbType = "", fLabel = "PUE con pago", fXpath = [([],"SUM(CASE WHEN activo AND metodoPago='PUE' AND importePagado >0 THEN 1 ELSE 0 END)")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [A], fOnPdf = [], fEditable=False},
    FInteger {fName = "ppdConSaldo", dbType = "", fLabel = "PPD con saldo", fXpath = [([],"SUM(CASE WHEN activo AND metodoPago='PPD' AND (total-IFNULL(importePagado,0))>1 THEN 1 ELSE 0 END)")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [A], fOnPdf = [], fEditable=False},
    FInteger {fName = "invalidos", dbType = "", fLabel = "Invalidos", fXpath = [([],"SUM(CASE WHEN activo AND valStr!='' THEN 1 ELSE 0 END)")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [A], fOnPdf = [], fEditable=False},
    FMoney {fName = "totalEmitido", dbType = "", fLabel = "totalEmitido", fDecimals = 2, fTc = Nothing, fXpath = [([],"SUM(CASE WHEN activo AND origen='Emitido' THEN (IFNULL(CASE WHEN tipo='I' THEN total WHEN tipo='E' THEN (total*(-1)) ELSE 0 END,0)*IFNULL(tc,1)) ELSE 0 END)")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [A], fOnPdf = [A], fEditable=False},
    FMoney {fName = "totalRecibido", dbType = "", fLabel = "totalRecibido", fDecimals = 2, fTc = Nothing, fXpath = [([],"SUM(CASE WHEN activo AND origen='Recibido' THEN (IFNULL(CASE WHEN tipo='I' THEN total WHEN tipo='E' THEN (total*(-1)) ELSE 0 END,0)*IFNULL(tc,1)) ELSE 0 END)")], pdfX = 0, pdfY = 0, pdfW = 0, pdfAlign = "Left", fOnList = [A], fOnPdf = [A], fEditable=False}
    ]
    
defaultViewsRfc :: [String]
defaultViewsRfc = [
    "CREATE VIEW IF NOT EXISTS totalesPagos AS SELECT idFactura,sum(pagoImporte) AS totalPagado FROM pagos LEFT JOIN cfdis ON cfdis.id=pagos.idFactura GROUP BY idFactura;",
    "CREATE TRIGGER in_pago BEFORE INSERT ON pagos \
    \FOR EACH ROW \
    \BEGIN \
    \    DECLARE factId INT; \
    \    SELECT id INTO factId FROM cfdis WHERE uuid=NEW.pagoUuidFactura; \
    \    UPDATE cfdis SET importePagado=importePagado+IFNULL(NEW.pagoImporte,0) WHERE uuid=NEW.pagoUuidFactura; \
    \    SET NEW.idFactura=factId; \
    \END",

    "CREATE TRIGGER in_cfdi AFTER INSERT ON cfdis \
    \FOR EACH ROW \
    \BEGIN \
    \    UPDATE pagos SET idFactura=NEW.id WHERE pagoUuidFactura=NEW.uuid; \
    \    UPDATE cfdisRelacionados SET idRelacionado=NEW.id WHERE uuidRelacionado=NEW.uuid; \
    \END",

    "CREATE TRIGGER in_relacionado BEFORE INSERT ON cfdisRelacionados \
    \FOR EACH ROW \
    \BEGIN \
    \    DECLARE cfdiId INT; \
    \    SELECT id INTO cfdiId FROM cfdis WHERE uuid=NEW.uuidRelacionado; \
    \    SET NEW.idRelacionado=cfdiId; \
    \END",

    "CREATE TRIGGER in_nomina BEFORE INSERT ON nomina \
    \FOR EACH ROW \
    \BEGIN \
    \    IF NEW.nomImporte IS NULL THEN \
    \        SET NEW.nomImporte = IFNULL(NEW.nomImporteGravado,0)+IFNULL(NEW.nomImporteExcento,0); \
    \    END IF; \
    \END",

    "CREATE FUNCTION tasa_proporcion(year INT, month varchar(5)) \
    \RETURNS double \
    \DETERMINISTIC \
    \BEGIN \
    \    DECLARE result DOUBLE; \
    \    SELECT (SUM(CASE WHEN metodoPago='PUE' OR tipo='P' THEN ((IFNULL(base16,0)*IFNULL(tc,1))+(IFNULL(pagoBaseIVA16,0))) ELSE 0 END)+ SUM(CASE WHEN metodoPago='PUE' OR tipo='P' THEN ((IFNULL(base8,0)*IFNULL(tc,1))+(IFNULL(pagoBaseIVA8,0))) ELSE 0 END)+ SUM(CASE WHEN metodoPago='PUE' OR tipo='P' THEN ((IFNULL(base0,0)*IFNULL(tc,1))+(IFNULL(pagoBaseIVA0,0))) ELSE 0 END)) / (SUM(CASE WHEN metodoPago='PUE' OR tipo='P' THEN ((IFNULL(base16,0)*IFNULL(tc,1))+(IFNULL(pagoBaseIVA16,0))) ELSE 0 END)+ SUM(CASE WHEN metodoPago='PUE' OR tipo='P' THEN ((IFNULL(base8,0)*IFNULL(tc,1))+(IFNULL(pagoBaseIVA8,0))) ELSE 0 END)+ SUM(CASE WHEN metodoPago='PUE' OR tipo='P' THEN ((IFNULL(base0,0)*IFNULL(tc,1))+(IFNULL(pagoBaseIVA0,0))) ELSE 0 END)+ SUM(CASE WHEN metodoPago='PUE' OR tipo='P' THEN ((IFNULL(baseExento,0)*IFNULL(tc,1))+(IFNULL(pagoBaseIVAExcento,0))) ELSE 0 END)) INTO result FROM cfdis WHERE origen='Emitido' AND activo IS true AND noConta IS false AND YEAR(fechaPeriodo)=year AND MONTH(fechaPeriodo) LIKE month; \
    \    RETURN result; \
    \END"
    ]

clavesSat :: [ClaveSAT]
clavesSat = [
    ClaveSAT "FormaPago" "01" "Efectivo",
    ClaveSAT "FormaPago" "02" "Cheque nominativo",
    ClaveSAT "FormaPago" "03" "Transferencia electrónica de fondos",
    ClaveSAT "FormaPago" "04" "Tarjeta de crédito",
    ClaveSAT "FormaPago" "05" "Monedero electrónico",
    ClaveSAT "FormaPago" "06" "Dinero electrónico",
    ClaveSAT "FormaPago" "08" "Vales de despensa",
    ClaveSAT "FormaPago" "12" "Dación en pago",
    ClaveSAT "FormaPago" "13" "Pago por subrogación",
    ClaveSAT "FormaPago" "14" "Pago por consignación",
    ClaveSAT "FormaPago" "15" "Condonación",
    ClaveSAT "FormaPago" "17" "Compensación",
    ClaveSAT "FormaPago" "23" "Novación",
    ClaveSAT "FormaPago" "24" "Confusión",
    ClaveSAT "FormaPago" "25" "Remisión de deuda",
    ClaveSAT "FormaPago" "26" "Prescripción o caducidad",
    ClaveSAT "FormaPago" "27" "A satisfacción del acreedor",
    ClaveSAT "FormaPago" "28" "Tarjeta de débito",
    ClaveSAT "FormaPago" "29" "Tarjeta de servicios",
    ClaveSAT "FormaPago" "30" "Aplicación de anticipos",
    ClaveSAT "FormaPago" "31" "Intermediario pagos",
    ClaveSAT "FormaPago" "99" "Por definir",

    ClaveSAT "TipoDeComprobante" "I" "Ingreso",
    ClaveSAT "TipoDeComprobante" "E" "Egreso",
    ClaveSAT "TipoDeComprobante" "T" "Traslado",
    ClaveSAT "TipoDeComprobante" "N" "Nómina",
    ClaveSAT "TipoDeComprobante" "P" "Pago",

    ClaveSAT "MetodoPago" "PUE" "Pago en una sola exhibición",
    ClaveSAT "MetodoPago" "PPD" "Pago en parcialidades o diferido",

    ClaveSAT "Periodicidad" "01" "Diario",
    ClaveSAT "Periodicidad" "02" "Semanal",
    ClaveSAT "Periodicidad" "03" "Quincenal",
    ClaveSAT "Periodicidad" "04" "Mensual",
    ClaveSAT "Periodicidad" "05" "Bimestral",

    ClaveSAT "Meses" "01" "Enero",
    ClaveSAT "Meses" "02" "Febrero",
    ClaveSAT "Meses" "03" "Marzo",
    ClaveSAT "Meses" "04" "Abril",
    ClaveSAT "Meses" "05" "Mayo",
    ClaveSAT "Meses" "06" "Junio",
    ClaveSAT "Meses" "07" "Julio",
    ClaveSAT "Meses" "08" "Agosto",
    ClaveSAT "Meses" "09" "Septiembre",
    ClaveSAT "Meses" "10" "Octubre",
    ClaveSAT "Meses" "11" "Noviembre",
    ClaveSAT "Meses" "12" "Diciembre",
    ClaveSAT "Meses" "13" "Enero-Febrero",
    ClaveSAT "Meses" "14" "Marzo-Abril",
    ClaveSAT "Meses" "15" "Mayo-Junio",
    ClaveSAT "Meses" "16" "Julio-Agosto",
    ClaveSAT "Meses" "17" "Septiembre-Octubre",
    ClaveSAT "Meses" "18" "Noviembre-Diciembre",

    ClaveSAT "TipoRelacion" "01" "Nota de crédito de los documentos relacionados",
    ClaveSAT "TipoRelacion" "02" "Nota de débito de los documentos relacionados",
    ClaveSAT "TipoRelacion" "03" "Devolución de mercancía sobre facturas o traslados previos",
    ClaveSAT "TipoRelacion" "04" "Sustitución de los CFDI previos",
    ClaveSAT "TipoRelacion" "05" "Traslados de mercancías facturados previamente",
    ClaveSAT "TipoRelacion" "06" "Factura generada por los traslados previos",
    ClaveSAT "TipoRelacion" "07" "CFDI por aplicación de anticipo",

    ClaveSAT "RegimenFiscal" "601" "General de Ley Personas Morales",
    ClaveSAT "RegimenFiscal" "603" "Personas Morales con Fines no Lucrativos",
    ClaveSAT "RegimenFiscal" "605" "Sueldos y Salarios e Ingresos Asimilados a Salarios",
    ClaveSAT "RegimenFiscal" "606" "Arrendamiento",
    ClaveSAT "RegimenFiscal" "607" "Régimen de Enajenación o Adquisición de Bienes",
    ClaveSAT "RegimenFiscal" "608" "Demás ingresos",
    ClaveSAT "RegimenFiscal" "610" "Residentes en el Extranjero sin Establecimiento Permanente en México",
    ClaveSAT "RegimenFiscal" "611" "Ingresos por Dividendos (socios y accionistas)",
    ClaveSAT "RegimenFiscal" "612" "Personas Físicas con Actividades Empresariales y Profesionales",
    ClaveSAT "RegimenFiscal" "614" "Ingresos por intereses",
    ClaveSAT "RegimenFiscal" "615" "Régimen de los ingresos por obtención de premios",
    ClaveSAT "RegimenFiscal" "616" "Sin obligaciones fiscales",
    ClaveSAT "RegimenFiscal" "620" "Sociedades Cooperativas de Producción que optan por diferir sus ingresos",
    ClaveSAT "RegimenFiscal" "621" "Incorporación Fiscal",
    ClaveSAT "RegimenFiscal" "622" "Actividades Agrícolas, Ganaderas, Silvícolas y Pesqueras",
    ClaveSAT "RegimenFiscal" "623" "Opcional para Grupos de Sociedades",
    ClaveSAT "RegimenFiscal" "624" "Coordinados",
    ClaveSAT "RegimenFiscal" "625" "Régimen de las Actividades Empresariales con ingresos a través de Plataformas Tecnológicas",
    ClaveSAT "RegimenFiscal" "626" "Régimen Simplificado de Confianza",

    ClaveSAT "UsoCFDI" "G01" "Adquisición de mercancías.",
    ClaveSAT "UsoCFDI" "G02" "Devoluciones, descuentos o bonificaciones.",
    ClaveSAT "UsoCFDI" "G03" "Gastos en general.",
    ClaveSAT "UsoCFDI" "I01" "Construcciones.",
    ClaveSAT "UsoCFDI" "I02" "Mobiliario y equipo de oficina por inversiones.",
    ClaveSAT "UsoCFDI" "I03" "Equipo de transporte.",
    ClaveSAT "UsoCFDI" "I04" "Equipo de computo y accesorios.",
    ClaveSAT "UsoCFDI" "I05" "Dados, troqueles, moldes, matrices y herramental.",
    ClaveSAT "UsoCFDI" "I06" "Comunicaciones telefónicas.",
    ClaveSAT "UsoCFDI" "I07" "Comunicaciones satelitales.",
    ClaveSAT "UsoCFDI" "I08" "Otra maquinaria y equipo.",
    ClaveSAT "UsoCFDI" "D01" "Honorarios médicos, dentales y gastos hospitalarios.",
    ClaveSAT "UsoCFDI" "D02" "Gastos médicos por incapacidad o discapacidad.",
    ClaveSAT "UsoCFDI" "D03" "Gastos funerales.",
    ClaveSAT "UsoCFDI" "D04" "Donativos.",
    ClaveSAT "UsoCFDI" "D05" "Intereses reales efectivamente pagados por créditos hipotecarios (casa habitación).",
    ClaveSAT "UsoCFDI" "D06" "Aportaciones voluntarias al SAR.",
    ClaveSAT "UsoCFDI" "D07" "Primas por seguros de gastos médicos.",
    ClaveSAT "UsoCFDI" "D08" "Gastos de transportación escolar obligatoria.",
    ClaveSAT "UsoCFDI" "D09" "Depósitos en cuentas para el ahorro, primas que tengan como base planes de pensiones.",
    ClaveSAT "UsoCFDI" "D10" "Pagos por servicios educativos (colegiaturas).",
    ClaveSAT "UsoCFDI" "S01" "Sin efectos fiscales.  ",
    ClaveSAT "UsoCFDI" "CP01" "Pagos",
    ClaveSAT "UsoCFDI" "CN01" "Nómina",

    ClaveSAT "ObjetoImp" "01" "No objeto de impuesto.",
    ClaveSAT "ObjetoImp" "02" "Sí objeto de impuesto.",
    ClaveSAT "ObjetoImp" "03" "Sí objeto del impuesto y no obligado al desglose.",
    ClaveSAT "ObjetoImp" "04" "Sí objeto del impuesto y no causa impuesto.",
    ClaveSAT "ObjetoImp" "05" "Sí objeto del impuesto, IVA crédito PODEBI.",

    ClaveSAT "Impuesto" "001" "ISR",
    ClaveSAT "Impuesto" "002" "IVA",
    ClaveSAT "Impuesto" "003" "IEPS"
    ]
