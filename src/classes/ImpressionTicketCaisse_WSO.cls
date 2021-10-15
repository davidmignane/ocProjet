/**
 * Created by DAVID DIOP on 26.03.2021.
 */

public  class ImpressionTicketCaisse_WSO extends APIXMLResponse_WSO{
    public string code_reponse;
    public string message_reponse;
    public string status_transaction;

    public ImpressionTicketCaisse_WSO(){}
    public  ImpressionTicketCaisse_WSO (String codeReponse,String messageReponse,String statusTransaction){
        this.code_reponse = codeReponse;
        this.message_reponse = messageReponse;
        this.status_transaction = statusTransaction;
    }
}