/**
 * 
 */
public with sharing class SignatureElectroniqueLog implements WSOVSPLog {
    public void createLog (APIResponse_WSO resp, HttpRequest req, String  exceptionMessage ){
        System.debug('++++++++++ SignatureElectroniqueLog 2 '+resp.statusCode );
        String flux = 'FLUX';
        Datetime dateHeureErreur = Datetime.now();
        String codeErreurFlux ;
        String messageErreur='';
        String fluxJsonSoapEnvoye = req.getBody() ;
        String statusDuFlux;
        if(resp.statusCode != 200){
            SignatureElectronique_WSO signatureResponse = (SignatureElectronique_WSO) resp;
            statusDuFlux = 'Erreur';
            codeErreurFlux = String.valueOf(signatureResponse.statusCode);
            if(signatureResponse.erreurs != null && signatureResponse.erreurs.size() > 0){
    
                messageErreur =  (String.isEmpty(exceptionMessage ))?signatureResponse.erreurs[0].libelle_erreur : exceptionMessage;
            }
            else {
                if(signatureResponse.fault != null){
                    messageErreur = (String.isEmpty(exceptionMessage ))?signatureResponse.fault.description: exceptionMessage; 
                }
                else if (signatureResponse.html != null){
                    messageErreur = signatureResponse.html.body.h1+ ' ' + signatureResponse.html.body.ele_text;
                }
               
            }
            String logId = GestionLog_UTL.creerLog(new GestionLog_UTL.GestionErreurDTO(flux + ' Signature Youssing','callApi',dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye,statusDuFlux, ' ' ));
        }
    }
}