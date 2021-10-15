/**
 * @author Madicke BALDE
 * @description
 */
public with sharing class ConfirmationContrat_OUT {
    
    public static ConfirmationContrat_WSO confirmerContrat (ConfirmationContrat_WSI contrat, String accessToken){
        ConfirmationContrat_WSO confirmationContrat = new ConfirmationContrat_WSO();
        Map<String, Type> mapRespClass = new Map<String, Type>
        {
            'OK' => ConfirmationContrat_WSO.class,
            'KO' => ConfirmationContrat_WSO.class
        };
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        String  authorizationHeader = 'Bearer ' + accessToken;
        request.setHeader('authorization',  authorizationHeader);
        APIResponse_WSO apiResponse =  WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDEBTIAL_CONFIRMATION_CONTRAT , 'POST', request, contrat, mapRespClass);
        confirmationContrat = (ConfirmationContrat_WSO) ((APIXMLResponse_WSO) apiResponse);
        System.debug('++++++++++ sign +++ '+confirmationContrat);
        saveConfirmationContratLog(confirmationContrat, request);
       
        return confirmationContrat;

    }
     /**
     * @description saveSignatureLog permet de sauvegarder les logs pour le flux Signature Electronique
     * @param responseSignature : response du web service (Signature electronique)
     * @param req : flux attendus par le web service
     */
    public static void saveConfirmationContratLog(ConfirmationContrat_WSO confirmationContrat, HttpRequest req){
        String statusFlux = confirmationContrat.status;
        Datetime dateHeureErreur = Datetime.now();
        String fluxJsonSoapEnvoye = req.getBody() ;
        String codeErreurFlux  = String.valueOf(confirmationContrat.statusCode); 
        String messageErreur= '';
        if(confirmationContrat.fault != null ){
            messageErreur = confirmationContrat.fault.description; 
        }
        else if (confirmationContrat.erreurs != null && confirmationContrat.erreurs.size() > 0 ){
            messageErreur = confirmationContrat.erreurs.get(0).libelle_long;
        }
        else {
            messageErreur = confirmationContrat.message_retour;
        }
        String logId = GestionLog_UTL.creerLog(new GestionLog_UTL.GestionErreurDTO('FLUX Confirmation Contrat','saveConfirmationContratLog',dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye,statusFlux, ' ' ));
      }
}