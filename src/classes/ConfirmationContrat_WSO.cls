/**
 * @author Madicke BALDE
 * @description 
 */
public with sharing class ConfirmationContrat_WSO extends APIXMLResponse_WSO {
   
    public String code_retour ;
    public String message_retour ;
    public String date_debut_prelement;
    public String date_fin_prelevement;
    public ErreurWSO [] erreurs;
    public Fault fault;
   
    public ConfirmationContrat_WSO(){
        super();
    }

    public class ErreurWSO {
        public String code_retour;
        public String libelle_court;
        public String libelle_long;
        public String libelle_tech;
        public String type;
    }
    public class Fault {
        public String code;
        public String type;
        public String message;
        public String description;
    }
}