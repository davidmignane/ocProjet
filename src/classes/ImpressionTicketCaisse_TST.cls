/**
* @author David diop (Salesforce)
 * @date 29.03.2021
 * @description classe de test pour ImpressionTicketCaisse_SVE lié à l'impression ticket caisse
 */
@isTest
public  class ImpressionTicketCaisse_TST {
    @isTest
    static void impressionTicketCaisseKo(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 401, "status":"Erreur","code_reponse":null,"message_reponse":null,"status_transaction":null}';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401, 'OK','Erreur', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);

        ImpressionTicketCaisse_WSI impressionTicket = new ImpressionTicketCaisse_WSI ('ID_REQUEST','FR','ID_PART','ID_TX_PART','MAG000123','8DECDIG','1603F0001MAG123','OK');
        APIResponse_WSO impressionTicketCaisse =  ImpressionTicketCaisse_SVE.imprimmerTicketCaisse(impressionTicket);
        System.assertEquals(401, impressionTicketCaisse.statusCode , '## pass ## ');


    }
    @isTest
    static void impressionTicketCaisseKo2(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';


        String body2 = '{"statusCode" : 401, "status":"Erreur","code_reponse":null,"message_reponse":null,"status_transaction":null}';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,401, 'OK','Erreur', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);

        ImpressionTicketCaisse_WSI impressionTicket = new ImpressionTicketCaisse_WSI ('ID_REQUEST','FR','ID_PART','ID_TX_PART','MAG000123','8DECDIG','1603F0001MAG123','OK');
        APIResponse_WSO impressionTicketCaisse = ImpressionTicketCaisse_SVE.creerTicketCaisse('ID_REQUEST','FR','ID_PART','ID_TX_PART','MAG000123','8DECDIG','1603F0001MAG123','OK');
        System.assertEquals(401, impressionTicketCaisse.statusCode , '## pass ## ');
    }

    @isTest
    static void impressionTicketCaisseOk(){
        String body1 = '{"access_token": "f39e2f48-5646-31e3", "scope": "am_application_scope default",\n'+
                ' "tokenType": "Bearer", "expires_in": 3600  }';

        String body2 = '{"statusCode" : 200, "status":"Ok","code_reponse":null,"message_reponse":null,"status_transaction":null}';
        WSO2VSP_MCK mock = new WSO2VSP_MCK(200,200, 'OK','Ok', body1, body2);
        Test.setMock(HttpCalloutMock.class, mock);
        ImpressionTicketCaisse_WSI impressionTicket = new ImpressionTicketCaisse_WSI ('1234567890','FR','ELECDEPOT','1234567890090896','MAG000123','2021-03-26','1609F0001MAG123','OK');
        ImpressionTicketCaisse_SVE.imprimmerTicketCaisse(impressionTicket);
    }
}