/**
 * @File            :   WSO2VSP_UTL.cls      
 * @description     :   Classe Utilitaire de WSO2VSP
 * @author          :   Madicke BALDE   
 * @date            :   26/02/2021
 */
public with sharing class  WSO2VSP_UTL {
    
    /**
     * @description             :   callApi() permet de gérer tous les appels sortants
     * @param   namedCredential :   le nom du "named Credential"
     * @param   request         :   la requéte attendue par le web service externe
     * @param   respClass       :   la response venant du web service
     * @return  APIResponse_WSO :   la response du web service
     * @date 26/02/2021
     * @exception x
     */
  
    public static APIResponse_WSO callApi(String namedCredential, String methodType, HttpRequest req, APIRequest_WSI request, Map<String,Type> mapRespClass){

        Http h = new Http();
        String credentialName = 'callout:'+namedCredential;
        String statusFlux;
        String erreurMessage;
        String authorizationHeader;

        if(request != null){
                     Map<String,String> parameters = request.getParameters();
                     System.debug('++++++++ parameter '+ parameters );
                    if(methodType == 'GET' || ( methodType == 'POST'&& !parameters.isEmpty() )){
                            String fullUrl = request.getFullUrl(parameters, credentialName);
                            req.setEndpoint(fullUrl);
                            System.debug('++++ Full Url :'+fullUrl);
                            if(methodType == 'POST'){
                                req.setBody(JSON.serialize(request));
                                System.debug('get body '+ req.getBody());
                            }
                           
                    }
                    else {
                            req.setEndpoint(credentialName);
                            req.setBody(JSON.serialize(request));
                            System.debug('Api Request: '+req.getBody());
                    }
        }         
        req.setMethod(methodType);
        req.setTimeout(WSO2VSP_CST.TIMEOUT);
        Map<String, WSO2VSPSerializer> serializerMap = new Map<String, WSO2VSPSerializer>();
        serializerMap.put('application/json', new WSO2VSPJSONSerializer() );
        serializerMap.put('application/json; charset=UTF-8', new WSO2VSPJSONSerializer() );
        serializerMap.put('application/xml; charset=UTF-8', new WSO2VSPXMLSerializer() ); 
        serializerMap.put('application/json; charset=utf-8', new WSO2VSPJSONSerializer() );
        serializerMap.put('text/xml', new WSO2VSPXMLSerializer() );
        serializerMap.put('text/html', new WSO2VSPXMLSerializer() );

        APIResponse_WSO res= new APIResponse_WSO();
        HttpResponse response = new HttpResponse();
        String exceptionMessage;
      
        response = h.send(req);
        String contentType = (response.getHeader('Content-Type') == null ?'content-type':'Content-Type');
        System.debug('contentType ==='+contentType);
        if(response.getStatusCode() == 200)
        {
            res= (APIResponse_WSO)  mapRespClass.get('OK').newInstance();
            res = (APIResponse_WSO) (serializerMap.get(response.getHeader(contentType)).deserialize(response, mapRespClass.get('OK') ));
            res.status = 'OK';
        }
        else 
        {

            res= (APIResponse_WSO)  mapRespClass.get('KO').newInstance();
            if(response.getHeader(contentType) != null) {
                System.debug('999 ++ '+ serializerMap);
                System.debug('999 ++ '+ serializerMap.get(response.getHeader(contentType)));
            res = (APIResponse_WSO) (serializerMap.get(response.getHeader(contentType)).deserialize(response, mapRespClass.get('KO') ));
        }
            System.debug(' res xml '+res);
            res.status = 'Erreur';
        }
        res.statusCode = response.getStatusCode();
        return res; 
    }
  

   
}