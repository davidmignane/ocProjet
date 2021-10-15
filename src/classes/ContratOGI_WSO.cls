/**
 * @author David diop (Salesforce)
 * @date 03.03.2021
 * @description classe d'instantiation  de l'objet ContratOGI_WSO, structure de la response ok du Web service de Subscription
 */

public  class ContratOGI_WSO extends APIXMLResponse_WSO {
    public string num_client;
    public string num_contrat;
    public string num_quittance;
    public string rum;
    public Fault fault ;

    public ContratOGI_WSO(){}
    public  ContratOGI_WSO (String numeroClient,String numContrat,String numQuittance,String rum){
        this.num_client = numeroClient;
        this.num_contrat = numContrat;
        this.num_quittance = numQuittance;
        this.rum = rum;
    }

   /* public override Set<String> getTagNamesAsArray() {
        Set<String> tagNamesAsArray = new Set<String>();
        tagNamesAsArray.add('fault');
        return tagNamesAsArray;
   }*/
    public class Fault {
        public String code ;
        public String message;
        public String description ;
        
    }
    
}