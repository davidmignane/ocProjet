/**
 * @description       : 
 * @author            : David Mignane Diop
 * @group             : 
 * @last modified on  : 10-12-2021
 * @last modified by  : David Mignane Diop
**/
global with sharing class PaymentSinistres_SVE {
    /**
     * @description
     * @param  : list<Id> claimLineItemIds
     * @return 
     */
    @InvocableMethod(label='paymentSinistre' description='payement sinistre ' category='vlocity_ins__ClaimLineItem__c')
    public static void createClaim(list<Id> claimLineItemIds){
        payerSinistre(claimLineItemIds);
    }
    //@future(callout=true)
    public Static void payerSinistre (list<Id> claimLineItemIds){
        Map<String, Object> outputObj = new Map<String, Object> ();
        Map<String, Object> inputObj = new Map<String, Object> ();
        Map<String, Object> ipOptions = new Map<String, Object> ();
        System.debug('tester si le flow a été lancer');
        for(Id claimLineItemId:claimLineItemIds){
            inputObj.put('claimLineItemId',claimLineItemId);
        try 
          {
            String procedureName = 'cliamLine_sinistre';
            outputObj = (Map<String,Object>) vlocity_ins.IntegrationProcedureService.runIntegrationService(procedureName,inputObj,ipOptions);
            System.debug('test output reponse apres l appel du service vlocity'+outputObj);
          } 
        catch (Exception e)
        {
            System.debug('++++++++ eCause '+ e.getCause());
             
        }
    }
        

    }
}