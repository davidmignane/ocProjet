/**
 * @author Madicke BALDE
 * @description classe de gestions des logs pour l'appel de service Authentification
 * @date 05/03/2021
 */
public  class AuthentificationLog  implements WSOVSPLog {
    
    /**
     * @description pour créer les logs lorsque le web service Authentification WSO2VSP est appelé
     * @param   resp    : la response du flux
     * @param   req     : la requete du flux
     * @param   exceptionMessage : message del'exception@
     */
    public void createLog (APIResponse_WSO resp, HttpRequest req, String  exceptionMessage ){
      
       
        String flux = 'FLUX';
        Datetime dateHeureErreur = Datetime.now();
        String codeErreurFlux ;
        String messageErreur='';
        String fluxJsonSoapEnvoye = req.getBody() ;
        String statusDuFlux;

        if(resp.statusCode == 200){
             statusDuFlux = 'OK';
             codeErreurFlux = String.valueOf(resp.statusCode);
        }
        else {
            WSO2VSP_KO_WSO ws = (WSO2VSP_KO_WSO) resp;
            System.debug('+++++++++++ ws log '+ ws);

            statusDuFlux = 'Erreur';
            codeErreurFlux = String.valueOf(resp.statusCode);
            messageErreur = (String.isEmpty(exceptionMessage ))?ws.error_description: exceptionMessage;
            //String logId = GestionLog_UTL.creerLog(new GestionLog_UTL.GestionErreurDTO(flux,'callApi',dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye,statusDuFlux, ' ' ));
        }

         
    }
   
}