/**
 * @File        :   ImpressionTicketCaisse_SVE.cls
 * @description :   Methodes de service de gestion d'impression de ticket caisse
 * author       :   David Diop
 * @date        :   26/03/2021
 *
 */

public with sharing class ImpressionTicketCaisse_SVE {
    /**
       * @description : Methodes de service de gestion de recuperation de l'url de paiement liée à l'Authentification
       * @param  UrlPaiementMonetico_WSI
       * @return  :   APIResponse_WSO
    */

    public static APIResponse_WSO imprimmerTicketCaisse(ImpressionTicketCaisse_WSI request) {
        Map<String, Object> responseAuth = WSO2VSP_SVE.getToken();
        APIResponse_WSO response;

        if (!((Boolean) responseAuth.get('erreur'))) {
            System.debug('responseAuth' + (String) responseAuth.get('token'));
            response = imprimmerTicketRequest(request, (String) responseAuth.get('token'));
        }
        return response;
    }

    /***
 * @description Methodes de service de gestion de recuperation de l'url de paiement liée à l'Authentification
 * @param UrlPaiementMonetico_WSI,token
 * @return Object APIResponse_WSO
 * @exception aucune
 */
    public static APIResponse_WSO imprimmerTicketRequest(ImpressionTicketCaisse_WSI request, String token) {
        System.debug('token' + token);
        System.debug('requestrequest' + request);
        String flux = 'FLUX Impression Ticket Caisse';
        Datetime dateHeureErreur = Datetime.now();
        String codeErreurFlux ;
        String messageErreur = '';
        String fluxJsonSoapEnvoye = JSON.serializePretty(request);
        String statusDuFlux;
        APIResponse_WSO response;
        Try {
            APIResponse_WSO apiResponseWSO = ImpressionTicketCaisse_OUT.imprimmerTcketCaisse(request, 'POST', token);

            if (apiResponseWSO.status == 'OK') {
                ImpressionTicketCaisse_WSO impressionTicketCaisseOk = (ImpressionTicketCaisse_WSO) apiResponseWSO;
                ImpressionTicketCaisse_WSO impressionTicketCaisse = new ImpressionTicketCaisse_WSO(impressionTicketCaisseOk.code_reponse,impressionTicketCaisseOk.message_reponse,impressionTicketCaisseOk.status_transaction);
                impressionTicketCaisse.statusCode = impressionTicketCaisseOk.statusCode;
                impressionTicketCaisse.status = impressionTicketCaisseOk.status;
                response = apiResponseWSO;
                statusDuFlux = 'Ok';
                codeErreurFlux = String.valueOf(impressionTicketCaisse.statusCode);


            } else {
                ImpressionTicketCaisse_KO_WSO ImpressionTicketCaisseKo = (ImpressionTicketCaisse_KO_WSO) apiResponseWSO;
                ImpressionTicketCaisse_KO_WSO ImpressionTicketCaisse = new ImpressionTicketCaisse_KO_WSO(ImpressionTicketCaisseKo.code_reponse, ImpressionTicketCaisseKo.message_reponse, ImpressionTicketCaisseKo.status_transaction);
                ImpressionTicketCaisse.statusCode = ImpressionTicketCaisseKo.statusCode;
                ImpressionTicketCaisse.status = ImpressionTicketCaisseKo.status;
                response = apiResponseWSO;
                statusDuFlux = 'Erreur';
                codeErreurFlux = String.valueOf(ImpressionTicketCaisse.statusCode);
                ImpressionTicketCaisse_KO_WSO.Fault faultTest = ImpressionTicketCaisse.fault;
                System.debug('apiResponseWSO'+ImpressionTicketCaisseKo.fault.description);
                if(ImpressionTicketCaisseKo.fault != null){
                    messageErreur = ' '+ ImpressionTicketCaisseKo.fault.description;
                }

            }
            String logId = GestionLog_UTL.creerLog(new GestionLog_UTL.GestionErreurDTO(flux, 'callApi', dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye, statusDuFlux, ' '));
        } catch (Exception e) {
            System.debug('************ exception ' + e.getMessage());
        }
        return response;
    }
    public static APIResponse_WSO creerTicketCaisse(String identifiantRequete,String  paysMagasin, String identifiantPartenaire, String identifiantTransactionPartenaire,String identifiantMagasin,String dateTransactionMagasin, String identifiantTransactionMagasin, String statusTransaction) {
        ImpressionTicketCaisse_WSI impressionTicketCaisseDTO = new ImpressionTicketCaisse_WSI(identifiantRequete,paysMagasin,identifiantPartenaire,identifiantTransactionPartenaire,identifiantMagasin,dateTransactionMagasin,identifiantTransactionMagasin,statusTransaction);
        APIResponse_WSO reponse = ImpressionTicketCaisse_SVE.imprimmerTicketCaisse(impressionTicketCaisseDTO);
        return reponse;
    }
}