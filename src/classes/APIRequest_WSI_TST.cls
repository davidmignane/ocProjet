@isTest
private class APIRequest_WSI_TST {
    
    @istest
    static void testGetParameters(){
      Test.startTest();
      APIRequest_WSI request = new APIRequest_WSI();
      Map<String,String> parameters = request.getParameters();
      System.debug('+++++ params '+parameters);
      System.assertEquals(0, parameters.size(), '### pass ');
      Test.stopTest();
    }
    
    @isTest
    static void testGetFullUrl(){
        Test.startTest();
        Map<String,String> parameters = new   Map<String,String>();
        parameters.put('grant_type', 'credential');
        APIRequest_WSI request = new APIRequest_WSI();
        String fullUrl = request.getFullUrl(parameters, 'http://test.com');
        System.debug('++++++++++ fullUrl'+ fullUrl);
        System.assertEquals('http://test.com?grant_type=credential', fullUrl, '++ pass');

        Test.stopTest();

    }
}