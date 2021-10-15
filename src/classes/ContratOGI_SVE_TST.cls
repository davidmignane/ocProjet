/**
 * @author David diop (Salesforce)
 * @date 05.03.2021
 * @description classe de test pour ContratOGI_SVE
 */
@isTest
public class ContratOGI_SVE_TST {
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
        ContratOGI_WSI contratOGIWSI = new ContratOGI_WSI(generalDTO,contratDTO,apporteursDTOList,primeAnnuelleDTO,garantieProduitDTO,detailGarantiesDTOList,detailGarantiesDTOPeriodeList);

        Test.startTest();
        ContratOGI_SVE.createDevis(contratOGIWSI);
        Test.stopTest();
    }
    @isTest
    static void testCreerDevisOk(){

        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 200, "status":"OK","num_client":"1123432","num_contrat":"123324","num_quittance":"12344","rum":"233444", "fault":{"message":"Invalid Credentials","description":"Access failure for API: /ogiSubscription/1.0.0, version: 1.0.0 status: (900901) - Invalid Credentials. Make sure you have given the correct access token","code":"900901"},"code_message":null}';
        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200, 'OK','OK', body1, body2);
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
        ContratOGI_WSI contratOGIWSI = new ContratOGI_WSI(generalDTO,contratDTO,apporteursDTOList,primeAnnuelleDTO,garantieProduitDTO,detailGarantiesDTOList,detailGarantiesDTOPeriodeList);

        Test.startTest();
        ContratOGI_SVE.createDevis(contratOGIWSI);
        Test.stopTest();
    }
}