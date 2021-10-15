/**
 * @author Madicke BALDE
 * @description classe de gestion des erreurs
 * @date 18/03/2021
 */
public with sharing class RestError_UTL {
    /**
     * @description classe wrapper 
     */
    public class Response {
        public String errorCode;
        public String message;
        public Response (String errorCode, String message){
            this.errorCode = errorCode;
            this.message = message;
        }
    }
    /**
     * @description  classe wrapper de gestion des gestions
     */
    public virtual class RestException extends Exception {
        public Response errorResp;
        public Integer statusCode;
        public RestException(String message, String errorCode, Integer statusCode){
            this.setMessage(message);
            this.errorResp = new Response(errorCode, message);
            this.statusCode = statusCode;
        }
    }
    /**
     * @description mentode de gestion des gestions
     */
    public static void HandledException(Exception err){
        RestResponse response = RestContext.response;
        if (err instanceof RestException) {
            RestException restErr = (RestException) err;
            WebService_UTL.GeneriqueResponse resp = new WebService_UTL.GeneriqueResponse( new WebService_UTL.ErreurResponse (restErr.errorResp.errorCode, restErr.errorResp.message) );
            response.statusCode = restErr.statusCode;
            resp.status = 'KO';
            response.responseBody = Blob.valueOf(JSON.serialize( resp ));
        } else {
            throw err; //let salesforce deal with it
        }
    }

   
    /**
     * @description methode de traitement des exception 
     * @exemple  exception de déserialisation
     */
    public class WebServiceException extends RestException {
        public WebServiceException (String message, String addInfo, Integer code){
              super(message, addInfo, code);
        }
    }
}