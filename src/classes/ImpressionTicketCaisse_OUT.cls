/**
* @File	ImpressionTicketCaisse_OUT.cls
 * @description classe de gestion de l'appel du callApi pour l'impression du ticket caisse
 * @author 	David Diop
 * @date 	26/03/2021
 */

public class ImpressionTicketCaisse_OUT {
    public static APIResponse_WSO imprimmerTcketCaisse(ImpressionTicketCaisse_WSI ticketCaisseRequete, String methodType,String accessToken){
        Map<String, Type> mapRespClass = new Map<String, Type>();
        mapRespClass.put('OK',ImpressionTicketCaisse_WSO.class);
        mapRespClass.put('KO',ImpressionTicketCaisse_KO_WSO.class);
        APIResponse_WSO response= new APIResponse_WSO() ;
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        String  authorizationHeader = 'Bearer ' + accessToken;
        request.setHeader('authorization', authorizationHeader);
        response = (APIResponse_WSO) WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDENTIAL_ImpressionTicket, methodType,request, ticketCaisseRequete, mapRespClass);
        System.debug('responsetest'+response);

        return response;
    }
}