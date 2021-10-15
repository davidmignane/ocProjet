/**
 * @File	UrlPaiementMonetico_OUT.cls
 * @description classe de gestion de l'appel du callApi pour la recuperation de l'url de paiement monetico
 * @author 	David Diop
 * @date 	22/03/2021
 */
public class UrlPaiementMonetico_OUT {
    public static APIResponse_WSO getUrlPaiement(UrlPaiementMonetico_WSI urlPaiementRequete, String methodType,String accessToken){
        Map<String, Type> mapRespClass = new Map<String, Type>();
        mapRespClass.put('OK',UrlPaiementMonetico_WSO.class);
        mapRespClass.put('KO',UrlPaiementMonetico_KO_WSO.class);
        APIResponse_WSO response= new APIResponse_WSO() ;
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        String  authorizationHeader = 'Bearer ' + accessToken;
        request.setHeader('authorization', authorizationHeader);
        response = (APIResponse_WSO) WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDENTIAL_URLPAIEMENT, methodType,request, urlPaiementRequete, mapRespClass);
        System.debug('responsetest'+response);

        return response;
    }
}