/**
 * @author Madicke BALDE
 * @description classe de gestion des logs du flux confirmation Contrat
 * @date 24/03/2021
 */
public with sharing class ConfirmationContratLog implements  WSOVSPLog {
  
    public void createLog (APIResponse_WSO resp, HttpRequest req, String  exceptionMessage ){
        String flux = 'FLUX Confirmation Contrat';
        Datetime dateHeureErreur = Datetime.now();
        String codeErreurFlux ;
        String messageErreur='';
        String fluxJsonSoapEnvoye = req.getBody() ;
        String statusDuFlux;
        if(resp.statusCode != 200){
            ConfirmationContrat_WSO confirmation = (ConfirmationContrat_WSO) resp;
            statusDuFlux = 'Erreur';
            codeErreurFlux = String.valueOf(confirmation.statusCode);
            if(confirmation.fault != null ){
                messageErreur = (String.isEmpty(exceptionMessage ))?confirmation.fault.description: exceptionMessage; 
            }

        }
    }
   
}