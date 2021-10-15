/**
 * @File        :   WSO2VSP_SVE.cls 
 * @description :   Classe service de gestion de l'authentification
 * author       :   Madicke BALDE   
 * @date        :   26/02/2021 
 */
public  class WSO2VSP_SVE {
    
    /**
     * @description :   getToken recupere le token qui sera utilisé par les autres flux sortants
     * @param   parameters : Map<String,String> correspond aux paramtres attendus
     * @param   methodType : String le type requete : POST/Get
     * @return             : String  le token 
     */
    public static Map<String,Object> getToken(){
        Map<String, Object> responseValue = new Map<String, Object>();
        responseValue.put('erreur', false);
        APIResponse_WSO response = WSO2VSP_OUT.getToken();
        if(response.statusCode == 200){
            responseValue.put('token', ((WSO2VSP_WSO) response).access_token );
           
        }
        else {
            responseValue.put('erreur', true);
        }
        return responseValue;
    }

   
}