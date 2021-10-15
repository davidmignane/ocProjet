@istest
public with sharing class ConfirmationContrat_WSO_TST {
    
    @istest
    static void testConfirmationContrat (){
        ConfirmationContrat_WSO wso = new ConfirmationContrat_WSO();
        ConfirmationContrat_WSO.Fault f = new ConfirmationContrat_WSO.Fault();
        f.code = '021';
        f.description = 'dscription ';
        f.type = 'type';
        f.message = 'test message';
        wso.fault = f;
        ConfirmationContrat_WSO.ErreurWSO erreur = new ConfirmationContrat_WSO.ErreurWSO();
        erreur.code_retour = '0212';
        erreur.libelle_court = 'libbele ';
        erreur.libelle_long = 'long ';
        erreur.libelle_tech = 'test';
        erreur.type = 'type';

        wso.code_retour ='888';
        wso.date_debut_prelement ='2020-03-25';
        wso.date_fin_prelevement = '26-03-2021';
        wso.status = 'OK';
        wso.message_retour ='Erreur de mise ';
        wso.erreurs = new List<ConfirmationContrat_WSO.ErreurWSO>{erreur};
    }

}