/**
 * Created by David diop on 31.03.2021.
 */

global with sharing class ActivationContrat_ITF {
    @InvocableMethod(label='ActivationContrat' description='confirmation de contrat' category= 'Asset')
    public static void activerContrat(list<Id> assetIds) {
        
        activerContratfuture(assetIds);
        
        
    }
    
    @future(callout=true)
    public static void activerContratfuture(list<Id> assetIds) {
        List<Asset> assets = [
                select id, Name, Ext_OGIContractID__c,account.personContactID,Tech_identifiantProcedureYousign__c,
                        PaperSign__c,CreatedDate,dateConfirmationSignatureMandatYousign__c,RUM__c,identifiantFichierMandatSignYousign__c
                from Asset
                where id in :assetIds
        ];

        for (Asset asst : assets) {
            String identifiantProcedure = asst.Tech_identifiantProcedureYousign__c;
            ConfirmationContrat_WSI confirmationContratWSIDTO = new ConfirmationContrat_WSI();
            confirmationContratWSIDTO.action = 'ENR';
            if(identifiantProcedure != null && identifiantProcedure.contains('/')){
                confirmationContratWSIDTO.identifiant_procedure = identifiantProcedure.split('/').get(2);
            }
            confirmationContratWSIDTO.code_societe = '00';
            String dateOne = asst.CreatedDate.format('yyyy-MM-dd');
            confirmationContratWSIDTO.date_creation = asst.CreatedDate.format('yyyy-MM-dd');
            confirmationContratWSIDTO.date_signature = asst.dateConfirmationSignatureMandatYousign__c.format('yyyy-MM-dd');
            confirmationContratWSIDTO.reference_externe = 'GGXDT055';
            confirmationContratWSIDTO.clef_reference_externe = asst.RUM__c;
            ConfirmationContrat_WSI.Tokens token = new ConfirmationContrat_WSI.Tokens();
            List<ConfirmationContrat_WSI.Tokens>  tokensList = new List<ConfirmationContrat_WSI.Tokens>();
            tokensList.add(token);
            confirmationContratWSIDTO.tokens = tokensList;
            confirmationContratWSIDTO.nombre_tokens = 0;
            confirmationContratWSIDTO.nombre_fichiers = 1;
            ConfirmationContrat_WSI.FichiersWSI fichier = new ConfirmationContrat_WSI.FichiersWSI();
            String identifiantFichierMandat = asst.identifiantFichierMandatSignYousign__c;
            if(identifiantFichierMandat != null && identifiantFichierMandat.contains('/')) {
                fichier.reference_fichier = identifiantFichierMandat.split('/').get(2) ;
            }
                fichier.type_fichier = '02';
            System.debug('identifiantFichierMandat' +asst.identifiantFichierMandatSignYousign__c);
            System.debug('identifiantFichierMandat2' +fichier.reference_fichier);
            List<ConfirmationContrat_WSI.FichiersWSI>  fichiersList = new List<ConfirmationContrat_WSI.FichiersWSI>();
            fichiersList.add(fichier);
            confirmationContratWSIDTO.fichiers = fichiersList;
            ConfirmationContrat_SVE.confirmerContrat(confirmationContratWSIDTO);
        }
    }
}