/**
 * @auhtor Madicke BALDE
 * @description
 * @date 23/03/2021
 */
public  class ConfirmationContrat_WSI extends APIRequest_WSI {

        public String action;
        public String identifiant_procedure ;
        //public String code;
        public String code_societe;
        public String date_creation;
        public String date_signature;
        public String reference_externe;
        public String clef_reference_externe;
        public Integer nombre_tokens;
        public Tokens [] tokens;
        public Integer nombre_fichiers;
        public FichiersWSI [] fichiers ;    

       public ConfirmationContrat_WSI (){
           super();
       }
        public class FichiersWSI {
            public String reference_fichier ;
            public String type_fichier;
        }

        public class Tokens {
            public String token;
        }
}