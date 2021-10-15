public with sharing class SignatureTesting {
   public static void testCall (){
             // testSignature
             StaticResource sr = [SELECT Id, body, NamespacePrefix,SystemModstamp FROM StaticResource WHERE Name = 'testSignature' LIMIT 1];
             String pdf = System.EncodingUtil.convertToHex(sr.Body);
             //System.debug('++++ body '+ pdf);
            SignatureElectronique_WSI.ProcedureWSI procedure = new SignatureElectronique_WSI.ProcedureWSI(); 

            procedure.nom_procedure = 'name';
            procedure.description_procedure= 'signatureDescription';
            procedure.activer_procedure = false;
            procedure.archiver_procedure = false;

            SignatureElectronique_WSI.FichiersWSI fichier = new SignatureElectronique_WSI.FichiersWSI();
            fichier.nom_fichier = 'my_signature_document.pdf';
             fichier.contenu_fichier = pdf;
            fichier.numero_page = 1;
            fichier.position_signature ='412,784,511,823';
            fichier.mention_signature ='Read and approved';
            fichier.mention_signature_2 = '';
            fichier.raison_signature = 'Signed by John Doe';
            SignatureElectronique_WSI.FichiersWSI [] fichiers =  new List<SignatureElectronique_WSI.FichiersWSI>{fichier};

            SignatureElectronique_WSI.MembersWSI membre = new SignatureElectronique_WSI.MembersWSI();
            membre.prenom = 'tstFirstName';
            membre.nom = 'tstLastName';
            membre.telephone = 'mohametso@gmail.com';
            membre.email = '0751171412';
            //System.debug('++++++++ wso +++'+t);

            SignatureElectronique_WSI.CongigurationWSI configuration = new SignatureElectronique_WSI.CongigurationWSI();
            configuration.utiliser_template = false;
            configuration.identifiant_template = '';
            configuration.template_sms = '';
            configuration.sujet_email ='Hey! You are invited to sign !';
            configuration.message_email ='Hello <tag data-tag-type=\"string\" data-tag-name=\"recipient.firstname\">\n'+
                                    '</tag> <tag data-tag-type=\"string\" data-tag-name=\"recipient.lastname\"></tag>,\n'+
                                    '<br><br> You have ben invited to sign a document, please click on the following button to read it: \n'+
                                    '<tag data-tag-type=\"button\" data-tag-name=\"url\" data-tag-title=\"Access to documents\">Access to\n'+
                                    ' documents</tag>';
            System.debug('++++++++   message  '+configuration.message_email);
            SignatureElectronique_WSI req = new SignatureElectronique_WSI(procedure, fichiers, membre, configuration);
            SignatureElectronique_WSO t = SignatureElectronique_SVE.creerProcedureSignatureElectronique(req);
            System.debug('++++++++   t ');

   }
}