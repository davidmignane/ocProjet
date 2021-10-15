/**
 * @author Madicke BALDE
 * @date 29/03/2021
 * @description classe service pour la validation du paiement par Carte Bleue
 */
public with sharing class ValidationPaiementParCarteBleue_SVE {

    public static List<Asset> getAssetByNumeroContratOGI (Set<String> references){
        return [SELECT Id, Status, Ext_OGIContractID__c, dateConfirmationPaiementCB__c FROM Asset WHERE Ext_OGIContractID__c IN : references ];
    }
    
    public static List<Asset> gestionValidationPaiementCBleue(List<ValidationPaiementCBRequete> requetes){
       
        Map<String, ValidationPaiementCBRequete> mapValidationPaiementCBRequest = new Map<String, ValidationPaiementCBRequete>();
        List<Asset> assetToUpdate = new List<Asset>();
        for(ValidationPaiementCBRequete validationReq : requetes){
            mapValidationPaiementCBRequest.put(validationReq.reference, validationReq );
        }
        List<Asset> assets = getAssetByNumeroContratOGI(mapValidationPaiementCBRequest.keySet());
        if(assets.isEmpty()){
            System.debug('no Asset Found');
            throw new RestError_UTL.WebServiceException('Aucun paiement par Carte Bleue  confirmé','Not_Found',400);
        }
        else {
            for(Asset asset : assets){
                //asset.put('Status', WebService_UTL.getMapPicklistOptions('Asset', 'Status').get('03') );
                asset.put('Status','03');
                asset.put('dateConfirmationPaiementCB__c', System.now());
                assetToUpdate.add(asset);
            }
            update assetToUpdate;
        }
        return assetToUpdate;
    }


    public class ValidationPaiementCBRequete {
        public String reference;
    }
   

   public class ValidationPaiementParCarteBleueResponse extends WebService_UTL.GeneriqueResponse {
       public String message;
       public ValidationPaiementParCarteBleueResponse (String message){
          super();
          this.message = message;
       }
   }
}