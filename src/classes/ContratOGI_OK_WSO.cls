/**
 * Created by DAVID DIOP on 15.04.2021.
 */

public with sharing class ContratOGI_OK_WSO extends APIXMLResponse_WSO{
    public string num_client;
    public string num_contrat;
    public string num_quittance;
    public string rum;
    public string code_message;
    public string libelle_court_erreur;
    public string libelle_long_erreur;
    public string libelle_technique;
    public string type_message;
    public Fault fault;

    public ContratOGI_OK_WSO(){
        super();
    }


    public class Fault {
        public String code ;
        public String message;
        public String description ;
    }

}