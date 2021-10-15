@istest
public  class VSP_UTL_TST {
    @TestSetup
    static void makeData(){
        WSO2VSPDataFactory_TST.buildAccountObject();
        WSO2VSPDataFactory_TST.buildEmailTemplateObject();
        
        
    }
    
    @istest
    static void testSendEmail(){
      
        Asset asset = WSO2VSPDataFactory_TST.buildAssetObject().get(0);
        Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
        asset.AccountId = account.Id;
        upsert asset;

        Test.startTest();
       
        Id contactId = account.PersonContactId;

        VSP_UTL.sendEmail(asset.Id, contactId, 'SubscriptionEmail', null);
		//LiensPaie

        Test.stopTest();

    }

    
}