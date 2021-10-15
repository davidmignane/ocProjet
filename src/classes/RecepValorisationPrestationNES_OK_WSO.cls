/**
 * @description       : 
 * @author            : David Mignane Diop
 * @group             : 
 * @last modified on  : 10-05-2021
 * @last modified by  : David Mignane Diop
**/
public  class RecepValorisationPrestationNES_OK_WSO {
    //public responseOkDTO[] responseOk;
    public responseDTO[] response;
    /*public RecepValorisationPrestationNES_OK_WSO(responseOkDTO[] okRetour,responseKoDTO[] koRetour) {
        this.responseOk = okRetour;
        this.responseKo = koRetour;
    }*/


    /*public class responseOkDTO{
        public String status;
        public String erreur;
        public String message;
        public String Ext_ClaimId;
        public String Ext_RepairClaimLineItem;
    }*/

    public class responseDTO{
        public String status;
        public String message;
        public erreurDTO erreur;
        public String Ext_ClaimId;
        public String Ext_RepairClaimLineItem;
    }

    public class erreurDTO{
        public String erreur_message;
        public String erreur_description;
    }

    public static responseDTO createResponse(String status,String message, String erreur_message,String  erreur_description,String Ext_ClaimId, String  Ext_RepairClaimLineItem) {
        responseDTO reponse = new responseDTO();
        reponse.status = status;
        reponse.Ext_ClaimId = Ext_ClaimId;
        reponse.Ext_RepairClaimLineItem = Ext_RepairClaimLineItem;
        reponse.message = message;
        if(erreur_message == null){
            reponse.erreur = null;
        } else {
            erreurDTO erreur =  new erreurDTO();
            erreur.erreur_message = erreur_message;
            erreur.erreur_description = erreur_description;
            reponse.erreur = erreur;
        }
        return reponse;
    }
    
}