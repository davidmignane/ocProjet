/**
 * Created by DAVID DIOP on 26.03.2021.
 */

public  class ImpressionTicketCaisse_KO_WSO extends APIXMLResponse_WSO{
        public string code_reponse;
        public string message_reponse;
        public string status_transaction;
        public Fault fault ;

        public ImpressionTicketCaisse_KO_WSO (){}
        public ImpressionTicketCaisse_KO_WSO (String  codeReponse, String messageReponse, String statusTransaction) {
            this.code_reponse = codeReponse;
            this.message_reponse = messageReponse;
            this.status_transaction = statusTransaction;
        }
        public class Fault {
            public String code ;
            public String message;
            public String description ;
            public String type;

        }
    }