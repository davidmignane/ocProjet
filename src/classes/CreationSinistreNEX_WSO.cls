/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 09-15-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class CreationSinistreNEX_WSO extends APIXMLResponse_WSO {
    public string id_partenaire;
    public string id_sinistre_partenaire;
    
    public CreationSinistreNEX_WSO(){}
    public  CreationSinistreNEX_WSO (String idPartenaire,String idSinistrePartenaire){
        this.id_partenaire = idPartenaire;
        this.id_sinistre_partenaire = idSinistrePartenaire;
    }

}