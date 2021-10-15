/**
 * @description       : 
 * @author            : David Mignane Diop
 * @group             : 
 * @last modified on  : 10-13-2021
 * @last modified by  : David Mignane Diop
**/
@isTest
public with sharing class PaymentSinistres_SVE_TST {
    @isTest
    static void testPaymentSinistresKo(){

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
       
       vlocity_ins__ClaimLineItem__c claimLine = WSO2VSPDataFactory_TST.buildClaimLineObject();
       claimLine.vlocity_ins__ClaimId__c =  claims.Id;
       claimLine.vlocity_ins__ClaimAmount__c = 100;
       claimLine.vlocity_ins__Status__c = 'Paid';
       claimLine.vlocity_ins__Type__c = 'Loss';
       insert claimLine;

       List<Id> ids = new List<Id>();
        ids.add(claimLine.Id);

        String bodyResponseToken = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
                ' "token_type": "Bearer", "expires_in": 3600  }';

        String bodyResponseConfirmationSign = '{"code_retour" : "02","message_retour" : "Enregistrement effectué","date_debut_prelevement" : "2021-03-24","date_fin_prelevement" :" 2021-03-25","erreurs" : [ {"code_retour" :"02","libelle_court" : "test ","libelle_long"  : "long libbele","libelle_tech"  : "tech libelle","type": "type"}]}';
        Test.startTest();
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200,'OK', 'OK', bodyResponseToken, bodyResponseConfirmationSign);
        Test.setMock(HttpCalloutMock.class, mock);
        PaymentSinistres_SVE.createClaim(ids);
        Test.stopTest();
    }
}