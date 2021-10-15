/**
 * @author Madicke BALDE
 * @description classe d'invoquation du web service pour la gestion de la signature electronique
 * @date 08/03/2021
 */
public with sharing class SignatureElectronique_OUT {
    
    /**
     * @description creerSignature permet d'invoquer WSO2 pour la signature electronique
     * @param signatureElectroniqueRequete  : structure de données attendues par le WSO2
     * @param accesToken                    : token recupére pour l'authentification
     * @return SignatureElectronique_WSO    : la structure de données recu aupres de WSO2
     */
    public static SignatureElectronique_WSO creerSignature (SignatureElectronique_WSI signatureElectroniqueRequete, String accesToken){
        SignatureElectronique_WSO  signatureResponse = new  SignatureElectronique_WSO ();
        System.debug('++++ token ++'+ accesToken);
        Map<String, Type> mapRespClass = new Map<String, Type>
        {
            'OK' => SignatureElectronique_WSO.class,
            'KO' => SignatureElectronique_WSO.class
        };
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        String  authorizationHeader = 'Bearer ' + accesToken;
        request.setHeader('authorization', authorizationHeader);
        APIResponse_WSO apiResponse =  WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDENTIAL_SIGNATURE , 'POST', request, signatureElectroniqueRequete, mapRespClass);
        signatureResponse = (SignatureElectronique_WSO) ((APIXMLResponse_WSO) apiResponse);
    
        saveSignatureLog(signatureResponse, request);
        return signatureResponse;
    }
    /**
     * @description saveSignatureLog permet de sauvegarder les logs pour le flux Signature Electronique
     * @param responseSignature : response du web service (Signature electronique)
     * @param req : flux attendus par le web service
     */
    public static void saveSignatureLog(SignatureElectronique_WSO responseSignature, HttpRequest req){
      String statusFlux = responseSignature.status;
      Datetime dateHeureErreur = Datetime.now();
      String fluxJsonSoapEnvoye = req.getBody() ;
      String codeErreurFlux  = String.valueOf(responseSignature.statusCode); 
      String messageErreur ='';
     
      if (responseSignature.status_signature == 'active' && !String.isEmpty(responseSignature.url_signature) && !String.isEmpty(responseSignature.identifiant_procedure) ) {
          messageErreur= 'Procedure de Signature Electronique créée avec succès';
      }
      else if(responseSignature.erreurs != null && responseSignature.erreurs.size() > 0  ){
            messageErreur = responseSignature.erreurs.get(0).libelle_erreur;
      }
      else if (responseSignature.fault != null){
           messageErreur = responseSignature.fault.description;
      }
      else if (responseSignature.html != null){
           messageErreur = responseSignature.html.body.h1+' '+responseSignature.html.body.ele_text;
      }
     
      String logId = GestionLog_UTL.creerLog(new GestionLog_UTL.GestionErreurDTO('Signature Youssign ','saveSignatureLog',dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye,statusFlux, ' ' ));
    }
    
}