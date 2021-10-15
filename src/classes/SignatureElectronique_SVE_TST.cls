/**
 * @author Madicke BALDE
 * @description classe de test de SignatureElectronique_SVE
 * @date 09/03/2021
 */
@istest
public with sharing class SignatureElectronique_SVE_TST 
{
    
        @isTest
        static void testCreerProcedureSignatureElectroniqueOK()
        {
        
            String body2 = '{"status_signature": "active","identifiant_procedure": "id_procedure","url_signature": "https://staging-app.yousign.com/procedure/sign?members=/members/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx","erreurs": []}';
        
            String body = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
            ' "token_type": "Bearer", "expires_in": 3600  }';
        
            
            Test.startTest();
        
            WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200,'OK', 'OK', body, body2);
            String jsonS =  '{"procedure": {"nom_procedure": "name","description_procedure": "signatureDescription",\n'+
                            '"activer_procedure": true,"archiver_procedure": false },"fichiers": [{ "nom_fichier": "my_signature_document.pdf",\n'+
                            '"contenu_fichier": "JVBERi0xLjUKJb/3ov4KNiAwIG9iago8PCAvTGluZWFy…","numero_page": 1,"position_signature": "300,200,350, 150",\n'+
                            '"mention_signature": "Read and approved","mention_signature_2": "","raison_signature": "Signed by John Doe"\n'+
                            '} ],"membre": {"prenom": "tstFirstName","nom": "tstLastName", "email": "tst@email.com", "telephone": "0102030405"\n'+
                            '},"configurations": {"utiliser_template": false,"identifiant_template": "xxxx","template_sms": "Test sms template overriding" }}';
            SignatureElectronique_WSI signature = (SignatureElectronique_WSI) JSON.deserialize(jsonS,SignatureElectronique_WSI.class );
            Test.setMock(HttpCalloutMock.class, mock);
            SignatureElectronique_WSO signatureResponse   = SignatureElectronique_SVE.creerProcedureSignatureElectronique(signature);
           
            System.assertEquals('OK', signatureResponse.status, 'pass');
            System.assertEquals('id_procedure', signatureResponse.identifiant_procedure, '## pass ## ');
            Test.stopTest();
        }
        
        @isTest
        static void testCreerProcedureSignatureElectroniqueErreurToken()
        {
        
            String body2 = '{"status_signature": "active","identifiant_procedure": "id_procedure","url_signature": "https://staging-app.yousign.com/procedure/sign?members=/members/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx","erreurs": []}';
        
            String body = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
            ' "token_type": "Bearer", "expires_in": 3600  }';
        
           
            
            Test.startTest();
        
            WSO2VSP_MCK mock = new WSO2VSP_MCK(401,200,'KO', 'OK', body, body2);
            String jsonS =  '{"procedure": {"nom_procedure": "name","description_procedure": "signatureDescription",\n'+
                            '"activer_procedure": true,"archiver_procedure": false },"fichiers": [{ "nom_fichier": "my_signature_document.pdf",\n'+
                            '"contenu_fichier": "JVBERi0xLjUKJb/3ov4KNiAwIG9iago8PCAvTGluZWFy…","numero_page": 1,"position_signature": "300,200,350, 150",\n'+
                            '"mention_signature": "Read and approved","mention_signature_2": "","raison_signature": "Signed by John Doe"\n'+
                            '} ],"membre": {"prenom": "tstFirstName","nom": "tstLastName", "email": "tst@email.com", "telephone": "0102030405"\n'+
                            '},"configurations": {"utiliser_template": false,"identifiant_template": "xxxx","template_sms": "Test sms template overriding" }}';
            SignatureElectronique_WSI signature = (SignatureElectronique_WSI) JSON.deserialize(jsonS,SignatureElectronique_WSI.class );
            Test.setMock(HttpCalloutMock.class, mock);
            SignatureElectronique_WSO signatureResponse   = SignatureElectronique_SVE.creerProcedureSignatureElectronique(signature);
            System.debug('+++++++++++ signatureResponse test  '+signatureResponse);
            System.assertEquals('Erreur', signatureResponse.status, 'pass');
            System.assertEquals(401, signatureResponse.statusCode , '## pass ## ');
            Test.stopTest();
        }

        @isTest
        static void testCreerProcedureSignatureElectroniqueKO ()
        {
       
            String body = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
                          ' "token_type": "Bearer", "expires_in": 3600  }';

            String body2 = '{"status_signature": "active","identifiant_signature": null,"url_signature": null,"erreurs": [ {\n'+
                            '"identifiant_erreur": "ERR_01","libelle_erreur": "ERROR N°001 DESCRIPTION","erreur_date_time": "2021-03-03T12:04:07+01:00" }],\n'+
                            '"fault": {"code": "404", "type": "Status report", "message": "Not Found", "description": "The requested resource (/signature/1.0.0/init/full) is not available."}}';
           
          
            Test.startTest();
            WSO2VSP_MCK mock = new WSO2VSP_MCK(200,400,'OK', 'KO', body, body2);
            SignatureElectronique_WSI.ProcedureWSI procedure = new  SignatureElectronique_WSI.ProcedureWSI();
            procedure.nom_procedure ='name';
            procedure.description_procedure ='signature description';
            procedure.activer_procedure = true;
            procedure.archiver_procedure = false;

            SignatureElectronique_WSI.FichiersWSI fichier = new SignatureElectronique_WSI.FichiersWSI() ;
            fichier.nom_fichier ='namefichier';
            fichier.contenu_fichier = 'contenu';
            fichier.numero_page = 1;
            fichier.position_signature ='xx:xx';
            fichier.mention_signature =' mention';
            fichier.mention_signature_2 = 'signature 2';
            fichier.raison_signature = 'raison signature';
            SignatureElectronique_WSI.FichiersWSI [] fichiers = new List<SignatureElectronique_WSI.FichiersWSI>{fichier};

            SignatureElectronique_WSI.CongigurationWSI conf  = new SignatureElectronique_WSI.CongigurationWSI();
            //conf.mode_sms = true;
            conf.utiliser_template = false;
            conf.identifiant_template ='';
            conf.template_sms ='sms';

            SignatureElectronique_WSI.MembersWSI membre = new SignatureElectronique_WSI.MembersWSI();
            membre.email ='test@gmail.com';
            membre.nom ='test';
            membre.telephone ='0213364';
            membre.prenom = 'testLats';

            SignatureElectronique_WSI signature = new SignatureElectronique_WSI ();
            signature.procedure = procedure;
            signature.fichiers = fichiers;
            signature.membre = membre;
            signature.configurations = conf;
            Test.setMock(HttpCalloutMock.class, mock);
            SignatureElectronique_WSO signatureResponse   = SignatureElectronique_SVE.creerProcedureSignatureElectronique(signature);
            System.debug('++++++ ws ++++ '+ signatureResponse);
            System.assertEquals('Erreur', signatureResponse.status, '+++ pass +++');
            System.assertEquals('ERR_01',signatureResponse.erreurs[0].identifiant_erreur, '+++ pass +++');
            Test.stopTest();
        }
        
        @isTest
        static void testCreerProcedureSignatureElectroniqueKOBadRequest ()
        {
       
            String body = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
                          ' "token_type": "Bearer", "expires_in": 3600  }';
                                          
            String body2 = '{"status_signature": "active","identifiant_signature": null,"url_signature": null,\n'+
            '"html": {"body": {"h1": "504 Gateway Time-out","ele_text": "The server didn\'t respond in time."}}}';

           
            Test.startTest();
            WSO2VSP_MCK mock = new WSO2VSP_MCK(200,400,'OK', 'KO', body, body2);
            SignatureElectronique_WSI.ProcedureWSI procedure = new  SignatureElectronique_WSI.ProcedureWSI();
            procedure.nom_procedure ='name';
            procedure.description_procedure ='signature description';
            procedure.activer_procedure = true;
            procedure.archiver_procedure = false;

            SignatureElectronique_WSI.FichiersWSI fichier = new SignatureElectronique_WSI.FichiersWSI() ;
            fichier.nom_fichier ='namefichier';
            fichier.contenu_fichier = 'contenu';
            fichier.numero_page = 1;
            fichier.position_signature ='xx:xx';
            fichier.mention_signature =' mention';
            fichier.mention_signature_2 = 'signature 2';
            fichier.raison_signature = 'raison signature';
            SignatureElectronique_WSI.FichiersWSI [] fichiers = new List<SignatureElectronique_WSI.FichiersWSI>{fichier};

            SignatureElectronique_WSI.CongigurationWSI conf  = new SignatureElectronique_WSI.CongigurationWSI();
            //conf.mode_sms = true;
            conf.utiliser_template = false;
            conf.identifiant_template ='';
            conf.template_sms ='sms';

            SignatureElectronique_WSI.MembersWSI membre = new SignatureElectronique_WSI.MembersWSI();
            membre.email ='test@gmail.com';
            membre.nom ='test';
            membre.telephone ='0213364';
            membre.prenom = 'testLats';

            SignatureElectronique_WSI signature = new SignatureElectronique_WSI ();
            signature.procedure = procedure;
            signature.fichiers = fichiers;
            signature.membre = membre;
            signature.configurations = conf;
            Test.setMock(HttpCalloutMock.class, mock);
            SignatureElectronique_WSO signatureResponse   = SignatureElectronique_SVE.creerProcedureSignatureElectronique(signature);
            System.debug('++++++ ws ++++ '+ signatureResponse);
            System.assertEquals('Erreur', signatureResponse.status, '+++ pass +++');
            System.assertEquals('504 Gateway Time-out',signatureResponse.html.body.h1 , '+++ pass +++');
            Test.stopTest();
        }
    
   

        @isTest
        static void testCreerProcedureSignatureElectroniqueErreurNullKO ()
        {
            String body = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
                        ' "token_type": "Bearer", "expires_in": 3600  }';

            String body2 = '{"status_signature": "active","identifiant_signature": null,"url_signature": null,\n'+
                            '"fault": {"code": "404", "type": "Status report", "message": "Not Found", "description": "The requested resource (/signature/1.0.0/init/full) is not available."}}';
           
            Test.startTest();
            WSO2VSP_MCK mock = new WSO2VSP_MCK(200,400,'OK', 'KO', body, body2);
            String configurationJSON = '{"utiliser_template": false,"identifiant_template": "xxxx" ,"template_sms": "Test sms template overriding"}';
            SignatureElectronique_WSI.CongigurationWSI conf = (SignatureElectronique_WSI.CongigurationWSI) JSON.deserializeStrict(configurationJSON, SignatureElectronique_WSI.CongigurationWSI.class);

            String fichiersJson = '{ "nom_fichier": "my_signature_document.pdf",\n'+
                                '"contenu_fichier": "JVBERi0xLjUKJb/3ov4KNiAwIG9iago8PCAvTGluZWFy…", "numero_page": 1,\n'+
                                '"position_signature": "300,200,350, 150","mention_signature": "Read and approved",\n'+
                                '"mention_signature_2": "","raison_signature": "Signed by John Doe"}' ; 
            SignatureElectronique_WSI.FichiersWSI fichier = (SignatureElectronique_WSI.FichiersWSI ) JSON.deserializeStrict(fichiersJson, SignatureElectronique_WSI.FichiersWSI.class);
            SignatureElectronique_WSI.FichiersWSI [] fichiers = new List<SignatureElectronique_WSI.FichiersWSI> ();
            fichiers.add(fichier);
            String membreJson = '{"prenom": "tstFirstName","nom": "tstLastName","email": "tst@email.com","telephone": "0102030405" }';
            SignatureElectronique_WSI.MembersWSI membre = (SignatureElectronique_WSI.MembersWSI ) JSON.deserializeStrict(membreJson, SignatureElectronique_WSI.MembersWSI.class);

            String procedureString =  '{"nom_procedure": "name","description_procedure": "signatureDescription",\n'+
                                    '"activer_procedure": true,"archiver_procedure": false}';
            SignatureElectronique_WSI.ProcedureWSI procedure = (SignatureElectronique_WSI.ProcedureWSI ) JSON.deserializeStrict(procedureString, SignatureElectronique_WSI.ProcedureWSI.class);
            SignatureElectronique_WSI signature = new SignatureElectronique_WSI(procedure,fichiers, membre,conf );
            Test.setMock(HttpCalloutMock.class, mock);
            SignatureElectronique_WSO signatureResponse   = SignatureElectronique_SVE.creerProcedureSignatureElectronique(signature);
            System.debug('++++++ ws ++++ '+ signatureResponse);
            System.assertEquals('Erreur', signatureResponse.status , '+++ pass +++');
            System.assertEquals( 'The requested resource (/signature/1.0.0/init/full) is not available.', signatureResponse.fault.description  , '+++ pass +++');
            System.assertEquals(400, signatureResponse.statusCode, '+++ pass +++');
            Test.stopTest();
        }
        @isTest
        static void testCreerProcedureSignatureElectroniqueOmniscriptCall (){
            WSO2VSPDataFactory_TST.buildAccountObject();
            String body2 = '{"status_signature": "active","identifiant_procedure": "id_procedure","url_signature": "https://staging-app.yousign.com/procedure/sign?members=/members/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx","erreurs": []}';
        
            String body = '{"access_token": "f39e2f48504e1c602c57", "scope": "am_application_scope default",\n'+
            ' "token_type": "Bearer", "expires_in": 3600  }';
            Test.startTest();
            Account acc = [SELECT Id, LastName, PersonEmail, FirstName  FROM Account WHERE FirstName = 'testSendEmail'];
            WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200,'OK', 'OK', body, body2);
            String jsonS =  '{"procedure": {"nom_procedure": "name","description_procedure": "signatureDescription",\n'+
                            '"activer_procedure": true,"archiver_procedure": false },"fichiers": [{ "nom_fichier": "my_signature_document.pdf",\n'+
                            '"contenu_fichier": "JVBERi0xLjUKJb/3ov4KNiAwIG9iago8PCAvTGluZWFy…","numero_page": 1,"position_signature": "300,200,350, 150",\n'+
                            '"mention_signature": "Read and approved","mention_signature_2": "","raison_signature": "Signed by John Doe"\n'+
                            '} ],"membre": {"prenom": "tstFirstName","nom": "tstLastName", "email": "tst@email.com", "telephone": "0102030405"\n'+
                            '},"configurations": {"utiliser_template": false,"identifiant_template": "xxxx","template_sms": "Test sms template overriding" }}';
      
            Test.setMock(HttpCalloutMock.class, mock);
            SignatureElectronique_WSO response = SignatureElectronique_SVE.creerProcedureSignatureElectronique(acc.Id, '0122', acc.PersonEmail, '0001', '02332144', 12);
            System.debug('++++++++ response test +++ '+response);
            System.assertEquals('OK', response.status, ' ## pass ##');
            Test.stopTest();
        }
}