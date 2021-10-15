/**
  *@author Madicke BALDE
  *@description classe service pour la signature electronique
  *@date  08/03/2021
 */
public with sharing class SignatureElectronique_SVE {

    public static GestionLog_UTL.GestionErreurDTO log = new GestionLog_UTL.GestionErreurDTO() ;
    public static String typeLog='APEX';
    public static String nomFonction;
    public static Datetime dateHeureErreur = Datetime.now();
    public static String nomObjectSalesforce = ' ';
    public static String messageErreur;
    
    /**
      *@description creerProcedureSignatureElectronique () permet de creer la procedure de signature
      *@param signature :   Objet SignatureElectronique_WSI qui correspond aux input attendus par le web service
      *@return Map<String, Object> : 
      *
     */
    public static SignatureElectronique_WSO creerProcedureSignatureElectronique (SignatureElectronique_WSI signature){
       
        SignatureElectronique_WSO  signatureResponse = new SignatureElectronique_WSO();
        Map<String,Object> responseAuth = WSO2VSP_SVE.getToken();
       
        if( !((Boolean) responseAuth.get('erreur')) )
        {
                signatureResponse = SignatureElectronique_OUT.creerSignature(signature, (String) responseAuth.get('token') );
        }
        else 
        {
            SignatureElectronique_WSO.ErreurDTO erreur = new SignatureElectronique_WSO.ErreurDTO();
            signatureResponse.erreurs = new List<SignatureElectronique_WSO.ErreurDTO>{erreur};
            signatureResponse.status ='Erreur';
            signatureResponse.statusCode = 401;
            signatureResponse.erreurs[0].libelle_erreur = 'L\' authentification du client a échoué ';
        }
          
       return signatureResponse;
    }
    
    public static SignatureElectronique_WSO creerProcedureSignatureElectronique(String accountId, String iban, String email, String numContratOgi, String telephone, Integer rum){
        Blob mandaSepa = MandatGeneration_SVE.generateMandatPDF(accountId, iban, String.valueof(rum), numContratOgi);
        List<Account> accounts = getAccountByIds(new Set<Id>{accountId});
        System.debug('acc '+accounts);
        String prenom = (!accounts.isEmpty())?accounts.get(0).FirstName : null;
        String nom = (!accounts.isEmpty())?accounts.get(0).LastName : null;
      
        SignatureElectronique_WSI.CongigurationWSI configurationWSI = new SignatureElectronique_WSI.CongigurationWSI();
        SignatureElectronique_WSI.MembersWSI membersWSI = new SignatureElectronique_WSI.MembersWSI();
        SignatureElectronique_WSI.ProcedureWSI procedureWSI = new SignatureElectronique_WSI.ProcedureWSI();
        SignatureElectronique_WSI.FichiersWSI fichier = new SignatureElectronique_WSI.FichiersWSI();

        procedureWSI.nom_procedure = 'Signature Mandat SEPA';
        procedureWSI.description_procedure = 'Signature éléctronique ';
        procedureWSI.activer_procedure = false;
        procedureWSI.archiver_procedure = false;
        
        configurationWSI.utiliser_template = false;
        configurationWSI.identifiant_template = '';
        configurationWSI.template_sms = System.Label.TemplateSms;
        configurationWSI.sujet_email = System.Label.objetEmail;
        configurationWSI.action_envoi_email = System.Label.actionEnvoiEmail;
        String message_email = System.Label.messageEmail;
        System.debug('+++++++++ message email '+ message_email);
        configurationWSI.message_email = message_email;

        membersWSI.prenom = prenom;
        membersWSI.nom = nom;
        membersWSI.email = email;
        membersWSI.telephone = telephone;

        fichier.nom_fichier = 'Mandat_Sepa.pdf';
        fichier.numero_page = 1;
        fichier.mention_signature = 'Lu(e) et approuvé(e)';
        fichier.mention_signature_2 = '';
        fichier.raison_signature = 'Signé(e) par ' + prenom + ' ' + nom;
        fichier.contenu_fichier = EncodingUtil.base64Encode(mandaSepa);
        fichier.position_signature = '318,269,534,323';

        SignatureElectronique_WSI request = new SignatureElectronique_WSI(procedureWSI, new List<SignatureElectronique_WSI.FichiersWSI> {fichier}, membersWSI, configurationWSI);
        System.debug(' req '+request.membre.prenom);
        SignatureElectronique_WSO reponse = SignatureElectronique_SVE.creerProcedureSignatureElectronique(request);
        return reponse;
    }
    

    public static List<Account> getAccountByIds (Set<Id> idAccounts){
        return [SELECT Id, LastName, FirstName FROM Account WHERE Id IN : idAccounts ];
    }
}