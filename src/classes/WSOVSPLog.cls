/**
 * @author Madicke BALDE
 * @description interface de gestion des logs
 * @date 05/03/2021
 */
public interface WSOVSPLog {
     /**
      * @description     :  createLog permet des logs pour les flux sortants  
      * @param resp      :  APIResponse_WSO response du web service
      * @param req       :  HttpRequest  requete attendu par le web service
      * @param exceptionMessage : message en cas d'exception
      */
     void createLog(APIResponse_WSO resp, HttpRequest req, String exceptionMessage );
}