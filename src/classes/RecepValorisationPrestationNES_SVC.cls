/**
 * @description       : 
 * @author            : David Mignane Diop
 * @group             : 
 * @last modified on  : 10-05-2021
 * @last modified by  : David Mignane Diop
**/
@RestResource(UrlMapping='/api/v1/ClaimLineItemRepairValue')
global without sharing class RecepValorisationPrestationNES_SVC {
    @httpPost
    global static void  valoriserPrestationNES(){
        RestRequest requete = RestContext.request;
       RestResponse response = RestContext.response;
       try {
           String resp = execute(requete.requestBody);
       }
       catch (Exception e){
        RestError_UTL.HandledException(e);
       }
    }

    public static String execute(Blob requestBody) {
        String response ;
        String jsonString  = requestBody.toString().trim();
        RecepValorisationPrestationNES_SVE.PrestationNESWrapper requeteDeValorisation = deserialisationRequete(jsonString);
        System.debug('RecepValorisationPrestationNES_SVE.PrestationNESWrapper'+requeteDeValorisation);
        response = RecepValorisationPrestationNES_SVE.managePrestationNES(requeteDeValorisation);
        return response; 
    }

    public static  RecepValorisationPrestationNES_SVE.PrestationNESWrapper  deserialisationRequete(String jsonString){
        RecepValorisationPrestationNES_SVE.PrestationNESWrapper requete;
        try 
          {
            requete = ( RecepValorisationPrestationNES_SVE.PrestationNESWrapper) JSON.deserializeStrict(jsonString, RecepValorisationPrestationNES_SVE.PrestationNESWrapper.class);     
          } 
        catch (Exception e)
        {
            System.debug('++++++++ eCause '+ e.getMessage());
            throw new RestError_UTL.WebServiceException('Unknown field','Bad_Request', 400 );
             
        }
        return requete;
    }

}