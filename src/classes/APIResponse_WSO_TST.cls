@isTest
public  class APIResponse_WSO_TST {
    
    @istest
    static void testIsOk(){
      Test.startTest();
      APIResponse_WSO apiResponse = new APIResponse_WSO();
      apiResponse.status='OK';
      apiResponse.statusCode = 200;
      System.assert(apiResponse.isOK() == true, '## pass ##');
      Test.stopTest();
    }
}