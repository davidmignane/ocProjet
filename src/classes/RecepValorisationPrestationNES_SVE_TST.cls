/**
 * @description       : 
 * @author            : David Mignane Diop
 * @group             : 
 * @last modified on  : 10-01-2021
 * @last modified by  : David Mignane Diop
**/
@istest
public with sharing class RecepValorisationPrestationNES_SVE_TST {
    @istest
    static void testValoriserPrestationNES(){
        Test.startTest();
        String bodyResponseToken = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
        ' "token_type": "Bearer", "expires_in": 3600  }';

        String bodyResponseConfirmationSign = '{"code_retour" : "02","message_retour" : "Enregistrement effectué","date_debut_prelevement" : "2021-03-24","date_fin_prelevement" :" 2021-03-25","erreurs" : [ {"code_retour" :"02","libelle_court" : "test ","libelle_long"  : "long libbele","libelle_tech"  : "tech libelle","type": "type"}]}';
     
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200,'OK', 'OK', bodyResponseToken, bodyResponseConfirmationSign);
        Test.setMock(HttpCalloutMock.class, mock);

        WSO2VSPDataFactory_TST.buildAccountObject();
        Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
        vlocity_ins__InsuranceClaim__c claims = WSO2VSPDataFactory_TST.buildClaimObject();

       List<Asset>  asst =  WSO2VSPDataFactory_TST.buildAssetObject();
       Asset ast = asst[0];
       ast.AccountId = account.Id;
       insert ast;
       
       claims.vlocity_ins__PrimaryPolicyAssetId__c = ast.Id;

       insert claims;
       List<Id> claimIds = new List<Id>();
       claimIds.add(claims.Id);

       vlocity_ins__ClaimCoverage__c claimCoverage = WSO2VSPDataFactory_TST.buildClaimCovarageObject();
       claimCoverage.vlocity_ins__ClaimId__c = claims.Id;
       insert claimCoverage;
        String jsonRequest = '{"ClaimId": "0311921211XHI89","Ext_RepairClaimLineItem" : "13243FLGK4L53","ClaimLineItemDetails" : "01","ClaimLineItemClaimant" : "02","AdjustedAmount" :"450","Ext_ClaimId" : "CLM8718781","ExtBillingDate":"2021-10-10"}';
        RestRequest requete = new RestRequest();
        RestResponse response = new RestResponse();
        requete.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/api/v1/ClaimLineItemRepairValue';
        requete.httpMethod='POST';
        requete.requestBody = Blob.valueOf(jsonRequest);
        RestContext.request = requete;
        RestContext.response = response;
        //RecepValorisationPrestationNES_SVC recep = new RecepValorisationPrestationNES_SVC();
        //RecepValorisationPrestationNES_SVC.valoriserPrestationNES();
        //ValidationPaiementParCarteBleue_SVE.ValidationPaiementParCarteBleueResponse reponse = (ValidationPaiementParCarteBleue_SVE.ValidationPaiementParCarteBleueResponse) JSON.deserializeStrict(response.responseBody.toString(), ValidationPaiementParCarteBleue_SVE.ValidationPaiementParCarteBleueResponse.class);
        //System.debug('+++ reponse test '+reponse);
        //System.assertEquals('OK', reponse.status, '## pass ##');
        //System.assertEquals(200, response.statusCode, '## pass ##');

        Test.stopTest();
    }
}