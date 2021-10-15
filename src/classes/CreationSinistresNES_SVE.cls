/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-11-2021
 * @last modified by  : David Mignane Diop
**/
global with sharing class CreationSinistresNES_SVE {

    /**
     * @description
     * @param  : 
     * @return 
     */
    @InvocableMethod(label='creationSinistre' description='creation sinistre avec Nex' category='vlocity_ins__InsuranceClaim__c')
    public static void createClaim(list<Id> claimIds){
        creerSinistre(claimIds);
    }

    @future(callout=true)
    public static void creerSinistre (list<Id> claimIds){

        Claim_QR claimQuery =  new Claim_QR();
        List<vlocity_ins__InsuranceClaim__c> claimRecord =  claimQuery.getClaimRecord(claimIds);
        CreationSinistresNES_WSI sinistre = new CreationSinistresNES_WSI();
        CreationSinistresNES_WSI sinistreDTO = sinistre.createSinistre(claimRecord[0]);
        //creerSinistre(sinistreDTO);
        Map<String, Object> responseAuth = WSO2VSP_SVE.getToken();
        APIResponse_WSO response;

        if (!((Boolean) responseAuth.get('erreur'))) {
            System.debug('responseAuth' + (String) responseAuth.get('token'));
            response = creerSinistreRequest(sinistreDTO, (String) responseAuth.get('token'));
        }
        //return response;
    }

    public static APIResponse_WSO creerSinistreRequest( CreationSinistresNES_WSI request, String token) {
        APIResponse_WSO response;
        String flux = 'Creation Sinistre NES ';
        Datetime dateHeureErreur = Datetime.now();
        String codeErreurFlux ;
        String messageErreur = '';
        String fluxJsonSoapEnvoye = JSON.serializePretty(request);
        String statusDuFlux;
        String reponseJson;
        Try {
            APIResponse_WSO apiResponseWSO = CreationSinistreNex_OUT.getSinistre(request, 'POST', token);
            if (apiResponseWSO.status == 'OK') {
                CreationSinistreNEX_WSO creationSinistreOK = (CreationSinistreNEX_WSO) apiResponseWSO;
                CreationSinistreNEX_WSO sinistre = new CreationSinistreNEX_WSO(creationSinistreOK.id_partenaire,creationSinistreOK.id_sinistre_partenaire);
                response = apiResponseWSO;
                System.debug('CreationSinistreNEXOk'+apiResponseWSO);
                statusDuFlux = 'Ok';
                codeErreurFlux = String.valueOf(apiResponseWSO.statusCode);
                messageErreur = 'Sinistre  crée avec success  ' ;
                reponseJson = JSON.serialize(creationSinistreOK);

                
            } else {
                System.debug('CreationSinistreNEX'+apiResponseWSO);
                //System.debug('CreationSinistreNEX'+apiResponseWSO.status);
                CreationSinitresNEX_KO_WSO creationSinistreKO = (CreationSinitresNEX_KO_WSO) apiResponseWSO;
                CreationSinitresNEX_KO_WSO sinistreKO = new CreationSinitresNEX_KO_WSO(creationSinistreKO.code_message,creationSinistreKO.libelle_court,creationSinistreKO.libelle_long,creationSinistreKO.libelle_technique,creationSinistreKO.type_message);

                statusDuFlux = 'Erreur';
                codeErreurFlux = String.valueOf(apiResponseWSO.statusCode);
                messageErreur = sinistreKO.libelle_court;
                reponseJson = JSON.serialize(creationSinistreKO);
            }
            String logId = GestionLog_UTL.creerLogwithResponse(new GestionLog_UTL.GestionErreurDTOreponse(flux, 'callApi', dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye, statusDuFlux, ' ',reponseJson));
        } catch (Exception e) {

        }
        return response;
    }

}