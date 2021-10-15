/**
 * Created by DAVID DIOP on 21.06.2021.
 */

public with sharing class ImpressionTicket_ITF {
    @InvocableMethod(label='ImprissionTicket' description='impression de ticket' category= 'Asset')
    public static void imprimerTicket(list<Id> assetIds) {

        imprimerTicketFuture(assetIds);
    }
    @future(callout=true)
    public static void imprimerTicketFuture(list<Id> assetIds) {
        List<Asset> assets = [
                select id, Name, StoreCodeNumber__c,ExtMerchantTransactionId__c,CreatedDate
                from Asset
                where id in :assetIds
        ];

        for (Asset asst : assets) {
            ImpressionTicketCaisse_WSI impressionTicket = new ImpressionTicketCaisse_WSI (asst.Id,'FR','ELECDEPOT','','EL'+asst.StoreCodeNumber__c,(String) asst.CreatedDate.format('yyyy-MM-dd'),asst.ExtMerchantTransactionId__c,'OK');
            System.debug('test ImpressionTicketCaisse_WSI');
            System.debug('test ImpressionTicketCaisse_WSI'+asst.CreatedDate.format('yyyy-MM-dd'));
            ImpressionTicketCaisse_SVE.imprimmerTicketCaisse(impressionTicket);
        }
    }
}