Global class CallApexFromOmniScript_UTL implements vlocity_ins.VlocityOpenInterface2 {

    private static final String CREER_DEVIS = 'CreerDevis';
    private static final String SIGN_ELEC = 'SignatureElectronique';
    private static final String ACTIVATION_CONTRAT = 'ActivationContrat';//todo
    private static final String GETURL = 'GetUrl';
    private static final String IMPRESSIONTICKET = 'ImpressionTicket';


    global Object invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> options) {
        try {
            if (methodName == CREER_DEVIS) {
                String JsonString = JSON.serialize(inputMap);
                System.debug('JsonString');
                System.debug(JsonString);
                ContratOGI_WSI request = (ContratOGI_WSI) JSON.deserialize(JsonString, ContratOGI_WSI.class);
                APIResponse_WSO response = (APIResponse_WSO) ContratOGI_SVE.createDevis(request);
                ContratOGI_OK_WSO contractOGIOkResponse = (ContratOGI_OK_WSO) response;
                Map<String, Object> outputMapSF = new Map<String, Object>();
                if(String.isNotBlank(contractOGIOkResponse.num_quittance) && String.isNotBlank(contractOGIOkResponse.num_client) &&
                        String.isNotBlank(contractOGIOkResponse.num_contrat)){
                    outputMapSF.put('num_client', contractOGIOkResponse.num_client);
                    outputMapSF.put('num_contrat', contractOGIOkResponse.num_contrat);
                    outputMapSF.put('num_quittance', contractOGIOkResponse.num_quittance);
                    outputMapSF.put('rum', contractOGIOkResponse.rum);
                } else {
                    outputMapSF.put('code_message', contractOGIOkResponse.code_message);
                    outputMapSF.put('libelle_court_erreur', contractOGIOkResponse.libelle_court_erreur);
                    outputMapSF.put('libelle_long_erreur', contractOGIOkResponse.libelle_long_erreur);
                    outputMapSF.put('libelle_technique', contractOGIOkResponse.libelle_technique);
                    outputMapSF.put('type_message', contractOGIOkResponse.type_message);
                }
                outputMap.put('response', outputMapSF);

            }

            else if (methodName == SIGN_ELEC) {
                System.debug('inputMap');
                System.debug(inputMap);
                /*String nom = (String) inputMap.get('nom');
                String prenom = (String) inputMap.get('prenom');*/
                String accountId = (String) inputMap.get('accountId');
                String iban = (String) inputMap.get('iban');
                String email = (String) inputMap.get('email');
                String numContratOgi = (String) inputMap.get('num contrat ogi');
                String telephone = (String) inputMap.get('telephone');
                Integer rum = Integer.valueOf(inputMap.get('rum'));
                SignatureElectronique_WSO reponse = (SignatureElectronique_WSO) SignatureElectronique_SVE.creerProcedureSignatureElectronique(accountId, iban, email, numContratOgi, telephone, rum);
                System.debug('JsonResp');
                System.debug(JSON.serialize(reponse));

                Map<String, object> outputMapSF = new Map<String, object>();
                if (reponse.status == 'Ok') {
                    outputMapSF.put('status_signature', reponse.status_signature);
                    outputMapSF.put('identifiant_procedure', reponse.identifiant_procedure);
                    outputMapSF.put('url_signature', reponse.url_signature);
                } else {
                    List<SignatureElectronique_WSO.ErreurDTO> reponseKo = (List<SignatureElectronique_WSO.ErreurDTO>) reponse.erreurs;
                    outputMapSF.put('identifiant_erreur', reponseKo[0].identifiant_erreur);
                    outputMapSF.put('libelle_erreur', reponseKo[0].libelle_erreur);
                    outputMapSF.put('erreur_date_time', reponseKo[0].erreur_date_time);
                }
                outputMap.put('response', outputMapSF);

            } else if (methodName == ACTIVATION_CONTRAT) {

            }

            else if (methodName == GETURL) {
                Double montant = (Double) inputMap.get('montant');
                Map<String, String> inputMapString = new Map<String, String>();
                inputMapString.put('reference', (String) inputMap.get('reference'));
                inputMapString.put('texteLibre', (String) inputMap.get('teste_libre'));
                inputMapString.put('dateCommande', (String) inputMap.get('date_commande'));
                inputMapString.put('civilite', (String) inputMap.get('civilite'));
                inputMapString.put('nom', (String) inputMap.get('nom'));
                inputMapString.put('prenom', (String) inputMap.get('prenom'));
                inputMapString.put('adresseLigne1', (String) inputMap.get('adresse_ligne_1'));
                inputMapString.put('adresseLigne2', (String) inputMap.get('adresse_ligne_2'));
                inputMapString.put('adresseLigne3', (String) inputMap.get('adresse_ligne_3'));
                inputMapString.put('ville', (String) inputMap.get('ville'));
                inputMapString.put('codePostal', (String) inputMap.get('code_postal'));
                inputMapString.put('pays', (String) inputMap.get('pays'));
                inputMapString.put('email', (String) inputMap.get('email'));

                APIResponse_WSO response = (APIResponse_WSO) UrlPaiementMonetico_SVE.creerUrlPaiementMonetico (inputMapString, montant);
                Map<String, Object> outputMapSF = new Map<String, Object>();
                if (response.status == 'OK') {
                    UrlPaiementMonetico_WSO urlPaiementMoneticoOk = (UrlPaiementMonetico_WSO) response;
                    outputMapSF.put('url_paiement', urlPaiementMoneticoOk.url_paiement);
                } else {
                    UrlPaiementMonetico_KO_WSO urlPaiementMoneticoKo = (UrlPaiementMonetico_KO_WSO) response;
                    outputMapSF.put('code_message', urlPaiementMoneticoKo.code_message);
                    outputMapSF.put('libelle_court_erreur', urlPaiementMoneticoKo.libelle_court_erreur);
                    outputMapSF.put('libelle_long_erreur', urlPaiementMoneticoKo.libelle_long_erreur);
                    outputMapSF.put('libelle_technique', urlPaiementMoneticoKo.libelle_technique);
                    outputMapSF.put('type_message', urlPaiementMoneticoKo.type_message);
                }
                outputMap.put('response', outputMapSF);

            }

            else if (methodName == IMPRESSIONTICKET) {
                String identifiantRequete = (String) inputMap.get('identifiant_requete');
                String pays_magasin = (String) inputMap.get('pays_magasin');
                String identifiant_partenaire = (String) inputMap.get('identifiant_partenaire');
                String identifiant_transaction_partenaire = (String) inputMap.get('identifiant_transaction_partenaire');
                String identifiant_magasin = (String) inputMap.get('identifiant_magasin');
                String date_transaction_magasin = (String) inputMap.get('date_transaction_magasin') ;
                String identifiant_transaction_magasin = (String) inputMap.get('identifiant_transaction_magasin');
                String status_transaction = (String) inputMap.get('status_transaction');

                APIResponse_WSO response = (APIResponse_WSO) ImpressionTicketCaisse_SVE.creerTicketCaisse (identifiantRequete, pays_magasin, identifiant_partenaire, identifiant_transaction_partenaire, identifiant_magasin, date_transaction_magasin, identifiant_transaction_magasin,status_transaction);
                Map<String, Object> outputMapSF = new Map<String, Object>();
                if (response.status == 'OK') {
                    ImpressionTicketCaisse_WSO impressionTicketCaisseOk = (ImpressionTicketCaisse_WSO) response;
                    outputMapSF.put('code_reponse', impressionTicketCaisseOk.code_reponse);
                    outputMapSF.put('message_reponse', impressionTicketCaisseOk.message_reponse);
                    outputMapSF.put('status_transaction', impressionTicketCaisseOk.status_transaction);
                } else {
                    ImpressionTicketCaisse_KO_WSO impressionTicketCaisseKo = (ImpressionTicketCaisse_KO_WSO) response;
                    outputMapSF.put('code_reponse', impressionTicketCaisseKo.code_reponse);
                    outputMapSF.put('message_reponse', impressionTicketCaisseKo.message_reponse);
                    outputMapSF.put('status_transaction', impressionTicketCaisseKo.status_transaction);
                }
                outputMap.put('response', outputMapSF);
            }
        } catch (Exception e) {
            outputMap.put('response', e.getMessage());
        }
        return null;
    }
}