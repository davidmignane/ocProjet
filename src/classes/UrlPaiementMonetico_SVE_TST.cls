/**
 * @author David diop (Salesforce)
 * @date 23.03.2021
 * @description classe de test pour UrlPaiementMonetico_SVE lié à la recuperation de l'url de paiement monetico
 */
@isTest
public class UrlPaiementMonetico_SVE_TST {
    @isTest
    static void testGetUrlPaiementKo(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 401, "status":"Erreur","type_message":null,"libelle_technique":null,"libelle_long_erreur":null,"libelle_court_erreur","code_message":null}';
       // WSO2VSPDataFactory_TST.createApiRest();
        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401, 'OK','Erreur', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);
        UrlPaiementMonetico_WSI.addressFacturationTwoDTO  addressFacturation = new UrlPaiementMonetico_WSI.addressFacturationTwoDTO ();
        addressFacturation.civilite = '';
        addressFacturation.nom = '';
        addressFacturation.prenom = '';
        addressFacturation.adresse_ligne_1 = '';
        addressFacturation.adresse_ligne_2 = '';
        addressFacturation.adresse_ligne_3 = '';
        addressFacturation.ville = '';
        addressFacturation.code_postal = '';
        addressFacturation.pays = '';
        addressFacturation.email = '';
        UrlPaiementMonetico_WSI.contexteCommandeDTO  contexteCommande = new UrlPaiementMonetico_WSI.contexteCommandeDTO ();

        contexteCommande.adresse_facturation = addressFacturation;

        String reference ='' ;
        String texte_libre ='' ;
        String date_commande ='' ;
        Double montantt =1.5 ;
        UrlPaiementMonetico_WSI urlPaiementMonetico = new UrlPaiementMonetico_WSI(reference,texte_libre,date_commande,montantt,contexteCommande);
        APIResponse_WSO reponse = UrlPaiementMonetico_SVE.getUrlPaiement(urlPaiementMonetico);

        System.debug('reponse'+reponse);
    }
    @isTest
    static void testGetUrlPaiementOk(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 200, "status":"OK","url_paiement":"https://p.monetico-services.com/paiement.cgi?parametre1=valeur1&parametre2=valeur2"}';

        // WSO2VSPDataFactory_TST.createApiRest();
        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200, 'OK','OK', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);
        UrlPaiementMonetico_WSI.addressFacturationTwoDTO  addressFacturation = new UrlPaiementMonetico_WSI.addressFacturationTwoDTO ();
        addressFacturation.civilite = 'M';
        addressFacturation.nom = 'DUPONT';
        addressFacturation.prenom = 'JEAN';
        addressFacturation.adresse_ligne_1 = '1 RUE SESAME';
        addressFacturation.adresse_ligne_2 = 'BAT 2';
        addressFacturation.adresse_ligne_3 = '3E ETAGE';
        addressFacturation.ville = 'PARIS';
        addressFacturation.code_postal = '75007';
        addressFacturation.pays = 'FR';
        addressFacturation.email = 'unutilisateur@uneadresse.com';
        UrlPaiementMonetico_WSI.contexteCommandeDTO  contexteCommande = new UrlPaiementMonetico_WSI.contexteCommandeDTO ();

        contexteCommande.adresse_facturation = addressFacturation;

        String reference ='123456' ;
        String texte_libre ='ELECTROSUR__123456__15.5' ;
        String date_commande ='2021-01-22T13:25:40Z' ;
        Double montantt =15.5 ;
        UrlPaiementMonetico_WSI urlPaiementMonetico = new UrlPaiementMonetico_WSI(reference,texte_libre,date_commande,montantt,contexteCommande);
        UrlPaiementMonetico_SVE.getUrlPaiement(urlPaiementMonetico);
    }
    @IsTest
     static void  testGetUrlPaiementMonetico(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 401, "status":"Erreur","type_message":null,"libelle_technique":null,"libelle_long_erreur":null,"libelle_court_erreur","code_message":null}';
        // WSO2VSPDataFactory_TST.createApiRest();
        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401, 'OK','Erreur', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);
        Double montant =15.5;
        Map<String, String> inputMapString = new Map<String, String>();
        inputMapString.put('reference', '123456');
        inputMapString.put('texteLibre', 'ELECTROSUR__123456__15.5');
        inputMapString.put('dateCommande', '2021-01-22T13:25:40Z');
        inputMapString.put('civilite', 'M');
        inputMapString.put('nom','DUPONT' );
        inputMapString.put('prenom','JEAN' );
        inputMapString.put('adresseLigne1','1 RUE SESAME' );
        inputMapString.put('adresseLigne2', 'BAT 2');
        inputMapString.put('adresseLigne3',  '3E ETAGE');
        inputMapString.put('ville', 'PARIS' );
        inputMapString.put('codePostal', '75007' );
        inputMapString.put('pays', 'FR' );
        inputMapString.put('email', 'unutilisateur@uneadresse.com');
        UrlPaiementMonetico_SVE.creerUrlPaiementMonetico(inputMapString,montant);
    }
    @IsTest
    static void  testGetUrlPaiementMoneticoOk(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 401, "status":"Erreur","type_message":null,"libelle_technique":null,"libelle_long_erreur":null,"libelle_court_erreur","code_message":null}';
        // WSO2VSPDataFactory_TST.createApiRest();
        //WSO2VSP_MCK mock = new WSO2VSP_MCK(401, 'Erreur', body1, body2);
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401, 'OK','Erreur', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);
        Double montant =15.5;
        Map<String, String> inputMapString = new Map<String, String>();
        inputMapString.put('reference', '123456');
        inputMapString.put('texteLibre', 'ELECTROSUR__123456__15.5');
        inputMapString.put('dateCommande', '2021-01-22T13:25:40Z');
        inputMapString.put('civilite', 'M');
        inputMapString.put('nom','DUPONT' );
        inputMapString.put('prenom','JEAN' );
        inputMapString.put('adresseLigne1','1 RUE SESAME' );
        inputMapString.put('adresseLigne2', '');
        inputMapString.put('adresseLigne3',  '');
        inputMapString.put('ville', 'PARIS' );
        inputMapString.put('codePostal', '75007' );
        inputMapString.put('pays', 'FR' );
        inputMapString.put('email', 'unutilisateur@uneadresse.com');
        UrlPaiementMonetico_SVE.creerUrlPaiementMonetico(inputMapString,montant);
    }
}