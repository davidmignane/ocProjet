/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 09-17-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public  class CreationSinitresNEX_KO_WSO extends APIXMLResponse_WSO {
    public string type_message;
    public string code_message;
    public string libelle_court;
    public string libelle_long;
    public string libelle_technique;
    public Fault fault ;
    
    public CreationSinitresNEX_KO_WSO(){}

    public CreationSinitresNEX_KO_WSO (String  codeMessage, String libelleCourtErreur, String libelleLongErreur, String libelleTechnique,String typeMessage) {
        this.code_message = codeMessage;
        this.libelle_court = libelleCourtErreur;
        this.libelle_long = libelleLongErreur;
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