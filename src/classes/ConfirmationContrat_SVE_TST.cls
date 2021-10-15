@istest
public with sharing class ConfirmationContrat_SVE_TST {
    
    
    @istest
    static void testConfirmerContrat(){
        ConfirmationContrat_WSI requete = new ConfirmationContrat_WSI();
        ConfirmationContrat_WSI.FichiersWSI fichier = new ConfirmationContrat_WSI.FichiersWSI();
        fichier.reference_fichier  = '2222222222';
        fichier.type_fichier = '02';
        requete.fichiers = new List< ConfirmationContrat_WSI.FichiersWSI>{fichier};
        ConfirmationContrat_WSI.Tokens tokens = new ConfirmationContrat_WSI.Tokens();
        tokens.token = '1111BBBB';
        requete.tokens = new List<ConfirmationContrat_WSI.Tokens> {tokens};
        requete.action = 'ENR';
        requete.identifiant_procedure = '123AAA';
        requete.code_societe = '00';
        requete.date_creation = '2021-03-15';
        requete.date_signature = '2021-03-15';
        requete.reference_externe ='GGXDT055';
        requete.clef_reference_externe ='500109397';
        requete.nombre_tokens = 1;
        requete.nombre_fichiers = 1;

        String bodyResponseToken = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
        ' "token_type": "Bearer", "expires_in": 3600  }';

        String bodyResponseConfirmationSign = '{"code_retour" : "02","message_retour" : "Enregistrement effectué","date_debut_prelevement" : "2021-03-24","date_fin_prelevement" :" 2021-03-25","erreurs" : null }';
        Test.startTest();
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200,'OK', 'OK', bodyResponseToken, bodyResponseConfirmationSign);
        Test.setMock(HttpCalloutMock.class, mock);
        ConfirmationContrat_WSO confirmation = ConfirmationContrat_SVE.confirmerContrat(requete);
        System.assertEquals(200, confirmation.statusCode, '## pass ##');
        System.assertEquals('Enregistrement effectué', confirmation.message_retour, '## pass ##');

        Test.stopTest();
    }

    @istest
    static void testConfirmerContratError(){
        ConfirmationContrat_WSI requete = new ConfirmationContrat_WSI();
        ConfirmationContrat_WSI.FichiersWSI fichier = new ConfirmationContrat_WSI.FichiersWSI();
        fichier.reference_fichier  = '2222222222';
        fichier.type_fichier = '02';
        requete.fichiers = new List< ConfirmationContrat_WSI.FichiersWSI>{fichier};
        ConfirmationContrat_WSI.Tokens tokens = new ConfirmationContrat_WSI.Tokens();
        tokens.token = '1111BBBB';
        requete.tokens = new List<ConfirmationContrat_WSI.Tokens> {tokens};
        requete.action = 'ENR';
        requete.identifiant_procedure = '123AAA';
        requete.code_societe = '00';
        requete.date_creation = '2021-03-15';
        requete.date_signature = '2021-03-15';
        requete.reference_externe ='GGXDT055';
        requete.clef_reference_externe ='500109397';
        requete.nombre_tokens = 1;
        requete.nombre_fichiers = 1;

        String bodyResponseToken = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
        ' "token_type": "Bearer", "expires_in": 3600  }';

        String bodyResponseConfirmationSign = '{"code_retour" : "","message_retour" : "","date_debut_prelevement" : "","date_fin_prelevement" :"","erreurs" : [ {"code_retour" :"0198","libelle_court" : "test ","libelle_long"  : "long libbele","libelle_tech"  : "tech libelle","type": "type"}]}';
        Test.startTest();
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200,'OK', 'OK', bodyResponseToken, bodyResponseConfirmationSign);
        Test.setMock(HttpCalloutMock.class, mock);
        ConfirmationContrat_WSO confirmation = ConfirmationContrat_SVE.confirmerContrat(requete);
        System.assertEquals(200, confirmation.statusCode, '## pass ##');
        System.assertEquals('long libbele', confirmation.erreurs.get(0).libelle_long, '## pass ##');
        Test.stopTest();
    }

    @istest
    static void testConfirmerContratErrorToken(){
        Test.startTest();
        ConfirmationContrat_WSI requete = new ConfirmationContrat_WSI();
        ConfirmationContrat_WSI.FichiersWSI fichier = new ConfirmationContrat_WSI.FichiersWSI();
        fichier.reference_fichier  = '2222222222';
        fichier.type_fichier = '02';
        requete.fichiers = new List< ConfirmationContrat_WSI.FichiersWSI>{fichier};
        ConfirmationContrat_WSI.Tokens tokens = new ConfirmationContrat_WSI.Tokens();
        tokens.token = '1111BBBB';
        requete.tokens = new List<ConfirmationContrat_WSI.Tokens> {tokens};
        requete.action = 'ENR';
        requete.identifiant_procedure = '123AAA';
        requete.code_societe = '00';
        requete.date_creation = '2021-03-15';
        requete.date_signature = '2021-03-15';
        requete.reference_externe ='GGXDT055';
        requete.clef_reference_externe ='500109397';
        requete.nombre_tokens = 1;
        requete.nombre_fichiers = 1;

        String bodyResponseToken = '{ "scope": "am_application_scope default",\n'+
        ' "token_type": "Bearer", "expires_in": 3600  }';

        String bodyResponseConfirmationSign = '{"code_retour" : "999","message_retour" : "ERROR OGI - Contact OGI to debug","date_debut_prelevement" : "","date_fin_prelevement" :"","erreurs" : [ {"code_retour" :"","libelle_court" : "test ","libelle_long"  : "long libbele","libelle_tech"  : "tech libelle","type": "type"}]}';
      
        WSO2VSP_MCK mock = new WSO2VSP_MCK(401,200,'OK', 'OK', bodyResponseToken, bodyResponseConfirmationSign);
        Test.setMock(HttpCalloutMock.class, mock);
        ConfirmationContrat_WSO confirmation = new ConfirmationContrat_WSO();
        confirmation = ConfirmationContrat_SVE.confirmerContrat(requete);
        System.assertEquals(401, confirmation.statusCode, '## pass ##');
        System.assertEquals('Erreur', confirmation.status, '## pass ##');
        Test.stopTest();
    }

    @istest
    static void testConfirmerContratKO(){
        Test.startTest();
        ConfirmationContrat_WSI requete = new ConfirmationContrat_WSI();
        ConfirmationContrat_WSI.FichiersWSI fichier = new ConfirmationContrat_WSI.FichiersWSI();
        fichier.reference_fichier  = '2222222222';
        fichier.type_fichier = '02';
        requete.fichiers = new List< ConfirmationContrat_WSI.FichiersWSI>{fichier};
        ConfirmationContrat_WSI.Tokens tokens = new ConfirmationContrat_WSI.Tokens();
        tokens.token = '1111BBBB';
        requete.tokens = new List<ConfirmationContrat_WSI.Tokens> {tokens};
        requete.action = 'ENR';
        requete.identifiant_procedure = '123AAA';
        requete.code_societe = '00';
        requete.date_creation = '2021-03-15';
        requete.date_signature = '2021-03-15';
        requete.reference_externe ='GGXDT055';
        requete.clef_reference_externe ='500109397';
        requete.nombre_tokens = 1;
        requete.nombre_fichiers = 1;

        String bodyResponseToken = '{ "scope": "am_application_scope default",\n'+
        ' "token_type": "Bearer", "expires_in": 3600  }';

        String bodyResponseConfirmationSign = '{"message_retour":null,"fault":{"type":null,"message":"Missing Credentials","description":"Required OAuth credentials not provided. Make sure your API invocation call has a header","code":"900902"},"erreurs":null,"date_fin_prelevement":null,"date_debut_prelement":null,"code_retour":null}';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401,'OK', 'KO', bodyResponseToken, bodyResponseConfirmationSign);
        Test.setMock(HttpCalloutMock.class, mock);
        ConfirmationContrat_WSO confirmation = new ConfirmationContrat_WSO();
        confirmation = ConfirmationContrat_SVE.confirmerContrat(requete);
      
        System.assertEquals(401, confirmation.statusCode, '## pass ##');
        System.assertEquals('Erreur', confirmation.status, ' ## pass ##');
        Test.stopTest();
    }
}