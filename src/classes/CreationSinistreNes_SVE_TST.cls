/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 09-21-2021
 * @last modified by  : David Mignane Diop
**/
@isTest
public  class CreationSinistreNes_SVE_TST {
    @isTest
    static void testCreationSinistreKo(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 401, "status":"Erreur","type_message":null,"libelle_technique":null,"libelle_long_erreur":null,"libelle_court_erreur":null, "fault":{"message":"Invalid Credentials","description":"Access failure for API: /ogiSubscription/1.0.0, version: 1.0.0 status: (900901) - Invalid Credentials. Make sure you have given the correct access token","code":"900901"},"code_message":null}';

        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401, 'OK','Erreur', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);

        WSO2VSPDataFactory_TST.buildAccountObject();
        Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
        vlocity_ins__InsuranceClaim__c claims = WSO2VSPDataFactory_TST.buildClaimObject();

       List<Asset>  asst =  WSO2VSPDataFactory_TST.buildAssetObject();
       Asset ast = asst[0];
       ast.AccountId = account.Id;
       insert ast;
       
       claims.vlocity_ins__PrimaryPolicyAssetId__c = ast.Id;

       insert claims;
       List<Id> claimIds = new List<Id>();
       claimIds.add(claims.Id);

       vlocity_ins__ClaimCoverage__c claimCoverage = WSO2VSPDataFactory_TST.buildClaimCovarageObject();
       claimCoverage.vlocity_ins__ClaimId__c = claims.Id;
       insert claimCoverage;
        /*CreationSinistresNES_WSI.offreDTO offre = new CreationSinistresNES_WSI.offreDTO();
            offre.code = 'ELEC0001';
            offre.libelle = 'electrosur ou autre';


        CreationSinistresNES_WSI.adresseDTO adresse = new CreationSinistresNES_WSI.adresseDTO();
        adresse.ligne_1 = 'AVENUE DE L EUROPE' ;
        adresse.ligne_2 = 'COMPLEMENT 1';
        adresse.ligne_3 = 'COMPLEMENT 2' ;
        adresse.ligne_4 = 'COMPLEMENT 3' ;
        adresse.ville = 'ORLEANS';
        adresse.code_postal = '45000';
        adresse.pays =  'FR';

        CreationSinistresNES_WSI.clientDTO client = new CreationSinistresNES_WSI.clientDTO();
        client.adresse = adresse ;
        client.prenom = 'JEAN';
        client.nom = 'DOUX';
        client.telephone = '+33320123456';
        client.email = 'jean.doux@yopmail.com' ;

        CreationSinistresNES_WSI.ContratDTO contrat = new CreationSinistresNES_WSI.ContratDTO();
        contrat.numero_contrat_collectif = 'LKKS2 CV7WKV' ;
        contrat.plafond_indemnisation = 1500;
        contrat.offre = offre;
        contrat.client = client;

        CreationSinistresNES_WSI.familleDTO famille = new CreationSinistresNES_WSI.familleDTO();
        famille.code = 'TEL';
        famille.nom = 'Téléviseur';

        CreationSinistresNES_WSI.categorieDTO categorie = new CreationSinistresNES_WSI.categorieDTO();
        categorie.code = 'BRU';
        categorie.nom = 'BRUN';

        CreationSinistresNES_WSI.marqueDTO marque = new CreationSinistresNES_WSI.marqueDTO();
        marque.code = 'SAM';
        marque.nom = 'SAMSUNG';

        CreationSinistresNES_WSI.produitSinistreDTO produitSinistre = new CreationSinistresNES_WSI.produitSinistreDTO();
        produitSinistre.code = 'UE50NU7025';
        produitSinistre.nom = 'TV UHD 4K SAMSUNG UE50NU7025 SAMRT HDR W';
        produitSinistre.date_achat = '2020-12-25';
        produitSinistre.prix_achat_net_ttc = 399.9;
        produitSinistre.numero_serie = 'SN123456';
        produitSinistre.imei = '123456789012345';
        produitSinistre.numero_facture = 'F123456';
        produitSinistre.marque = marque;
        produitSinistre.categorie = categorie;
        produitSinistre.famille = famille;

        CreationSinistresNES_WSI creationSinistre = new CreationSinistresNES_WSI();
        creationSinistre.id_sinistre_verspieren_sf = '11571708';
        creationSinistre.description = 'Panne suite...';
        creationSinistre.contrat = contrat ;
        creationSinistre.produit_sinistre = produitSinistre ;*/

        //CreationSinistresNES_SVE.creerSinistre(creationSinistre);
        CreationSinistresNES_SVE.creerSinistre(claimIds);

    }

    @isTest
    static void testCreationSinistreOk(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 200, "status":"OK","id_partenaire":"NES","id_sinistre_partenaire":"123456"}';

        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200, 'OK','OK', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);
        
            WSO2VSPDataFactory_TST.buildAccountObject();
            Account account = [SELECT Id, PersonContactId FROM Account WHERE FirstName ='testSendEmail'];
            vlocity_ins__InsuranceClaim__c claims = WSO2VSPDataFactory_TST.buildClaimObject();

           List<Asset>  asst =  WSO2VSPDataFactory_TST.buildAssetObject();
           Asset ast = asst[0];
           ast.AccountId = account.Id;
           insert ast;
           
           claims.vlocity_ins__PrimaryPolicyAssetId__c = ast.Id;

           insert claims;
           List<Id> claimIds = new List<Id>();
           claimIds.add(claims.Id);

           vlocity_ins__ClaimCoverage__c claimCoverage = WSO2VSPDataFactory_TST.buildClaimCovarageObject();
           claimCoverage.vlocity_ins__ClaimId__c = claims.Id;
           insert claimCoverage;

        CreationSinistresNES_WSI.offreDTO offre = new CreationSinistresNES_WSI.offreDTO();
            offre.code = 'ELEC0001';
            offre.libelle = 'electrosur ou autre';
        CreationSinistresNES_WSI.adresseDTO adresse = new CreationSinistresNES_WSI.adresseDTO();
            adresse.ligne_1 = 'AVENUE DE L EUROPE' ;
            adresse.ligne_2 = 'COMPLEMENT 1';
            adresse.ligne_3 = 'COMPLEMENT 2' ;
            adresse.ligne_4 = 'COMPLEMENT 3' ;
            adresse.ville = 'ORLEANS';
            adresse.code_postal = '45000';
            adresse.pays =  'FR';

        CreationSinistresNES_WSI.clientDTO client = new CreationSinistresNES_WSI.clientDTO();
            client.adresse = adresse ;
            client.prenom = 'JEAN';
            client.nom = 'DOUX';
            client.telephone = '+33320123456';
            client.email = 'jean.doux@yopmail.com' ;

        CreationSinistresNES_WSI.ContratDTO contrat = new CreationSinistresNES_WSI.ContratDTO();
            contrat.numero_contrat_collectif = 'LKKS2 CV7WKV' ;
            contrat.plafond_indemnisation = 1500;
            contrat.offre = offre;
            contrat.client = client;

        CreationSinistresNES_WSI.familleDTO famille = new CreationSinistresNES_WSI.familleDTO();
            famille.code = 'TEL';
            famille.nom = 'Téléviseur';

        CreationSinistresNES_WSI.categorieDTO categorie = new CreationSinistresNES_WSI.categorieDTO();
            categorie.code = 'BRU';
            categorie.nom = 'BRUN';

        CreationSinistresNES_WSI.marqueDTO marque = new CreationSinistresNES_WSI.marqueDTO();
            marque.code = 'SAM';
            marque.nom = 'SAMSUNG';

        CreationSinistresNES_WSI.produitSinistreDTO produitSinistre = new CreationSinistresNES_WSI.produitSinistreDTO();
            produitSinistre.code = 'UE50NU7025';
            produitSinistre.nom = 'TV UHD 4K SAMSUNG UE50NU7025 SAMRT HDR W';
            produitSinistre.date_achat = '2020-12-25';
            produitSinistre.prix_achat_net_ttc = 399.9;
            produitSinistre.numero_serie = 'SN123456';
            produitSinistre.imei = '123456789012345';
            produitSinistre.numero_facture = 'F123456';
            produitSinistre.marque = marque;
            produitSinistre.categorie = categorie;
            produitSinistre.famille = famille;

        CreationSinistresNES_WSI creationSinistre = new CreationSinistresNES_WSI();
            creationSinistre.id_sinistre_verspieren_sf = '11571708';
            creationSinistre.description = 'Panne suite...';
            creationSinistre.contrat = contrat ;
            creationSinistre.produit_sinistre = produitSinistre ;

        CreationSinistresNES_SVE.creerSinistre(claimIds);
    }
}