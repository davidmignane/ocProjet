@istest
public class  ConfirmationSignatureElectronique_TST {

    @TestSetup
    static void makeData(){
        WSO2VSPDataFactory_TST.buildAccountObject();
    }
    
    @istest
    static void testConfirmationSignature(){
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

        String jsonString = '{"identifiantProcedureYousign": "/procedure/123456","IdentifiantFichierMandatSigneYousign" :"14255"}';
        RestRequest requete = new RestRequest();
        RestResponse response = new RestResponse();
        requete.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/api/v1/confirmationSignature';
        requete.httpMethod='POST';
        requete.requestBody = Blob.valueOf(jsonString);
        RestContext.request = requete;
        RestContext.response = response;
        ConfirmationSignatureElectronique_SVC.confirmationSignature();
        ConfirmationSignatureElectronique_SVE.ConfirmationSignatureReponse resp = (ConfirmationSignatureElectronique_SVE.ConfirmationSignatureReponse) JSON.deserializeStrict(response.responseBody.toString(), ConfirmationSignatureElectronique_SVE.ConfirmationSignatureReponse.class);
        System.assertEquals(200, response.statusCode, '### pass ###');
        System.assertEquals('OK', resp.status , '### pass ###');
        System.assertNotEquals(null, resp.message , '### pass ###');
        }
        Test.stopTest();
    }

    @istest
    static void testConfirmationSignatureNotAssetFound(){
        Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
     
        List<Asset> assets = WSO2VSPDataFactory_TST.buildAssetObject();
        for( Asset asset : assets){
            asset.AccountId = account.Id;
        }
        insert assets;
        Test.startTest();
        String jsonString = '{"identifiantProcedureYousign": "/procedure/12346","IdentifiantFichierMandatSigneYousign" :"14255"}';
        RestRequest requete = new RestRequest();
        RestResponse response = new RestResponse();
        requete.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/api/v1/confirmationSignature';
        requete.httpMethod='POST';
        requete.requestBody = Blob.valueOf(jsonString);
        RestContext.request = requete;
        RestContext.response = response;
        ConfirmationSignatureElectronique_SVC.confirmationSignature();
        System.debug('response JSON '+ response.responseBody.toString());
        WebService_UTL.GeneriqueResponse resp = (WebService_UTL.GeneriqueResponse) JSON.deserialize(response.responseBody.toString(), WebService_UTL.GeneriqueResponse.class);
        System.debug('response deser '+ resp);
        System.assertEquals(400, response.statusCode, '### pass ###');
        System.assertEquals('KO', resp.status , '### pass ###');
        System.assertNotEquals(null, resp.erreur , '### pass ###');
        Test.stopTest();
    }
    
    @istest
    static void testConfirmationSignatureErreurRequete(){
        Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
     
        List<Asset> assets = WSO2VSPDataFactory_TST.buildAssetObject();
        for( Asset asset : assets){
            asset.AccountId = account.Id;
        }
        insert assets;
        Test.startTest();
        String jsonString = '{"identifiantProcedureYousig": "/procedure/12346","IdentifiantFichierMandatSigneYousig" :"14255"}';
        RestRequest requete = new RestRequest();
        RestResponse response = new RestResponse();
        requete.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/api/v1/confirmationSignature';
        requete.httpMethod='POST';
        requete.requestBody = Blob.valueOf(jsonString);
        RestContext.request = requete;
        RestContext.response = response;
        ConfirmationSignatureElectronique_SVC.confirmationSignature();
        System.debug('response JSON '+ response.responseBody.toString());
        WebService_UTL.GeneriqueResponse resp = (WebService_UTL.GeneriqueResponse) JSON.deserialize(response.responseBody.toString(), WebService_UTL.GeneriqueResponse.class);
        System.debug('response deser '+ resp);
        System.assertEquals(400, response.statusCode, '### pass ###');
        System.assertEquals('KO', resp.status , '### pass ###');
        System.assertNotEquals(null, resp.erreur , '### pass ###');
        Test.stopTest();
    }

    @istest
    static void testConfirmationSignatureErreurValidation(){
        Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
     
        List<Asset> assets = WSO2VSPDataFactory_TST.buildAssetObject();
        for( Asset asset : assets){
            asset.AccountId = account.Id;
        }
        insert assets;
        Test.startTest();
        String jsonString = '{"identifiantProcedureYousign": "","IdentifiantFichierMandatSigneYousign" :""}';
        RestRequest requete = new RestRequest();
        RestResponse response = new RestResponse();
        requete.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/api/v1/confirmationSignature';
        requete.httpMethod='POST';
        requete.requestBody = Blob.valueOf(jsonString);
        RestContext.request = requete;
        RestContext.response = response;
        ConfirmationSignatureElectronique_SVC.confirmationSignature();
        System.debug('response JSON '+ response.responseBody.toString());
        WebService_UTL.GeneriqueResponse resp = (WebService_UTL.GeneriqueResponse) JSON.deserialize(response.responseBody.toString(), WebService_UTL.GeneriqueResponse.class);
        System.debug('response deser '+ resp);
        System.assertEquals(400, response.statusCode, '### pass ###');
        System.assertEquals('KO', resp.status , '### pass ###');
        System.assertNotEquals(null, resp.erreur , '### pass ###');
        Test.stopTest();
    }
}