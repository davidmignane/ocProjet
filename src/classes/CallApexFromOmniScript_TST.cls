/**
 * Created by david on 19.04.2021.
 */
@isTest
public with sharing class CallApexFromOmniScript_TST {
    @isTest
    static void testCreerDevisKo(){

        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 401, "status":"Erreur","type_message":null,"libelle_technique":null,"libelle_long_erreur":null,"libelle_court_erreur":null, "fault":{"message":"Invalid Credentials","description":"Access failure for API: /ogiSubscription/1.0.0, version: 1.0.0 status: (900901) - Invalid Credentials. Make sure you have given the correct access token","code":"900901"},"code_message":null}';

        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401, 'OK','Erreur', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);

        ContratOGI_WSI.DetailGarantiesPrimeAnnuelleDTO detailGarantiesDTO = new ContratOGI_WSI.DetailGarantiesPrimeAnnuelleDTO();
        detailGarantiesDTO.code_garantie = 'PANNE';
        detailGarantiesDTO.mnt_commission = 000000000003.26;
        detailGarantiesDTO.mnt_garantie_ht = 0000000000016.31;
        detailGarantiesDTO.taux_taxe = 20.00;
        detailGarantiesDTO.code_compagnie_verspieren = '359';
        detailGarantiesDTO.num_convention = 'POLICELECTRODEPOT';
        detailGarantiesDTO.ref_convention = 'POLICELECTRODEPOT';
        detailGarantiesDTO.mnt_garantie_ttc = 000000000012.78;

        List<ContratOGI_WSI.DetailGarantiesPrimeAnnuelleDTO> detailGarantiesDTOList = new List<ContratOGI_WSI.DetailGarantiesPrimeAnnuelleDTO>();
        detailGarantiesDTOList.add(detailGarantiesDTO);

        ContratOGI_WSI.DetailGarantiesPrimePeriodeDTO detailGarantiesPeriodeDTO = new ContratOGI_WSI.DetailGarantiesPrimePeriodeDTO();
        detailGarantiesPeriodeDTO.code_garantie = 'PANNE';
        detailGarantiesPeriodeDTO.mnt_commission = 000000000003.26;
        detailGarantiesPeriodeDTO.mnt_garantie_ht = 0000000000016.31;
        detailGarantiesPeriodeDTO.taux_taxe = 20.00;
        detailGarantiesPeriodeDTO.code_compagnie_verspieren = '359';
        detailGarantiesPeriodeDTO.num_convention = 'POLICELECTRODEPOT';
        detailGarantiesPeriodeDTO.ref_convention = 'POLICELECTRODEPOT';
        detailGarantiesPeriodeDTO.mnt_garantie_ttc = 000000000012.78;
        List<ContratOGI_WSI.DetailGarantiesPrimePeriodeDTO> detailGarantiesDTOPeriodeList = new List<ContratOGI_WSI.DetailGarantiesPrimePeriodeDTO>();
        detailGarantiesDTOPeriodeList.add(detailGarantiesPeriodeDTO);
        ContratOGI_WSI.GarantieProduitDTO garantieProduitDTO = new ContratOGI_WSI.GarantieProduitDTO();
        garantieProduitDTO.id_garantie_rattachee = '31608144';
        garantieProduitDTO.code_produit_verspieren = 'BR';


        ContratOGI_WSI.PrimeAnnuelleDTO primeAnnuelleDTO = new ContratOGI_WSI.PrimeAnnuelleDTO();
        primeAnnuelleDTO.mnt_frais_gestion = 000000005.67;
        primeAnnuelleDTO.mnt_taxe_attentats = 000000005.00;

        ContratOGI_WSI.ApporteursDTO apporteursDTO = new ContratOGI_WSI.ApporteursDTO();
        apporteursDTO.taux_commission_apporteur = 015.00;
        apporteursDTO.date_fin_retro_commission = null;
        apporteursDTO.num_apporteur_verspieren = '1234';
        apporteursDTO.mode_calcul_commission = 'F';
        apporteursDTO.mnt_commission = null;
        List<ContratOGI_WSI.ApporteursDTO> apporteursDTOList = new List<ContratOGI_WSI.ApporteursDTO>();
        apporteursDTOList.add(apporteursDTO);

        ContratOGI_WSI.ContratDTO contratDTO = new ContratOGI_WSI.ContratDTO();
        contratDTO.id_contrat_adherent = '';
        contratDTO.date_effet = '2021-02-22';
        contratDTO.date_fin_contrat = '';
        contratDTO.code_fractionnement = '1';
        contratDTO.date_anniversaire_jjmm = '2202';

        ContratOGI_WSI.DetailSouscriptionDTO detailSouscriptionDTO = new ContratOGI_WSI.DetailSouscriptionDTO();
        detailSouscriptionDTO.num_adherent = '';
        detailSouscriptionDTO.raison_sociale = '';
        detailSouscriptionDTO.civilite = 'M';
        detailSouscriptionDTO.nom = 'TSTNOM';
        detailSouscriptionDTO.prenom = 'TSTPRENOM';
        detailSouscriptionDTO.date_naissance = '1980-05-08';
        detailSouscriptionDTO.telephone_domicile = '';
        detailSouscriptionDTO.telephone_mobile = '';
        detailSouscriptionDTO.email = 'TESTEMAIL@VERSPIEREN.COM';
        detailSouscriptionDTO.iban = 'fr7615135005000482236591243';
        detailSouscriptionDTO.bic = 'CEPAFRPP513';
        detailSouscriptionDTO.complement_identitie = '';
        detailSouscriptionDTO.voie = 'rue tst';
        detailSouscriptionDTO.complement_voie = '';
        detailSouscriptionDTO.commune = 'LANNOY';
        detailSouscriptionDTO.code_postal = '59390';
        detailSouscriptionDTO.bureau_distributeur = 'LANNOY';
        detailSouscriptionDTO.nom_pays = 'FRANCE';
        detailSouscriptionDTO.code_pays = 'FRA';

        ContratOGI_WSI.generalDTO generalDTO = new ContratOGI_WSI.generalDTO();
        generalDTO.code_action = '01';
        generalDTO.code_motif = '01';
        generalDTO.canal_de_vente = 'MAGA';
        generalDTO.mode_paiement = '01';
        generalDTO.id_contrat_mere = '0015033849';
        generalDTO.id_externe_client_001 = 'REFCLIVLC';
        generalDTO.id_externe_client_002 = 'REFCLIED';
        generalDTO.id_externe_contrat_001 = 'REFCTVLC';
        generalDTO.id_externe_contrat_002 = 'REFCTED';
        generalDTO.detail_souscription =  detailSouscriptionDTO;
        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('prime_annuelle',primeAnnuelleDTO);
        inputMap.put('general',generalDTO);
        inputMap.put('garantie_produit',garantieProduitDTO);
        inputMap.put('detail_garanties_prime_periode',detailGarantiesDTOPeriodeList);
        inputMap.put('detail_garanties_prime_annuelle',detailGarantiesDTOList);
        inputMap.put('contrat',contratDTO);
        inputMap.put('apporteurs',apporteursDTOList);
        CallApexFromOmniScript_UTL callAPEX =  new CallApexFromOmniScript_UTL();
        Map<String, Object> outputMap =  new Map<String, Object> ();
        Map<String, Object> options =  new Map<String, Object> ();
        Test.startTest();
        callAPEX.invokeMethod('CreerDevis',inputMap,outputMap,options);
        Test.stopTest();
    }
    @isTest
    static void testCreerDevisoK(){

        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 200, "status":"OK","type_message":null,"libelle_technique":null,"libelle_long_erreur":null,"libelle_court_erreur":null,"code_message":null,"num_quittance":"0003939088","rum":"0025630870","num_contrat":"0094028320","num_client":"403754"}';

        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200, 'OK','OK', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);

        ContratOGI_WSI.DetailGarantiesPrimeAnnuelleDTO detailGarantiesDTO = new ContratOGI_WSI.DetailGarantiesPrimeAnnuelleDTO();
        detailGarantiesDTO.code_garantie = 'PANNE';
        detailGarantiesDTO.mnt_commission = 46.44;
        detailGarantiesDTO.mnt_garantie_ht = 66.06;
        detailGarantiesDTO.taux_taxe = 9;
        detailGarantiesDTO.code_compagnie_verspieren = '761';
        detailGarantiesDTO.num_convention = 'LEKKS2';
        detailGarantiesDTO.ref_convention = 'RéfConvetion';
        detailGarantiesDTO.mnt_garantie_ttc = 72;
        List<ContratOGI_WSI.DetailGarantiesPrimeAnnuelleDTO> detailGarantiesDTOList = new List<ContratOGI_WSI.DetailGarantiesPrimeAnnuelleDTO>();
        detailGarantiesDTOList.add(detailGarantiesDTO);

        ContratOGI_WSI.DetailGarantiesPrimePeriodeDTO detailGarantiesPeriodeDTO = new ContratOGI_WSI.DetailGarantiesPrimePeriodeDTO();
        detailGarantiesPeriodeDTO.code_garantie = 'PANNE';
        detailGarantiesPeriodeDTO.mnt_commission =3.87;
        detailGarantiesPeriodeDTO.mnt_garantie_ht = 5.5;
        detailGarantiesPeriodeDTO.taux_taxe = 9;
        detailGarantiesPeriodeDTO.code_compagnie_verspieren = '761';
        detailGarantiesPeriodeDTO.num_convention = 'LEKKS2';
        detailGarantiesPeriodeDTO.ref_convention = 'RéfConvetion';
        detailGarantiesPeriodeDTO.mnt_garantie_ttc = 6.00;
        List<ContratOGI_WSI.DetailGarantiesPrimePeriodeDTO> detailGarantiesDTOPeriodeList = new List<ContratOGI_WSI.DetailGarantiesPrimePeriodeDTO>();
        detailGarantiesDTOPeriodeList.add(detailGarantiesPeriodeDTO);

        ContratOGI_WSI.GarantieProduitDTO garantieProduitDTO = new ContratOGI_WSI.GarantieProduitDTO();
        garantieProduitDTO.id_garantie_rattachee = '';
        garantieProduitDTO.code_produit_verspieren = 'BR';
        List<ContratOGI_WSI.garantieProduitDTO> garantieProduitDTOList = new List<ContratOGI_WSI.garantieProduitDTO>();
        garantieProduitDTOList.add(garantieProduitDTO);

        ContratOGI_WSI.PrimeAnnuelleDTO primeAnnuelleDTO = new ContratOGI_WSI.PrimeAnnuelleDTO();

        ContratOGI_WSI.ApporteursDTO apporteursDTO = new ContratOGI_WSI.ApporteursDTO();
        apporteursDTO.taux_commission_apporteur = 0;
        apporteursDTO.date_fin_retro_commission = null;
        apporteursDTO.num_apporteur_verspieren = '3004';
        apporteursDTO.mode_calcul_commission = 'F';
        apporteursDTO.mnt_commission = '2.75';
        ContratOGI_WSI.ApporteursDTO apporteursDTO2 = new ContratOGI_WSI.ApporteursDTO();
        apporteursDTO2.taux_commission_apporteur = 0;
        apporteursDTO2.date_fin_retro_commission = null;
        apporteursDTO2.num_apporteur_verspieren = '3003';
        apporteursDTO2.mode_calcul_commission = 'F';
        apporteursDTO2.mnt_commission = '0.24';
        List<ContratOGI_WSI.ApporteursDTO> apporteursDTOList = new List<ContratOGI_WSI.ApporteursDTO>();
        apporteursDTOList.add(apporteursDTO);
        apporteursDTOList.add(apporteursDTO2);

        ContratOGI_WSI.ContratDTO contratDTO = new ContratOGI_WSI.ContratDTO();
        contratDTO.id_contrat_adherent = '';
        contratDTO.date_effet = '2021-04-16';
        contratDTO.date_fin_contrat = '';
        contratDTO.code_fractionnement = '4';
        contratDTO.date_anniversaire_jjmm = '1504';

        ContratOGI_WSI.DetailSouscriptionDTO detailSouscriptionDTO = new ContratOGI_WSI.DetailSouscriptionDTO();
        detailSouscriptionDTO.num_adherent = '';
        detailSouscriptionDTO.raison_sociale = '';
        detailSouscriptionDTO.civilite = 'M';
        detailSouscriptionDTO.nom = 'CAVANAS';
        detailSouscriptionDTO.prenom = 'ADRIEN';
        detailSouscriptionDTO.date_naissance = '2002-12-11';
        detailSouscriptionDTO.telephone_domicile = '';
        detailSouscriptionDTO.telephone_mobile = '33649112834';
        detailSouscriptionDTO.email = 'diopdavid94@gmail.com';
        detailSouscriptionDTO.iban = 'FR7630001007941234567890185';
        detailSouscriptionDTO.bic = '';
        detailSouscriptionDTO.complement_identitie = '';
        detailSouscriptionDTO.voie = 'rue des roses ';
        detailSouscriptionDTO.complement_voie = '';
        detailSouscriptionDTO.commune = 'LILLE';
        detailSouscriptionDTO.code_postal = '59000';
        detailSouscriptionDTO.bureau_distributeur = '';
        detailSouscriptionDTO.nom_pays = 'FR';
        detailSouscriptionDTO.code_pays = 'FRA';

        ContratOGI_WSI.generalDTO generalDTO = new ContratOGI_WSI.generalDTO();
        generalDTO.code_action = '01';
        generalDTO.code_motif = '01';
        generalDTO.canal_de_vente = 'F029';
        generalDTO.mode_paiement = '02';
        generalDTO.id_contrat_mere = '0015033849';
        generalDTO.id_externe_client_001 = '0019E00001RxmyZQAR';
        generalDTO.id_externe_client_002 = 'REFCTED';
        generalDTO.id_externe_contrat_001 = '0Q09E000000zxumSAA';
        generalDTO.id_externe_contrat_002 = '105-114423';
        generalDTO.detail_souscription =  detailSouscriptionDTO;

        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('prime_annuelle',null);
        inputMap.put('general',generalDTO);
        inputMap.put('garantie_produit',garantieProduitDTO);
        inputMap.put('detail_garanties_prime_periode',detailGarantiesDTOPeriodeList);
        inputMap.put('detail_garanties_prime_annuelle',detailGarantiesDTOList);
        inputMap.put('contrat',contratDTO);
        inputMap.put('apporteurs',apporteursDTOList);

        CallApexFromOmniScript_UTL callAPEX =  new CallApexFromOmniScript_UTL();
        Map<String, Object> outputMap =  new Map<String, Object> ();
        Map<String, Object> options =  new Map<String, Object> ();
        Test.startTest();
        callAPEX.invokeMethod('CreerDevis',inputMap,outputMap,options);
        Test.stopTest();
    }
    @isTest
    static void testCreerProcedureSignatureElectroniqueOK()
    {

        String body2 = '{"status_signature": "active","identifiant_procedure": "id_procedure","url_signature": "https://staging-app.yousign.com/procedure/sign?members=/members/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx","erreurs": []}';

        String body = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
                ' "token_type": "Bearer", "expires_in": 3600  }';

        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200,'OK', 'OK', body, body2);
        Test.setMock(HttpCalloutMock.class, mock);
        Account accountRecord = new Account();
        accountRecord.Name = 'Business';
        insert accountRecord;


        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('num contrat ogi','0094028320');
        inputMap.put('rum','0025630870');
        inputMap.put('email','tst@email.com');
        inputMap.put('telephone','0102030405');
        inputMap.put('iban','FR7630001007941234567890185');
        inputMap.put('accountId',accountRecord.Id);
        CallApexFromOmniScript_UTL callAPEX =  new CallApexFromOmniScript_UTL();
        Map<String, Object> outputMap =  new Map<String, Object> ();
        Map<String, Object> options =  new Map<String, Object> ();
        Test.startTest();
        callAPEX.invokeMethod('SignatureElectronique',inputMap,outputMap,options);
        Test.stopTest();
        }
    @isTest
    static void testCreerProcedureSignatureElectroniqueKo()
    {

        String body2 = '{"status_signature": "active","identifiant_signature": null,"url_signature": null,"erreurs": [ {\n'+
                '"identifiant_erreur": "ERR_01","libelle_erreur": "ERROR N°001 DESCRIPTION","erreur_date_time": "2021-03-03T12:04:07+01:00" }],\n'+
                '"fault": {"code": "404", "type": "Status report", "message": "Not Found", "description": "The requested resource (/signature/1.0.0/init/full) is not available."}}';

        String body = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
                ' "token_type": "Bearer", "expires_in": 3600  }';

        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,400,'OK', 'KO', body, body2);
        Test.setMock(HttpCalloutMock.class, mock);
        Account accountRecord = new Account();
        accountRecord.Name = 'Business';
        insert accountRecord;


        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('num contrat ogi','0094028320');
        inputMap.put('rum','0025630870');
        inputMap.put('email','tst@email.com');
        inputMap.put('telephone','0102030405');
        inputMap.put('iban','');
        inputMap.put('accountId',accountRecord.Id);
        CallApexFromOmniScript_UTL callAPEX =  new CallApexFromOmniScript_UTL();
        Map<String, Object> outputMap =  new Map<String, Object> ();
        Map<String, Object> options =  new Map<String, Object> ();
        Test.startTest();
        callAPEX.invokeMethod('SignatureElectronique',inputMap,outputMap,options);
        Test.stopTest();
    }

    @isTest
    static void testGetUrlPaiementKo(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 401, "status":"Erreur","type_message":null,"libelle_technique":null,"libelle_long_erreur":null,"libelle_court_erreur","code_message":null}';
        // WSO2VSPDataFactory_TST.createApiRest();
        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401, 'OK','Erreur', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('reference','123456');
        inputMap.put('teste_libre','ELECTROSUR__123456__15.5');
        inputMap.put('date_commande','2021-01-22T13:25:40Z');
        inputMap.put('civilite','M');
        inputMap.put('nom','DUPONT');
        inputMap.put('prenom','JEAN');
        inputMap.put('adresse_ligne_1','1 RUE SESAME');
        inputMap.put('adresse_ligne_2','BAT 2');
        inputMap.put('adresse_ligne_3','3E ETAGE');
        inputMap.put('ville','PARIS');
        inputMap.put('code_postal','75007');
        inputMap.put('pays','France');
        inputMap.put('email','unutilisateur@uneadresse.com');
        inputMap.put('montant',15.5);

        CallApexFromOmniScript_UTL callAPEX =  new CallApexFromOmniScript_UTL();
        Map<String, Object> outputMap =  new Map<String, Object> ();
        Map<String, Object> options =  new Map<String, Object> ();
        Test.startTest();
        callAPEX.invokeMethod('GetUrl',inputMap,outputMap,options);
        Test.stopTest();
    }

    @isTest
    static void impressionTicketCaisseKo(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 401, "status":"Erreur","code_reponse":null,"message_reponse":null,"status_transaction":null}';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401, 'Erreur','ko', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('identifiant_requete','1234567890');
        inputMap.put('pays_magasin','FR');
        inputMap.put('identifiant_partenaire','ELECDEPOT');
        inputMap.put('identifiant_transaction_partenaire','1234567890090896');
        inputMap.put('identifiant_magasin','MAG000123');
        inputMap.put('date_transaction_magasin','2021-03-26');
        inputMap.put('identifiant_transaction_magasin','1609F0001MAG123');
        inputMap.put('status_transaction','OK');
        CallApexFromOmniScript_UTL callAPEX =  new CallApexFromOmniScript_UTL();
        Map<String, Object> outputMap =  new Map<String, Object> ();
        Map<String, Object> options =  new Map<String, Object> ();
        Test.startTest();
        callAPEX.invokeMethod('ImpressionTicket',inputMap,outputMap,options);
        Test.stopTest();
    }
}