/**
 * @author Madicke BALDE
 * @description  : cette classe correspond à la structure de données reçu du web service WSO (Signature electronique)
 * @date 08/03/2021
 */
public with sharing class SignatureElectronique_WSO extends APIXMLResponse_WSO {
            
        public String status_signature ;
        public String identifiant_procedure;
        public String url_signature;
        public ErreurDTO [] erreurs;
        public Fault fault;
        public Html html;

        public SignatureElectronique_WSO (){
            super();
        }

        public class ErreurDTO {
            public String identifiant_erreur;
            public String libelle_erreur;
            public String erreur_date_time;
            public ErreurDTO (){}
            public ErreurDTO (String identifiant_erreur, String libelle_erreur, String erreur_date_time){
                this.identifiant_erreur = identifiant_erreur;
                this.libelle_erreur = libelle_erreur;
                this.erreur_date_time = erreur_date_time;
            }
        }
        
        /**
            * @description conversion des tags de la reponse xml en array
            * @return Set<String>
            */
        public override Set<String> getTagNamesAsArray() {
            Set<String> tagNamesAsArray = new Set<String>();
            tagNamesAsArray.add('fault');
            return tagNamesAsArray;
        }  

        public class Fault {
            public String code ;
            public String message;
            public String description ;
            public String type;
        }
        public class Html {
            public Body body;
        }
        public class Body {
            public String h1;
            public String ele_text;
        }
}