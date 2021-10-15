/**
 * Created by DAVID DIOP on 31.03.2021.
 */
@istest
public with sharing class ActivationContrat_TST {
    @istest
    static void testConfirmerContrat(){
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

        String bodyResponseToken = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
                ' "token_type": "Bearer", "expires_in": 3600  }';

        String bodyResponseConfirmationSign = '{"code_retour" : "02","message_retour" : "Enregistrement effectué","date_debut_prelevement" : "2021-03-24","date_fin_prelevement" :" 2021-03-25","erreurs" : [ {"code_retour" :"02","libelle_court" : "test ","libelle_long"  : "long libbele","libelle_tech"  : "tech libelle","type": "type"}]}';
        Test.startTest();
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200,'OK', 'OK', bodyResponseToken, bodyResponseConfirmationSign);
        Test.setMock(HttpCalloutMock.class, mock);
        ActivationContrat_ITF.activerContrat(ids);
        Test.stopTest();
    }
}