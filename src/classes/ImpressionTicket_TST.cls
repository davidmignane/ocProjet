/**
 * Created by terangacloud on 28.06.2021.
 */
@istest
public with sharing class ImpressionTicket_TST {
    @istest
    static void testImpressionTicket(){
        Account accountRecord = new Account();
        accountRecord.Name = 'Business';
        insert accountRecord;
        Asset asset = new Asset();
        asset.Tech_identifiantProcedureYousign__c = '/procedures/123AAA' ;
        asset.Name = '123AAA' ;
        asset.AccountId = accountRecord.Id ;
        //asset.CreatedDate = (Datetime) '2021-03-15' ;
        Date myDate = Date.newInstance(2021, 3, 15);
        asset.dateConfirmationSignatureMandatYousign__c = myDate; //(Datetime) '2021-03-15' ;
        asset.RUM__c = '500109397' ;
        asset.identifiantFichierMandatSignYousign__c = '22222CCCC' ;
        insert asset;
        String assetRecord  = [ select id, Name, Ext_OGIContractID__c,account.personContactID,Tech_identifiantProcedureYousign__c,
                PaperSign__c,CreatedDate,dateConfirmationSignatureMandatYousign__c,RUM__c,identifiantFichierMandatSignYousign__c
        from Asset LIMIT 1].Id;
        List<Id> ids = new List<Id>();
        ids.add(assetRecord);

        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';

        String body2 = '{"statusCode" : 200, "status":"Ok","code_reponse":null,"message_reponse":null,"status_transaction":null}';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200, 'OK','Ok', body1, body2);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        ImpressionTicket_ITF.imprimerTicket(ids);
        Test.stopTest();
    }
}