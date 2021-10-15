/**
 * @author Madicke BALDE
 * @date 29/03/2021
 * @description classe service pour l'appel au web service Validation Paiement Par carte Bleue
 */
@RestResource(urlMapping='/api/v1/validationPaiementParCarteBleue')
global without sharing class ValidationPaiementParCarteBleue_SVC {

   @HttpPost
   global static void validationPaiement(){
       RestRequest requete = RestContext.request;
       RestResponse response = RestContext.response;
       try 
       {
           String validationnResponse = excecute(requete.requestBody);
           ValidationPaiementParCarteBleue_SVE.ValidationPaiementParCarteBleueResponse resp = new ValidationPaiementParCarteBleue_SVE.ValidationPaiementParCarteBleueResponse(validationnResponse);
           response.responseBody = Blob.valueOf(JSON.serialize(resp));
           response.statusCode = 200;

       } 
       catch (Exception e) {
        RestError_UTL.HandledException(e);
       }

   }

   public static String excecute(Blob jsonRequete){
       String response = '';
       String jsonString = jsonRequete.toString().trim();
       ValidationPaiementParCarteBleue_SVE.ValidationPaiementCBRequete requeteValidation = deserialisationRequete(jsonString);
       validationRequete(requeteValidation);
       List<Asset> assets = ValidationPaiementParCarteBleue_SVE.gestionValidationPaiementCBleue(new List<ValidationPaiementParCarteBleue_SVE.ValidationPaiementCBRequete>{requeteValidation});
       
       if(!assets.isEmpty ()){
           response = 'Paiement CB confirmé';
       }
       return response;
   }

   
   public static void  validationRequete(ValidationPaiementParCarteBleue_SVE.ValidationPaiementCBRequete requete) {
      List<String> errorFields = new List<String>();
      if(String.isEmpty(requete.reference)){
          errorFields.add('reference');
      }
      if(!errorFields.isEmpty()){
          throw new RestError_UTL.WebServiceException('Requete invalide', 'Bad_Request', 400);
      }
   }

   public class ValidationPaiementCBRequete {
     public String reference;
   }

   public static  ValidationPaiementParCarteBleue_SVE.ValidationPaiementCBRequete  deserialisationRequete(String jsonString){
    ValidationPaiementParCarteBleue_SVE.ValidationPaiementCBRequete requeteValidation;
    try 
      {
        requeteValidation = ( ValidationPaiementParCarteBleue_SVE.ValidationPaiementCBRequete) JSON.deserializeStrict(jsonString, ValidationPaiementParCarteBleue_SVE.ValidationPaiementCBRequete.class);     
      } 
    catch (Exception e)
    {
        System.debug('++++++++ eCause '+ e.getCause());
        throw new RestError_UTL.WebServiceException('Unknown field','Bad_Request', 400 );
         
    }
    return requeteValidation;
}
}