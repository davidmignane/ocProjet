@istest
public with sharing class ValidationPaiementParCarteBleue_TST {

    @TestSetup
    static void makeData(){
        WSO2VSPDataFactory_TST.buildAccountObject();
    }
    
    @istest
    static void testValidationPaiement(){
       
        User u = WSO2VSPDataFactory_TST.addnewUser('mbuser','test@gmail.com', 'user1', 'api.interface@verspieren.fr.dev2', 'System Administrator');
        System.runAs(u){
            Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
      
        BypassValidationRule__c bypass = WSO2VSPDataFactory_TST.addByPassValidationRule();
        bypass.SetupOwnerId = u.Id;
        bypass.Asset__c = true;
        update bypass;
        List<Asset> assets = WSO2VSPDataFactory_TST.buildAssetObject();
        for( Asset asset : assets){
            asset.AccountId = account.Id;
        }
        insert assets;
        Test.startTest();
        String bodyResponseToken = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
        ' "token_type": "Bearer", "expires_in": 3600  }';

        String bodyResponseConfirmationSign = '{"code_retour" : "02","message_retour" : "Enregistrement effectué","date_debut_prelevement" : "2021-03-24","date_fin_prelevement" :" 2021-03-25","erreurs" : [ {"code_retour" :"02","libelle_court" : "test ","libelle_long"  : "long libbele","libelle_tech"  : "tech libelle","type": "type"}]}';
     
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200,'OK', 'OK', bodyResponseToken, bodyResponseConfirmationSign);
        Test.setMock(HttpCalloutMock.class, mock);
        
        String jsonRequest = '{ "reference": "226ec37"}';
        RestRequest requete = new RestRequest();
        RestResponse response = new RestResponse();
        requete.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/api/v1/confirmationSignature';
        requete.httpMethod='POST';
        requete.requestBody = Blob.valueOf(jsonRequest);
        RestContext.request = requete;
        RestContext.response = response;
        ValidationPaiementParCarteBleue_SVC.validationPaiement();
        ValidationPaiementParCarteBleue_SVE.ValidationPaiementParCarteBleueResponse reponse = (ValidationPaiementParCarteBleue_SVE.ValidationPaiementParCarteBleueResponse) JSON.deserializeStrict(response.responseBody.toString(), ValidationPaiementParCarteBleue_SVE.ValidationPaiementParCarteBleueResponse.class);
        System.debug('+++ reponse test '+reponse);
        System.assertEquals('OK', reponse.status, '## pass ##');
        System.assertEquals(200, response.statusCode, '## pass ##');

        Test.stopTest();
     }
    }

    @istest
    static void testValidationPaiementBadRequest(){
        Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
     
        List<Asset> assets = WSO2VSPDataFactory_TST.buildAssetObject();
        for( Asset asset : assets){
            asset.AccountId = account.Id;
        }
        insert assets;
        Test.startTest();
        String jsonRequest = '{ "references": "226ec37"}';
        RestRequest requete = new RestRequest();
        RestResponse response = new RestResponse();
        requete.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/api/v1/confirmationSignature';
        requete.httpMethod='POST';
        requete.requestBody = Blob.valueOf(jsonRequest);
        RestContext.request = requete;
        RestContext.response = response;
        ValidationPaiementParCarteBleue_SVC.validationPaiement();
        WebService_UTL.GeneriqueResponse reponse = (WebService_UTL.GeneriqueResponse) JSON.deserializeStrict(response.responseBody.toString(), WebService_UTL.GeneriqueResponse.class);
        System.debug('+++ reponse test '+reponse);
        System.assertEquals('KO', reponse.status, '## pass ##');
        System.assertEquals(400, response.statusCode, '## pass ##');
         

        Test.stopTest();
    }

    @istest
    static void testValidationPaiementBadRequestNullValue(){
        Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
     
        List<Asset> assets = WSO2VSPDataFactory_TST.buildAssetObject();
        for( Asset asset : assets){
            asset.AccountId = account.Id;
        }
        insert assets;
        Test.startTest();
        String jsonRequest = '{ "reference": ""}';
        RestRequest requete = new RestRequest();
        RestResponse response = new RestResponse();
        requete.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/api/v1/confirmationSignature';
        requete.httpMethod='POST';
        requete.requestBody = Blob.valueOf(jsonRequest);
        RestContext.request = requete;
        RestContext.response = response;
        ValidationPaiementParCarteBleue_SVC.validationPaiement();
        WebService_UTL.GeneriqueResponse reponse = (WebService_UTL.GeneriqueResponse) JSON.deserializeStrict(response.responseBody.toString(), WebService_UTL.GeneriqueResponse.class);
        System.debug('+++ reponse test '+reponse);
        System.assertEquals('KO', reponse.status, '## pass ##');
        System.assertEquals(400, response.statusCode, '## pass ##');
        Test.stopTest();
    }

    @istest
    static void testValidationPaiementBadRequestAssetNotFound(){
        Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
     
        List<Asset> assets = WSO2VSPDataFactory_TST.buildAssetObject();
        for( Asset asset : assets){
            asset.AccountId = account.Id;
        }
        insert assets;
        Test.startTest();
        String jsonRequest = '{ "reference": "22677852"}';
        RestRequest requete = new RestRequest();
        RestResponse response = new RestResponse();
        requete.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/api/v1/confirmationSignature';
        requete.httpMethod='POST';
        requete.requestBody = Blob.valueOf(jsonRequest);
        RestContext.request = requete;
        RestContext.response = response;
        ValidationPaiementParCarteBleue_SVC.validationPaiement();
        System.debug('+++ reponse test '+response.responseBody.toString() );
        WebService_UTL.GeneriqueResponse resp = (WebService_UTL.GeneriqueResponse) JSON.deserializeStrict(response.responseBody.toString(), WebService_UTL.GeneriqueResponse.class);
      
        System.assertEquals('KO', resp.status, '## pass ##');
        System.assertEquals(400, response.statusCode, '## pass ##');
        Test.stopTest();
    }
}