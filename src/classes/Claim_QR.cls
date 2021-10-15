/**
 * @description       : 
 * @author            : David Mignane Diop
 * @group             : 
 * @last modified on  : 10-04-2021
 * @last modified by  : David Mignane Diop
**/
public with sharing class Claim_QR {
    public List<vlocity_ins__InsuranceClaim__c> getClaimRecord(List<Id> claimIds){
        List<vlocity_ins__InsuranceClaim__c> claimList = [ SELECT  id,vlocity_ins__Description__c,ClaimDeviceFamily__c,
            vlocity_ins__PrimaryPolicyAssetId__r.ProductCategory__c , vlocity_ins__PrimaryPolicyAssetId__r.Tech_ProductUnivers__c,
            ClaimDeviceBrand__c,OtherClaimDeviceBrand__c,Tech_AcceptedRemainingAmount__c,
            ClaimDeviceModel__c,ClaimDeviceCode__c,	ClaimDeviceInvoiceDate__c,ClaimVoucherAmount__c,ClaimImei__c,ClaimDeviceInvoiceNumber__c,
            vlocity_ins__PrimaryPolicyAssetId__r.Name,vlocity_ins__PrimaryPolicyAssetId__r.ProductName__c,vlocity_ins__PrimaryPolicyAssetId__r.Account.Name,
            vlocity_ins__PrimaryPolicyAssetId__r.Account.FirstName,vlocity_ins__PrimaryPolicyAssetId__r.Account.LastName,vlocity_ins__PrimaryPolicyAssetId__r.Account.PersonMobilePhone,
            vlocity_ins__PrimaryPolicyAssetId__r.Account.PersonEmail,vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingPostalCode,vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingCountry,
            vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingStreet,vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingCity
            FROM vlocity_ins__InsuranceClaim__c
            WHERE Id in: claimIds
        ];
        if (claimList.isEmpty()) {
            return null;
        }
        return claimList;
    }

    public vlocity_ins__ClaimCoverage__c getClaimCoverage(String claimId){
        List<vlocity_ins__ClaimCoverage__c> claimCoverage = 
        [
            SELECT Id,vlocity_ins__AssetCoverageId__r.vlocity_ins__Product2Id__r.CarrierContract__r.PolicyConvetionNumber__c
             from vlocity_ins__ClaimCoverage__c 
             WHERE vlocity_ins__ClaimId__c   =: claimId 
             LIMIT 1
        ];
        if (claimCoverage.isEmpty()) {
            return null;
        }
        return claimCoverage[0];
    }
}