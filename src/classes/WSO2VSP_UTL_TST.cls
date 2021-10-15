@istest
private class WSO2VSP_UTL_TST {
    
   
    
    @istest
    static void testCallApi (){
        
        Test.startTest();
        String body = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
                      ' "token_type": "Bearer", "expires_in": 3600  }';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200, 'OK', body);
        WSO2VSP_WSI authRequest = new WSO2VSP_WSI();
        Map<String, Type> mapResponse = new Map<String, Type>{
            'OK' => WSO2VSP_WSO.class,
            'KO' => WSO2VSP_KO_WSO.class
        };
        Test.setMock(HttpCalloutMock.class, mock);
        HttpRequest request = new HttpRequest();
        WSO2VSP_WSO authResponse = (WSO2VSP_WSO)  WSO2VSP_UTL.callApi( WSO2VSP_CST.NAMED_CREDEBTIAL_AUTHENTIFICATION,'POST',request , authRequest, mapResponse);
        System.debug('++ authResponse ++'+authResponse);
        System.assertEquals(200, authResponse.statusCode , '## pass');
        System.assertEquals('f39e2f48504e1c602c57', authResponse.access_token , '## pass');
        Test.stopTest();
    }
    
    @isTest
    static void testCallApiException (){
        Test.startTest();
        String body = '{}';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(400, 'KO', body); 
        WSO2VSP_WSI authRequest = new WSO2VSP_WSI();
        Map<String, Type> mapResponse = new Map<String, Type>{
            'OK' => WSO2VSP_WSO.class,
            'KO' => WSO2VSP_KO_WSO.class
        };
        Test.setMock(HttpCalloutMock.class, mock);
        HttpRequest request = new HttpRequest();
        WSO2VSP_KO_WSO authResponse = (WSO2VSP_KO_WSO)  WSO2VSP_UTL.callApi( WSO2VSP_CST.NAMED_CREDEBTIAL_AUTHENTIFICATION,'POST',request , authRequest, mapResponse);
        System.assertEquals('Erreur', authResponse.status, ' ### pass ');
        Test.stopTest();
    }
    
  
    @isTest
    static void testCallApiPostWithioutParams (){
        Test.startTest();
        String body = '{"access_token": "f39e2f48-5646-31e3-893f-504e1c602c57", "scope": "am_application_scope default",\n'+
        ' "tokenType": "Bearer", "expires_in": 3600  }';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(400, 'KO', body);
        WSO2VSP_WSI authRequest = new WSO2VSP_WSI();
        Map<String, Type> mapResponse = new Map<String, Type>{
            'OK' => WSO2VSP_WSO.class,
            'KO' => WSO2VSP_KO_WSO.class
        };
        HttpRequest request = new HttpRequest();
        Test.setMock(HttpCalloutMock.class, mock);
        WSO2VSP_KO_WSO authResponse = (WSO2VSP_KO_WSO)  WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDEBTIAL_AUTHENTIFICATION,'POST' , request, authRequest, mapResponse);
        System.debug(' ++++++++++ response  '+authResponse);
        System.assertEquals('Erreur', authResponse.status, '## pass ##');
        Test.stopTest();
    }
    
    @isTest
    static void testCallApiStatusKO (){
      Test.startTest();
      String body = '{ "error_description": "Invalid grant_type parameter value",  "error": "invalid_request"  }';
      WSO2VSP_MCK mock = new WSO2VSP_MCK(400, 'KO', body);
      WSO2VSP_WSI authRequest = new WSO2VSP_WSI();
      HttpRequest request = new HttpRequest();
      request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
      Map<String, Type> mapResponse = new Map<String, Type>{
          'OK' => WSO2VSP_WSO.class,
          'KO' => WSO2VSP_KO_WSO.class
      };
      Test.setMock(HttpCalloutMock.class, mock);
      WSO2VSP_KO_WSO authResponse = (WSO2VSP_KO_WSO)  WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDEBTIAL_AUTHENTIFICATION ,'POST', request,authRequest, mapResponse);
      System.debug('+++++++++++ authResponse '+authResponse);
      System.assertEquals('Invalid grant_type parameter value', authResponse.error_description, '++ pass ');
      Test.stopTest();
    }
    @isTest
    static void testCallApiExceptionErreur(){
        String body = '{ "error_description": "Invalid grant_type parameter value",  "error": "invalid_request"  }';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(400, 'KO', body);
        Test.startTest();
        WSO2VSP_WSI authRequest = new WSO2VSP_WSI();
        Map<String, Type> mapRespClass = new Map<String, Type>{
            'OK' => WSO2VSP_WSO.class,
            'KO' => WSO2VSP_KO_WSO.class
        };
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', 'application/json');
        String  authorizationHeader = 'Bearer ' + 'xhdh69854d66D6DGS';
        request.setHeader('authorization', authorizationHeader);
        Test.setMock(HttpCalloutMock.class, mock);
        APIResponse_WSO apiResponse =  WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDENTIAL_SIGNATURE , 'POST', request, authRequest, mapRespClass);
        System.debug('+++++++ apiresponse ++ '+ apiResponse);
        Test.stopTest();
    }
}