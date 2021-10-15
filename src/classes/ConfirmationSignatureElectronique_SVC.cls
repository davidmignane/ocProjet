/**
 * @author Madicke BALDE
 * @description web service permettant la confirmation de la signature
 * @date 18/03/2021
 */
@RestResource(UrlMapping='/api/v1/confirmationSignature')
global without sharing class ConfirmationSignatureElectronique_SVC {
   
   /**
    * @description traite les requétes entrantes de type POST
    */
   @httpPost
   global static void confirmationSignature(){
       RestRequest requete = RestContext.request;
       RestResponse response = RestContext.response;
       try {
            String resp = execute(requete.requestBody );
            ConfirmationSignatureElectronique_SVE.ConfirmationSignatureReponse confirmation = new ConfirmationSignatureElectronique_SVE.ConfirmationSignatureReponse(resp);
            response.responseBody = Blob.valueOf(JSON.serialize(confirmation));
            response.statusCode = 200;
          } 
          catch (Exception e) {
             RestError_UTL.HandledException(e);
       }
   }
   
   /**
    * @description methode permettant de traiter la body de la requéte
    * @param requestBody : le corps de la requéte
    * @return String : correspond à la réponse à renvoyé  
    */
   public static String execute(Blob requestBody) {
       String response ;
       String jsonString  = requestBody.toString().trim();
       ConfirmationSignatureElectronique_SVE.ConfirmationSignatureWrapper requeteDeConfirmation = deserialisationRequete(jsonString);
       validerRequete(requeteDeConfirmation);
       List<Asset> assets = ConfirmationSignatureElectronique_SVE.manageSignature(new List<ConfirmationSignatureElectronique_SVE.ConfirmationSignatureWrapper>{requeteDeConfirmation});
       System.debug('++++ assets +++ '+ assets);
       if(assets.size() > 0 ){
           response = 'signature confirmée';
       }
       return response; 
   }
   /**
    * @description methode de validation de la requéte : renvoie une exception en cas de champs non valide
    * @param requeteConfirmation : contient le body de la requéte sous forme d'object
    */
   public static void validerRequete( ConfirmationSignatureElectronique_SVE.ConfirmationSignatureWrapper requeteConfirmation){
       List<String> errorFields = new List<String>();
       if(String.isBlank(requeteConfirmation.IdentifiantFichierMandatSigneYousign)){
           errorFields.add('IdentifiantFichierMandatSigneYousign');
       }
       if(String.isBlank(requeteConfirmation.identifiantProcedureYousign) ){
           errorFields.add('identifiantProcedureYousign');
       }
     
       if(!errorFields.isEmpty()){
           //String.join(errorFields, ' ,')
           throw new RestError_UTL.WebServiceException('Bad Request missing required fields values', 'Bad_Request', 400 );
       }
   }

   /**
    * @description  methode de deserialisation du corps de la requéte de type string en objet
    * @param jsonString : le corps de la requéte en String
    * @return ConfirmationSignatureWrapper objet de déserialisation
    */
   public static  ConfirmationSignatureElectronique_SVE.ConfirmationSignatureWrapper  deserialisationRequete(String jsonString){
       ConfirmationSignatureElectronique_SVE.ConfirmationSignatureWrapper requeteConfirmation;
       try 
         {
                requeteConfirmation = ( ConfirmationSignatureElectronique_SVE.ConfirmationSignatureWrapper) JSON.deserializeStrict(jsonString, ConfirmationSignatureElectronique_SVE.ConfirmationSignatureWrapper.class);     
         } 
       catch (Exception e)
       {
           System.debug('++++++++ eCause '+ e.getCause());
           throw new RestError_UTL.WebServiceException('Unknown field','Bad_Request', 400 );
            
       }
       return requeteConfirmation;
   }


   
}