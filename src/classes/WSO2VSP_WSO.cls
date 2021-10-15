/**
 * @description structure de la response du Web service de l'authentification
 * @author Madicke BALDE
 * @date 26/02/20021
 */
public  class WSO2VSP_WSO  extends APIResponse_WSO {

    public String access_token ;
    public String scope ;
    public String token_type ;
    public String expires_in;

    public WSO2VSP_WSO (){}
 
}