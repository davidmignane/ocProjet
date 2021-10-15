/**
 * @File        :   ContratOGI_SVE.cls
 * @description : Methodes de service de gestion de l'envoie de devis
 * author       :   David Diop
 * @date        :   03/03/2021
 *
 */

public with sharing class ContratOGI_SVE {
    /**
       * @description : Methodes de service de gestion de l'envoie de devis liée à l'Authentification
       * @param  ContratOGI_WSI
       * @return  :   APIResponse_WSO
    */

    public static APIResponse_WSO createDevis(ContratOGI_WSI request) {
        Map<String, Object> responseAuth = WSO2VSP_SVE.getToken();
        APIResponse_WSO response;
	
        if (!((Boolean) responseAuth.get('erreur'))) {
            System.debug('responseAuth' + (String) responseAuth.get('token'));
            response = creerDevisRequest(request, (String) responseAuth.get('token'));
        }
        return response;
    }
    /***
     * @description Methodes de service de gestion de l'envoie de devis liée à l'Authentification
     * @param ContratOGI_WSI,token
     * @return Object APIResponse_WSO
     * @exception aucune
     */
    public static APIResponse_WSO creerDevisRequest(ContratOGI_WSI request, String token) {
        System.debug('token' + token);
        System.debug('requestrequest' + request);
        String flux = 'Creation Client Contrat OGI ';
        Datetime dateHeureErreur = Datetime.now();
        String codeErreurFlux ;
        String messageErreur = '';
        String fluxJsonSoapEnvoye = JSON.serializePretty(request);
        String statusDuFlux;
        APIResponse_WSO response;
        Try {
            APIResponse_WSO apiResponseWSO = ContratOGI_OUT.getContratOGI(request, 'POST', token);
            ContratOGI_OK_WSO contractOGIOkResponse = (ContratOGI_OK_WSO) apiResponseWSO;
            System.debug('contractOGIOkResponse'+contractOGIOkResponse);
            if(String.isNotBlank(contractOGIOkResponse.num_quittance) && String.isNotBlank(contractOGIOkResponse.num_client) &&
                    String.isNotBlank(contractOGIOkResponse.num_contrat)){
                ContratOGI_WSO contratOGI = new ContratOGI_WSO(contractOGIOkResponse.num_client, contractOGIOkResponse.num_contrat, contractOGIOkResponse.num_quittance, contractOGIOkResponse.rum);
                contratOGI.statusCode = contractOGIOkResponse.statusCode;
                contratOGI.status = contractOGIOkResponse.status;
                response = apiResponseWSO;
                statusDuFlux = 'Ok';
                codeErreurFlux = String.valueOf(contractOGIOkResponse.statusCode);
                messageErreur = 'contrat dans OGI crée avec succes  ' ;
            } else {
                ContratOGI_KO_WSO contratOGI = new ContratOGI_KO_WSO(contractOGIOkResponse.code_message, contractOGIOkResponse.libelle_court_erreur, contractOGIOkResponse.libelle_long_erreur, contractOGIOkResponse.libelle_technique, contractOGIOkResponse.type_message);
                contratOGI.statusCode = contractOGIOkResponse.statusCode;
                contratOGI.status = contractOGIOkResponse.status;
                response = apiResponseWSO;
                statusDuFlux = 'Erreur';
                codeErreurFlux = String.valueOf(contractOGIOkResponse.statusCode);

                messageErreur = contractOGIOkResponse.libelle_court_erreur;
            }
            /*if (apiResponseWSO.status == 'OK') {
                ContratOGI_WSO contractOGIOk = (ContratOGI_WSO) apiResponseWSO;
                System.debug('contractOGIOk'+contractOGIOk);
                ContratOGI_WSO contratOGI = new ContratOGI_WSO(contractOGIOk.num_client, contractOGIOk.num_contrat, contractOGIOk.num_quittance, contractOGIOk.rum);
                contratOGI.statusCode = contractOGIOk.statusCode;
                contratOGI.status = contractOGIOk.status;
                response = apiResponseWSO;
                statusDuFlux = 'Ok';
                codeErreurFlux = String.valueOf(contractOGIOk.statusCode);
                if (contractOGIOk.fault != null) {
                    messageErreur = contractOGIOk.fault.description ;
                }

            } else {
                ContratOGI_KO_WSO contractOGIKo = (ContratOGI_KO_WSO) apiResponseWSO;
                System.debug('contractOGIKo'+contractOGIKo);
                ContratOGI_KO_WSO contratOGI = new ContratOGI_KO_WSO(contractOGIKo.code_message, contractOGIKo.libelle_court_erreur, contractOGIKo.libelle_long_erreur, contractOGIKo.libelle_technique, contractOGIKo.type_message);
                contratOGI.statusCode = contractOGIKo.statusCode;
                contratOGI.status = contractOGIKo.status;
                response = apiResponseWSO;
                statusDuFlux = 'Erreur';
                codeErreurFlux = String.valueOf(contractOGIKo.statusCode);
                messageErreur = contractOGIKo.libelle_long_erreur;
            }*/
            String logId = GestionLog_UTL.creerLog(new GestionLog_UTL.GestionErreurDTO(flux, 'callApi', dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye, statusDuFlux, ' '));
        } catch (Exception e) {
            System.debug('************ exception ' + e.getMessage());
        }
        return response;
    }
}