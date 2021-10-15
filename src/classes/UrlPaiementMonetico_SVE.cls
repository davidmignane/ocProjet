/**
 * @File        :   UrlPaiementMonetico_SVE.cls
 * @description :   Methodes de service de gestion de recuperation de l'url de paiement
 * author       :   David Diop
 * @date        :   22/03/2021
 *
 */

public with sharing class UrlPaiementMonetico_SVE {
    /**
       * @description : Methodes de service de gestion de recuperation de l'url de paiement liée à l'Authentification
       * @param  UrlPaiementMonetico_WSI
       * @return  :   APIResponse_WSO
    */

    public static APIResponse_WSO getUrlPaiement(UrlPaiementMonetico_WSI request) {
        Map<String, Object> responseAuth = WSO2VSP_SVE.getToken();
        APIResponse_WSO response;

        if (!((Boolean) responseAuth.get('erreur'))) {
            System.debug('responseAuth' + (String) responseAuth.get('token'));
            response = getUrlRequest(request, (String) responseAuth.get('token'));
        }
        return response;
    }

    /***
 * @description Methodes de service de gestion de recuperation de l'url de paiement liée à l'Authentification
 * @param UrlPaiementMonetico_WSI,token
 * @return Object APIResponse_WSO
 * @exception aucune
 */
    public static APIResponse_WSO getUrlRequest(UrlPaiementMonetico_WSI request, String token) {
        System.debug('token' + token);
        System.debug('requestrequest' + request);
        String flux = 'GetUrlCB';
        Datetime dateHeureErreur = Datetime.now();
        String codeErreurFlux ;
        String messageErreur = '';
        String fluxJsonSoapEnvoye = JSON.serializePretty(request);
        String statusDuFlux;
        APIResponse_WSO response;
        Try {
            APIResponse_WSO apiResponseWSO = UrlPaiementMonetico_OUT.getUrlPaiement(request, 'POST', token);

            if (apiResponseWSO.status == 'OK') {
                UrlPaiementMonetico_WSO urlPaiementMoneticoOk = (UrlPaiementMonetico_WSO) apiResponseWSO;
                UrlPaiementMonetico_WSO urlPaiementMonetico = new UrlPaiementMonetico_WSO(urlPaiementMoneticoOk.url_paiement);
                urlPaiementMonetico.statusCode = urlPaiementMoneticoOk.statusCode;
                urlPaiementMonetico.status = urlPaiementMoneticoOk.status;
                response = apiResponseWSO;
                statusDuFlux = 'Ok';
                codeErreurFlux = String.valueOf(urlPaiementMonetico.statusCode);


            } else {
                UrlPaiementMonetico_KO_WSO urlPaiementMoneticoKo = (UrlPaiementMonetico_KO_WSO) apiResponseWSO;
                UrlPaiementMonetico_KO_WSO urlPaiementMonetico = new UrlPaiementMonetico_KO_WSO(urlPaiementMoneticoKo.code_message, urlPaiementMoneticoKo.libelle_court_erreur, urlPaiementMoneticoKo.libelle_long_erreur, urlPaiementMoneticoKo.libelle_technique, urlPaiementMoneticoKo.type_message);
                urlPaiementMonetico.statusCode = urlPaiementMoneticoKo.statusCode;
                urlPaiementMonetico.status = urlPaiementMoneticoKo.status;
                response = apiResponseWSO;
                statusDuFlux = 'Erreur';
                codeErreurFlux = String.valueOf(urlPaiementMonetico.statusCode);

            }
            String logId = GestionLog_UTL.creerLog(new GestionLog_UTL.GestionErreurDTO(flux, 'callApi', dateHeureErreur, ' ', codeErreurFlux, messageErreur, fluxJsonSoapEnvoye, statusDuFlux, ' '));
        } catch (Exception e) {
            System.debug('************ exception ' + e.getMessage());
        }
        return response;
    }
    public static APIResponse_WSO creerUrlPaiementMonetico(Map<String, String>inputMapString,Double montant) {
        APIResponse_WSO reponse;
        UrlPaiementMonetico_WSI.contexteCommandeDTO contexteCommande = new UrlPaiementMonetico_WSI.contexteCommandeDTO ();
        if(String.isNotBlank(inputMapString.get('adresseLigne2')) && String.isNotBlank(inputMapString.get('adresseLigne3')) ){
            UrlPaiementMonetico_WSI.addressFacturationTwoDTO addressFacturationDefault = new UrlPaiementMonetico_WSI.addressFacturationTwoDTO ();
            addressFacturationDefault.civilite = inputMapString.get('civilite');
            addressFacturationDefault.nom = inputMapString.get('nom');
            addressFacturationDefault.prenom = inputMapString.get('prenom');
            addressFacturationDefault.adresse_ligne_1 = inputMapString.get('adresseLigne1');
            addressFacturationDefault.adresse_ligne_2 = inputMapString.get('adresseLigne2');
            addressFacturationDefault.adresse_ligne_3 = inputMapString.get('adresseLigne3');
            addressFacturationDefault.ville = inputMapString.get('ville');
            addressFacturationDefault.code_postal = inputMapString.get('codePostal');
            addressFacturationDefault.pays = inputMapString.get('pays');
            addressFacturationDefault.email = inputMapString.get('email');
            contexteCommande.adresse_facturation = addressFacturationDefault;
        } else {
            UrlPaiementMonetico_WSI.addressFacturationDTO addressFacturation = new UrlPaiementMonetico_WSI.addressFacturationDTO ();
            addressFacturation.civilite = inputMapString.get('civilite');
            addressFacturation.nom = inputMapString.get('nom');
            addressFacturation.prenom = inputMapString.get('prenom');
            addressFacturation.adresse_ligne_1 = inputMapString.get('adresseLigne1');
            addressFacturation.ville = inputMapString.get('ville');
            addressFacturation.code_postal = inputMapString.get('codePostal');
            addressFacturation.pays = inputMapString.get('pays');
            addressFacturation.email = inputMapString.get('email');
            contexteCommande.adresse_facturation = addressFacturation;
        }
        String reference = inputMapString.get('reference');
        String texte_libre = inputMapString.get('texteLibre');
        String date_commande = inputMapString.get('dateCommande');
        UrlPaiementMonetico_WSI urlPaiementMonetico = new UrlPaiementMonetico_WSI(reference, texte_libre, date_commande, montant, contexteCommande);
        if (!contexteCommande.adresse_facturation.pays.isAllUpperCase()) {
            contexteCommande.adresse_facturation.pays = contexteCommande.adresse_facturation.pays.toUpperCase();
        }
        if(contexteCommande.adresse_facturation.pays == 'FRANCE'){
            contexteCommande.adresse_facturation.pays  = 'FR';
        }
        reponse = UrlPaiementMonetico_SVE.getUrlPaiement(urlPaiementMonetico);
        return reponse;
    }
}