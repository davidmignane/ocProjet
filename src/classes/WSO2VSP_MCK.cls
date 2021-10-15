/**
 * @author Madicke BALDE
 * @description  classe utilitaire pour simuler les appels sortants dans les classe de test 
 * @Date 01/03/2021
 **/
@istest
public class WSO2VSP_MCK implements HttpCalloutMock {
    public Integer statusCode;
    public Integer statusCode2;
    public String status;
    public String status2;
    public String body;
    public String body2;
    public static  Boolean isExecuteFirst = false;
    
    /**
     * @description      :   constructeur de la classe WSO2VSP_MCK
     * @param  code      :   code de retour de la response du flux sortnt
     * @param  status    :   status du flux sortant
     * @param  body      :   corps de la response
     */
    public WSO2VSP_MCK(Integer code, String status, String body){
           this.statusCode = code;
           this.status = status;
           this.body = body;
    }
    public WSO2VSP_MCK(Integer code, String status, String body, String body2){ 
        this.statusCode = code;
        this.status = status;
        this.body = body;
        this.body2 = body2;
    
    }
    public WSO2VSP_MCK(Integer code,Integer code2, String status, String status2,String body, String body2){
        this.statusCode = code;
        this.statusCode2 = code2;
        this.status = status;
        this.status2 = status2;
        this.body = body;
        this.body2 = body2;

    }
    
    /**
     * @description         :   respond  permet de simuler la response
     * @param   HttpRequest :   requete attendue par le web service
     * @return              :   HttpResponse
     */
    public HttpResponse respond (HttpRequest request)
    {
        System.debug('++++++ isExecute '+ isExecuteFirst);
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatus(this.status);
        response.setStatusCode(this.statusCode);

        if(!isExecuteFirst) {
            response.setBody(this.body);
            isExecuteFirst = true;
        }
        else {
               System.debug('++++++++ body2 execute '+ this.body2);
               response.setBody(this.body2);
               response.setStatus(this.status2);
               response.setStatusCode(this.statusCode2);
        }
       
        return response;
    }
}