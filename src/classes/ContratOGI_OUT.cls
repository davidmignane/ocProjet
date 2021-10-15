/**
 * @File	ContratOGI_OUT.cls
 * @description classe de gestion de l'appel du callApi
 * @author 	David Diop
 * @date 	03/03/2021
 */

public class ContratOGI_OUT {
    public static APIResponse_WSO getContratOGI(ContratOGI_WSI contratOGIrequete, String methodType,String accessToken){
        Map<String, Type> mapRespClass = new Map<String, Type>();
        //mapRespClass.put('OK',ContratOGI_WSO.class);
        mapRespClass.put('OK',ContratOGI_OK_WSO.class);
        //mapRespClass.put('KO',ContratOGI_KO_WSO.class);
        mapRespClass.put('KO',ContratOGI_OK_WSO.class);
        APIResponse_WSO response= new APIResponse_WSO() ;
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        String  authorizationHeader = 'Bearer ' + accessToken;
        request.setHeader('authorization', authorizationHeader);
        response = (APIResponse_WSO) WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDENTIAL_SUBSCRIPTION, methodType,request, contratOGIrequete, mapRespClass);
        System.debug('responsetest'+response);

        return response;
    }
}