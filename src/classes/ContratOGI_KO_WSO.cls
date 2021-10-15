/**
 * @author David diop (Salesforce)
 * @date 03.03.2021
 * @description classe d'instantiation  de l'objet ContratOGI_KO_WSO structure de la response ko du Web service de Subscription
 */

public class ContratOGI_KO_WSO extends APIXMLResponse_WSO {
    public string code_message;
    public string libelle_court_erreur;
    public string libelle_long_erreur;
    public string libelle_technique;
    public string type_message;
    public Fault fault ;

    public ContratOGI_KO_WSO (){}
    public ContratOGI_KO_WSO (String  codeMessage, String libelleCourtErreur, String libelleLongErreur, String libelleTechnique,String typeMessage) {
        this.code_message = codeMessage;
        this.libelle_court_erreur = libelleCourtErreur;
        this.libelle_long_erreur = libelleLongErreur;
        this.libelle_technique = libelleTechnique;
        this.type_message = typeMessage;
    }
   
    
    public class Fault {
        public String code ;
        public String message;
        public String description ;
        public String type;

    }
}