/**
 * @author Madicke BALDE
 * @description classe de test de la classe WSO2VSP_SVE
 * @date 30/03/2021
 */
@isTest 
private class WSO2VSP_SVE_TST {
    
    @isTest
    static void testGetToken(){
        Test.startTest();
        String body = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                        ' "tokenType": "Bearer", "expires_in": 3600  }';
        WSO2VSP_MCK mck = new WSO2VSP_MCK(200,'OK', body);
        Test.setMock(HttpCalloutMock.class, mck);
        Map<String, String> parameters = new Map<String, String>();
        parameters.put('grant_type', 'client_credentials');
        Map<String,Object> mapToken = WSO2VSP_SVE.getToken();
        System.debug('++++++ mapToken '+mapToken);
        System.assertNotEquals(null, (String) mapToken.get('token'), '## pass ##');
        System.assertEquals(false, (Boolean) mapToken.get('erreur'), '## pass ##');
        Test.stopTest();
    }                                              
    
    @isTest
    static void testGetTokenNull(){
        Test.startTest();
        String body = '{"access_token": "", "scope": "am_application_scope default",\n'+
                        ' "tokenType": "Bearer", "expires_in": 3600  }';
        WSO2VSP_MCK mck = new WSO2VSP_MCK(400,'K0', body);
        Test.setMock(HttpCalloutMock.class, mck);
        Map<String, String> parameters = new Map<String, String>();
        parameters.put('grant_type', 'client_credentials');
        Map<String,Object> mapToken = WSO2VSP_SVE.getToken();
        System.assertEquals(null, (String) mapToken.get('token'), '## pass ##');
        System.assertEquals(true, (Boolean) mapToken.get('erreur'), '## pass ##');
        Test.stopTest();
    }                 
}