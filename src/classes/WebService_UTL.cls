/**
 * @author Madicke BALDE
 * @description 
 * @date 29/03/2021
 */
public with sharing class WebService_UTL {
   
    /**
     * @descroption  classe wrapper à etendre pour gérer les exceptions
     * @date 29/03/2021
     */
    public virtual class GeneriqueResponse {
        public String status ;
        public ErreurResponse erreur;
        public GeneriqueResponse (){
            this.status = 'OK';
        }
        public GeneriqueResponse (ErreurResponse erreur){
            this.erreur = erreur;
        }
    }
    
    /**
     * @description classe wrapper pour le renvoie des erreurs
     */
    public class ErreurResponse {
        public String erreur_message;
        public String erreur_description;
        public ErreurResponse (String errorMessage, String errorDescription){
            this.erreur_message = errorMessage;
            this.erreur_description = errorDescription;
        }
    }
    
    
}