/**
 * @author Madicke BALDE
 * @description structure de données en entrées 
 * @date 08/03/2021
 */
public with sharing class SignatureElectronique_WSI  extends APIRequest_WSI {
    public ProcedureWSI procedure;
    public FichiersWSI [] fichiers;
    public MembersWSI membre;
    public CongigurationWSI configurations;

    public SignatureElectronique_WSI (){
        super();
    }
    
    public SignatureElectronique_WSI (ProcedureWSI procedure,FichiersWSI [] fichiers, MembersWSI membre, CongigurationWSI configurations  ){
       super();
       this.procedure = procedure;
       this.fichiers = fichiers;
       this.membre = membre;
       this.configurations = configurations;
       this.configurations.mode_sms = false;
    }

    public class ProcedureWSI {
        public String nom_procedure;
        public String description_procedure;
        public Boolean activer_procedure;
        public Boolean archiver_procedure;
        

    }

    public class FichiersWSI {
        public String nom_fichier ;
        public String contenu_fichier;
        public Integer numero_page;
        public String position_signature;
        public String mention_signature;
        public String mention_signature_2;
        public String raison_signature;
    }
    public class MembersWSI {
        public String prenom;
        public String nom;
        public String telephone;
        public String email ;
    }

    public class CongigurationWSI {
        public Boolean mode_sms;
        public Boolean utiliser_template;
        public String identifiant_template;
        public String template_sms;
        public String sujet_email;
        public String message_email;
        public String action_envoi_email;
    }
    
}