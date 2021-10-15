/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-30-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class CertificatAdhesionPDF_CTL {
    
    private final Asset asset;
    
    public CertificatAdhesionPDF_CTL() {
        
        System.debug('asset1 ' + ApexPages.currentPage().getParameters().get('id') );
        asset = [SELECT Id, Name, Account.LastName,Account.FirstName, Account.BillingStreet,Account.BillingPostalCode,
                 Account.BillingCity,Account.BillingCountry,Account.PersonEmail,Account.PersonMobilePhone,Product2.Name,SubscribedFormula__c,ProductCategory__c,
                 vlocity_ins__EffectiveDate__c,EliminationPeriod__c,vlocity_ins__MonthlyPremium__c,Ext_OGIContractID__c,vlocity_ins__TotalAmount__c,
                 vlocity_ins__TotalTaxAmount__c,vlocity_ins__TotalAmountForTerm__c,Ext_DistributorContractID__c,PaymentMethod__c,vlocity_ins__PolicyPaidToDate__c,TechPaymentDateInfo__c,
                 Marque__c,Modele__c,IMEI__c,PrixDeVenteTTC__c
                 FROM Asset WHERE Id = :ApexPages.currentPage().getParameters().get('id')];      
        System.debug('asset ' + asset );
    }
    
    public Asset getAsset() {
        return asset;
    }

}