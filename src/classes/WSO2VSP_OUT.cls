/**
 * @File	WSO2VSP_OUT.cls
 * @description	classe d'invocation du web service : authentification API
 * @author 	Madicke BALDE
 * @date 	26/02/20021
 */
public   class WSO2VSP_OUT {
    /**
	* @description getToken  call WS02VSP API to get token
	* @param  namedCreditial  is the name Credintial
	* @param  methodType       is type of method
	* @param  parameters       is parameters of the external API
	* @return APIResponse_WSO  
	* @description  getToken() methode pour recupérer le token depuis WS02VSP
	*/
    public static APIResponse_WSO getToken(){
		WSO2VSP_WSI authentificationRequest = new WSO2VSP_WSI();	
		Map<String, Type> mapRespClass = new Map<String, Type>();
		mapRespClass.put('OK',WSO2VSP_WSO.class);
		mapRespClass.put('KO',WSO2VSP_KO_WSO.class);
		String accesToken='';
		HttpRequest request = new HttpRequest();
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		APIResponse_WSO response =  WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDEBTIAL_AUTHENTIFICATION, 'POST', request, authentificationRequest, mapRespClass) ;
		return response;
    }
    
  
   
  
}