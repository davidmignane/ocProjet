/**
 * @author Madicke BALDE
 * @description classe service pour la validation du contrat
 * @date 06/04/2021
 */
public with sharing class ConfirmationSignatureElectronique_SVE {
   

    public static List<Asset> getAssetByIdentifiantProcedureYousign (Set<String> idProcedure){
        return [SELECT Id, Tech_identifiantProcedureYousign__c , SignConf__c, dateConfirmationSignatureMandatYousign__c, identifiantFichierMandatSignYousign__c 
                       FROM Asset 
                       WHERE Tech_identifiantProcedureYousign__c =: idProcedure ];
    }
    

    public static List<Asset> manageSignature(List<ConfirmationSignatureWrapper> requeteDeConfirmations){
        Map<String, ConfirmationSignatureWrapper> mapConfirmationSignature = new Map<String, ConfirmationSignatureWrapper>();
        List<Asset> assetsToUpdate = new List<Asset>();
        for(ConfirmationSignatureWrapper cfmSignatureWrapper : requeteDeConfirmations){
            mapConfirmationSignature.put(cfmSignatureWrapper.identifiantProcedureYousign, cfmSignatureWrapper);
        }
        List<Asset> assets = getAssetByIdentifiantProcedureYousign(mapConfirmationSignature.keySet());
        if(assets == null || assets.size() == 0 ){
            System.debug('no Asset Found');
            throw new RestError_UTL.WebServiceException('Signature non confirmé','Not_Found',400);
        }
        else {
                for(Asset asset : assets){
                    asset.put('identifiantFichierMandatSignYousign__c', mapConfirmationSignature.get(asset.Tech_identifiantProcedureYousign__c).identifiantFichierMandatSigneYousign);
                    asset.put('dateConfirmationSignatureMandatYousign__c', System.now());
                    asset.put('signConf__c', true);
                    asset.put('Status', '03');
                    assetsToUpdate.add(asset);

                }
                update assetsToUpdate;
        }
        return assetsToUpdate;
    }
   
    public class  ConfirmationSignatureWrapper {
        public String identifiantProcedureYousign;
        public String identifiantFichierMandatSigneYousign;
    }

   

    public class ConfirmationSignatureReponse extends WebService_UTL.GeneriqueResponse {
        public String message ;
        public ConfirmationSignatureReponse (String message) {
            super();
            this.message = message;

        }
    }

    
}