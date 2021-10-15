/**
 * @author Madicke BALDE
 * @description 
 * @date 25/03/2021
 */
public with sharing class ConfirmationContrat_SVE {

    /**
     * @description
     * @param contrat : 
     * @return ConfirmationContrat_WSO
     */
    public static ConfirmationContrat_WSO confirmerContrat (ConfirmationContrat_WSI contrat){
        ConfirmationContrat_WSO confirmationContrat = new ConfirmationContrat_WSO();
        Map<String,Object> responseAuth = WSO2VSP_SVE.getToken();
       
        if( !((Boolean) responseAuth.get('erreur')) )
        {
            confirmationContrat = ConfirmationContrat_OUT.confirmerContrat(contrat, (String) responseAuth.get('token'));
               
        }
        else 
        {   
            ConfirmationContrat_WSO.ErreurWSO erreur = new ConfirmationContrat_WSO.ErreurWSO();
            confirmationContrat.erreurs = new List<ConfirmationContrat_WSO.ErreurWSO>{erreur};
            confirmationContrat.status ='Erreur';
            confirmationContrat.statusCode = 401;
            confirmationContrat.erreurs[0].libelle_court = 'L\' authentification du client a échoué';
        }
       return confirmationContrat;
    }
}