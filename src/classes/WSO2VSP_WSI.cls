/**
 * @description      
 * @author      :   Madicke BALDE
 * @date        :   26/02/2021
 */
public  class WSO2VSP_WSI extends APIRequest_WSI {
 
  
   public override Map<String, String> getParameters() {
        Map<String, String> parameters = new Map<String, String>();
        parameters.put('grant_type', 'client_credentials');
        return parameters;
   }
}