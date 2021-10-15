/**
 * @description       : 
 * @author            : David Mignane Diop
 * @group             : 
 * @last modified on  : 10-11-2021
 * @last modified by  : David Mignane Diop
**/
public with sharing class RecepValorisationPrestationNES_SVE {
    public class  PrestationNESWrapper {
        public ClaimLineItemDTO[] ClaimLineItem;
    }
    public class ClaimLineItemDTO{
        public String ClaimId;
        public String Ext_RepairClaimLineItem;
        public String ClaimLineItemDetails;
        public String ClaimLineItemClaimant;
        public Decimal AdjustedAmount;
        public String Ext_ClaimId;
        public String ExtBillingDate;
    }
    
    public class reponseOkWrapper{
        public responseOkDTO[] responseOk;
    }

   

    public class responseOkDTO{
        public String status;
        public String erreur;
        public String message;
        public String Ext_ClaimId;
        public String Ext_RepairClaimLineItem;
    }

    public class reponseKoWrapper{
        public responseKoDTO[] responseKo;
    }
    public class responseKoDTO{
        public String status;
        public erreurDTO erreur;
        public String Ext_ClaimId;
        public String Ext_RepairClaimLineItem;
    }

    public class erreurDTO{
        public String erreur_message;
        public String erreur_description;
    }

    public static String managePrestationNES(RecepValorisationPrestationNES_SVE.PrestationNESWrapper ClaimLineItem  ){
        List<vlocity_ins__ClaimLineItem__c> claimLineItemRecordList = new List<vlocity_ins__ClaimLineItem__c>();
        List<RecepValorisationPrestationNES_OK_WSO.responseDTO> responseDTOList = new List<RecepValorisationPrestationNES_OK_WSO.responseDTO>();
        String responseDeRetour;
        String flux = 'Reception et valorisation prestation NES';
        Datetime dateHeureErreur = Datetime.now();
        String codeErreurFlux ;
        String messageErreur = '';
        String fluxJsonSoapEnvoye = JSON.serializePretty(ClaimLineItem);
        String statusDuFlux;

            for(RecepValorisationPrestationNES_SVE.ClaimLineItemDTO  claim : ClaimLineItem.ClaimLineItem){
                Claim_QR claimQuery =  new Claim_QR();
                vlocity_ins__ClaimCoverage__c claimCoverage =  claimQuery.getClaimCoverage(claim.ClaimId);
                System.debug('claimCoverage'+claimCoverage);
                if(claimCoverage != null){
                    Map<String, Object> inputObj = new Map<String, Object> ();
                    inputObj.put('claimId',claim.ClaimId);
                    inputObj.put('claimCoverageId',claimCoverage.Id);
                    inputObj.put('type','Loss');
                    inputObj.put('claimLineItemDetails',claim.ClaimLineItemDetails);
                    inputObj.put('adjustedAmount',claim.AdjustedAmount);
                    inputObj.put('ext_ClaimId',claim.Ext_ClaimId);
                    inputObj.put('claimLineItemClaimant',claim.ClaimLineItemClaimant);
                    inputObj.put('extBillingDate',claim.ExtBillingDate);
                    inputObj.put('ext_RepairClaimLineItem',claim.Ext_RepairClaimLineItem);
                    String str = JSON.serialize(inputObj);
                    Map<String, Object> outputObj = new Map<String, Object> ();
                    Map<String, Object> ipOptions = new Map<String, Object> ();
                    String procedureName = 'claim_valorisationPrestationNES';
                    System.debug('test'+inputObj);
                    outputObj = (Map<String,Object>) vlocity_ins.IntegrationProcedureService.runIntegrationService(procedureName,inputObj,ipOptions);
                    System.debug('test'+outputObj);
                    if(outputObj.get('error') === 'OK'){
                        System.debug('ok'+outputObj);
                        RecepValorisationPrestationNES_OK_WSO.responseDTO  reponseOk = new RecepValorisationPrestationNES_OK_WSO.responseDTO();
                        reponseOk = RecepValorisationPrestationNES_OK_WSO.createResponse(outputObj.get('error').toString(),'Ligne de sinistre récupéré avec succès',null,null,claim.Ext_ClaimId,claim.Ext_RepairClaimLineItem);
                        responseDTOList.add(reponseOk);
                        statusDuFlux = 'OK';
                        codeErreurFlux = 'INVOKE-200';
                        messageErreur = 'Ligne de sinistre récupéré avec succès' ;
                        GestionLog_UTL.creerLogwithResponse(new GestionLog_UTL.GestionErreurDTOreponse(flux, 'callIN', dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye, statusDuFlux, ' ',JSON.serialize(reponseOk)));

                    }
                    if(outputObj.get('success') == false){ 
                        if(((Map<String, Object>)outputObj.get('result')).get('error') != 'OK'){
                            RecepValorisationPrestationNES_OK_WSO.responseDTO  reponseKo = new RecepValorisationPrestationNES_OK_WSO.responseDTO();
                            reponseKo = RecepValorisationPrestationNES_OK_WSO.createResponse('KO',null,((Map<String, Object>)outputObj.get('result')).get('errorCode').toString(),((Map<String, Object>)outputObj.get('result')).get('error').toString(),claim.Ext_ClaimId,claim.Ext_RepairClaimLineItem);
                            responseDTOList.add(reponseKo);
                            statusDuFlux = 'KO';
                            codeErreurFlux = 'INVOKE-500';
                            messageErreur = ((Map<String, Object>)outputObj.get('result')).get('errorCode').toString() ;
                            GestionLog_UTL.creerLogwithResponse(new GestionLog_UTL.GestionErreurDTOreponse(flux, 'callIN', dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye, statusDuFlux, ' ',JSON.serialize(reponseKo)));

                        }
                    }
                } else {
                    RecepValorisationPrestationNES_OK_WSO.responseDTO  reponseKo = new RecepValorisationPrestationNES_OK_WSO.responseDTO();
                    reponseKo = RecepValorisationPrestationNES_OK_WSO.createResponse('KO',null,'Not_Found','Sinistre non trouvé ou claim coverage non trouvé',claim.Ext_ClaimId,claim.Ext_RepairClaimLineItem);
                    responseDTOList.add(reponseKo);
                    statusDuFlux = 'KO';
                    codeErreurFlux = 'INVOKE-500';
                    messageErreur = 'Sinistre non trouvé ou claim coverage non trouvé' ;
                    GestionLog_UTL.creerLogwithResponse(new GestionLog_UTL.GestionErreurDTOreponse(flux, 'callIN', dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye, statusDuFlux, ' ','Sinistre non trouvé ou claim coverage non trouvé'));

                    }
                }
                System.debug('retour a la fin '+JSON.serialize(responseDTOList));
                

        return JSON.serialize(responseDTOList);
    }
}