/**
 * @author David diop (Salesforce)
 * @date 26.02.2021
 * @description classe de service de gestion des log liée  au retour d'un flux synchrone sortant de salesforce, d'une erreur trappée dans try/catch d'une classe Apex et omniscript
 */

public with sharing class GestionLog_UTL {
    /***
     * @description Methodes de service de gestion des log liée à l'instantiation de l'objet GestionErreurs__c et de faire l'enregistrement
     * @param gestionErreurDTO
     * @return Object GestionErreurs__c
     * @exception aucune
     */
    public static String creerLog(gestionErreurDTO gestionLogRecordDTO) {
        GestionErreurs__c logErrorRecord = instancierGestionLog(gestionLogRecordDTO);
        GestionErreursEvent__e gestionErreursEvent = instancierGestionErreurEvent(gestionLogRecordDTO);
        Database.SaveResult results = EventBus.publish(gestionErreursEvent);
        if (results.isSuccess()) {
            System.debug('Successfully published event.' + results);
        } else {
            String errorMessage;
            for (Database.Error err : results.getErrors()) {
                errorMessage = err.getStatusCode() + ' - ' + err.getMessage();
                System.debug('error event ' + errorMessage);
            }
            /*String fluxJson = JSON.serializePretty(gestionErreursEvent);
            logErrorRecord.MessageErreur__c = errorMessage;
            logErrorRecord.Name = 'Platform Event';
            logErrorRecord.NomObjetSalesforce__c = 'GestionErreurs';
            logErrorRecord.StatutDuFlux__c = '';
            logErrorRecord.FonctionName__c = 'GestionErreursEvent_TRG';
            logErrorRecord.CodeErreurFlux__c = '';
            logErrorRecord.TableRecordId__c = '';
            logErrorRecord.FluxJSONSOAPEnvoye__c = fluxJson;
            //insert logErrorRecord;
            */
        }
        //System.debug('logErrorRecord.Id' + logErrorRecord);
        return '';
    }

    public static String creerLogwithResponse(GestionErreurDTOreponse gestionLogRecordDTOTest) {
        GestionErreursEvent__e gestionErreursEvent = instancierGestionErreurEventtest(gestionLogRecordDTOTest);
        System.debug('gestionErreursEvent. creerLogwithResponse' + gestionErreursEvent);
        Database.SaveResult results = EventBus.publish(gestionErreursEvent);
        if (results.isSuccess()) {
            System.debug('Successfully published event. creerLogwithResponse' + results);
        } else {
            String errorMessage;
            for (Database.Error err : results.getErrors()) {
                errorMessage = err.getStatusCode() + ' - ' + err.getMessage();
                System.debug('error event ' + errorMessage);
            }
        }
        return '';
    }
    /***
        * @description Methodes de service de gestion des log liée à l'instantiation de l'objet GestionErreurs__c et de faire l'enregistrement
        * @param les paramtres liées à  la creation du log
        * @return Object GestionErreurs__c
        * @exception aucune
    */
    public static String creerLog(String name, String fonctionName, Datetime dateHeureErreur, String nomObjectSalesforce, String codeErreurFlux, String messageErreur, String fluxJsonSoapEnvoye, String statutDuFlux, String tableRecordId) {
        gestionErreurDTO gestionLogRecordDTO = new GestionErreurDTO(
                name, fonctionName, dateHeureErreur, nomObjectSalesforce, codeErreurFlux, messageErreur, fluxJsonSoapEnvoye, statutDuFlux, tableRecordId
        );
        System.debug('test creerLog');
        creerLog(gestionLogRecordDTO);
        return '';
    }

    public static String creerLogReponse(String name, String fonctionName, Datetime dateHeureErreur, String nomObjectSalesforce, String codeErreurFlux, String messageErreur, String fluxJsonSoapEnvoye, String statutDuFlux, String tableRecordId,String reponse) {
        GestionErreurDTOreponse gestionLogRecordDTO = new GestionErreurDTOreponse(
                name, fonctionName, dateHeureErreur, nomObjectSalesforce, codeErreurFlux, messageErreur, fluxJsonSoapEnvoye, statutDuFlux, tableRecordId,reponse
        );
        System.debug('test creerLog');
        creerLogwithResponse(gestionLogRecordDTO);
        return '';
    }
    /***
        * @description Methodes de service de gestion des log liée à l'instantiation de l'objet GestionErreurs__c
        * @param gestionErreurDTO
        * @return Object GestionErreurs__c
        * @exception aucune
    */
    public static GestionErreurs__c instancierGestionLog(gestionErreurDTO gestionLogRecord) {
        System.debug('gestionErreursInstancier.reponseJson__c222');
        GestionErreurs__c gestionErreursInstancier = new GestionErreurs__c();
        gestionErreursInstancier.Name = gestionLogRecord.name;
        gestionErreursInstancier.FonctionName__c = gestionLogRecord.fonctionName;
        gestionErreursInstancier.DateHeureErreur__c = gestionLogRecord.dateHeureErreur;
        gestionErreursInstancier.NomObjetSalesforce__c = String.isNotBlank(gestionLogRecord.nomObjectSalesforce) ? gestionLogRecord.nomObjectSalesforce : null;
        gestionErreursInstancier.CodeErreurFlux__c = String.isNotBlank(gestionLogRecord.codeErreurFlux) ? gestionLogRecord.codeErreurFlux : null;
        gestionErreursInstancier.MessageErreur__c = String.isNotBlank(gestionLogRecord.messageErreur) ? gestionLogRecord.messageErreur : null;
        gestionErreursInstancier.StatutDuFlux__c = String.isNotBlank(gestionLogRecord.statutDuFlux) ? gestionLogRecord.statutDuFlux : null;
        gestionErreursInstancier.FluxJSONSOAPEnvoye__c = String.isNotBlank(gestionLogRecord.fluxJsonSoapEnvoye) ? gestionLogRecord.fluxJsonSoapEnvoye : null;
        gestionErreursInstancier.TableRecordId__c = String.isNotBlank(gestionLogRecord.tableRecordId) ? gestionLogRecord.tableRecordId : null;
       
        return gestionErreursInstancier;

    }

    public static GestionErreurs__c instancierGestionLogReponse(GestionErreurDTOreponse gestionLogRecord) {
        GestionErreurs__c gestionErreursInstancier = new GestionErreurs__c();
        gestionErreursInstancier.Name = gestionLogRecord.name;
        gestionErreursInstancier.FonctionName__c = gestionLogRecord.fonctionName;
        gestionErreursInstancier.DateHeureErreur__c = gestionLogRecord.dateHeureErreur;
        gestionErreursInstancier.NomObjetSalesforce__c = String.isNotBlank(gestionLogRecord.nomObjectSalesforce) ? gestionLogRecord.nomObjectSalesforce : null;
        gestionErreursInstancier.CodeErreurFlux__c = String.isNotBlank(gestionLogRecord.codeErreurFlux) ? gestionLogRecord.codeErreurFlux : null;
        gestionErreursInstancier.MessageErreur__c = String.isNotBlank(gestionLogRecord.messageErreur) ? gestionLogRecord.messageErreur : null;
        gestionErreursInstancier.StatutDuFlux__c = String.isNotBlank(gestionLogRecord.statutDuFlux) ? gestionLogRecord.statutDuFlux : null;
        gestionErreursInstancier.FluxJSONSOAPEnvoye__c = String.isNotBlank(gestionLogRecord.fluxJsonSoapEnvoye) ? gestionLogRecord.fluxJsonSoapEnvoye : null;
        gestionErreursInstancier.TableRecordId__c = String.isNotBlank(gestionLogRecord.tableRecordId) ? gestionLogRecord.tableRecordId : null;
        gestionErreursInstancier.reponseJson__c = String.isNotBlank(gestionLogRecord.reponse) ? gestionLogRecord.reponse : null;
        System.debug('gestionErreursInstancier.reponseJson__c'+gestionErreursInstancier.reponseJson__c);
        return gestionErreursInstancier;

    }

    public static GestionErreursEvent__e instancierGestionErreurEvent(gestionErreurDTO gestionLogRecord) {
        GestionErreursEvent__e gestionErreursEventInstancier = new GestionErreursEvent__e();
        gestionErreursEventInstancier.Name__c = gestionLogRecord.name;
        gestionErreursEventInstancier.FonctionName__c = gestionLogRecord.fonctionName;
        gestionErreursEventInstancier.DateHeureErreur__c = gestionLogRecord.dateHeureErreur;
        gestionErreursEventInstancier.NomObjetSalesforce__c = String.isNotBlank(gestionLogRecord.nomObjectSalesforce) ? gestionLogRecord.nomObjectSalesforce : null;
        gestionErreursEventInstancier.CodeErreurFlux__c = String.isNotBlank(gestionLogRecord.codeErreurFlux) ? gestionLogRecord.codeErreurFlux : null;
        gestionErreursEventInstancier.MessageErreur__c = String.isNotBlank(gestionLogRecord.messageErreur) ? gestionLogRecord.messageErreur : null;
        gestionErreursEventInstancier.StatutDuFlux__c = String.isNotBlank(gestionLogRecord.statutDuFlux) ? gestionLogRecord.statutDuFlux : null;
        gestionErreursEventInstancier.FluxJSONSOAPEnvoye__c = String.isNotBlank(gestionLogRecord.fluxJsonSoapEnvoye) ? gestionLogRecord.fluxJsonSoapEnvoye : null;
        gestionErreursEventInstancier.TableRecordId__c = String.isNotBlank(gestionLogRecord.tableRecordId) ? gestionLogRecord.tableRecordId : null;
        return gestionErreursEventInstancier;

    }

    public static GestionErreursEvent__e instancierGestionErreurEventtest(GestionErreurDTOreponse gestionLogRecord) {
        GestionErreursEvent__e gestionErreursEventInstancier = new GestionErreursEvent__e();
        gestionErreursEventInstancier.Name__c = gestionLogRecord.name;
        gestionErreursEventInstancier.FonctionName__c = gestionLogRecord.fonctionName;
        gestionErreursEventInstancier.DateHeureErreur__c = gestionLogRecord.dateHeureErreur;
        gestionErreursEventInstancier.NomObjetSalesforce__c = String.isNotBlank(gestionLogRecord.nomObjectSalesforce) ? gestionLogRecord.nomObjectSalesforce : null;
        gestionErreursEventInstancier.CodeErreurFlux__c = String.isNotBlank(gestionLogRecord.codeErreurFlux) ? gestionLogRecord.codeErreurFlux : null;
        gestionErreursEventInstancier.MessageErreur__c = String.isNotBlank(gestionLogRecord.messageErreur) ? gestionLogRecord.messageErreur : null;
        gestionErreursEventInstancier.StatutDuFlux__c = String.isNotBlank(gestionLogRecord.statutDuFlux) ? gestionLogRecord.statutDuFlux : null;
        gestionErreursEventInstancier.FluxJSONSOAPEnvoye__c = String.isNotBlank(gestionLogRecord.fluxJsonSoapEnvoye) ? gestionLogRecord.fluxJsonSoapEnvoye : null;
        gestionErreursEventInstancier.TableRecordId__c = String.isNotBlank(gestionLogRecord.tableRecordId) ? gestionLogRecord.tableRecordId : null;
        gestionErreursEventInstancier.reponseJson__c = String.isNotBlank(gestionLogRecord.reponse) ? gestionLogRecord.reponse : null;
        System.debug('gestionErreursEventInstancier.reponseJson__c'+gestionErreursEventInstancier.reponseJson__c );
        return gestionErreursEventInstancier;

    }
    /***
     * @description methode wrapper de l'object GestionErreurs__c
     * @param
     * @return
     * @exception
    */
    public class GestionErreurDTO {
        public String name { get; set; }
        public String fonctionName { get; set; }
        public Datetime dateHeureErreur { get; set; }
        public String nomObjectSalesforce { get; set; }
        public String codeErreurFlux { get; set; }
        public String messageErreur { get; set; }
        public String fluxJsonSoapEnvoye { get; set; }
        public String statutDuFlux { get; set; }
        public String tableRecordId { get; set; }
        public GestionErreurDTO() {
        }
        public GestionErreurDTO(String name, String fonctionName, Datetime dateHeureErreur, String nomObjectSalesforce, String codeErreurFlux, String messageErreur, String fluxJsonSoapEnvoye, String stututDuFlux, String tableRecordId) {
            this.name = name;
            this.fonctionName = fonctionName;
            this.dateHeureErreur = dateHeureErreur;
            this.nomObjectSalesforce = nomObjectSalesforce;
            this.codeErreurFlux = codeErreurFlux;
            this.messageErreur = messageErreur;
            this.fluxJsonSoapEnvoye = fluxJsonSoapEnvoye;
            this.statutDuFlux = stututDuFlux;
            this.tableRecordId = tableRecordId;
        }
    }

    public class GestionErreurDTOreponse {
        public String name { get; set; }
        public String fonctionName { get; set; }
        public Datetime dateHeureErreur { get; set; }
        public String nomObjectSalesforce { get; set; }
        public String codeErreurFlux { get; set; }
        public String messageErreur { get; set; }
        public String fluxJsonSoapEnvoye { get; set; }
        public String statutDuFlux { get; set; }
        public String tableRecordId { get; set; }
        public String reponse { get; set; }
        public GestionErreurDTOreponse() {
        }
        public GestionErreurDTOreponse(String name, String fonctionName, Datetime dateHeureErreur, String nomObjectSalesforce, String codeErreurFlux, String messageErreur, String fluxJsonSoapEnvoye, String stututDuFlux, String tableRecordId,String reponse) {
            this.name = name;
            this.fonctionName = fonctionName;
            this.dateHeureErreur = dateHeureErreur;
            this.nomObjectSalesforce = nomObjectSalesforce;
            this.codeErreurFlux = codeErreurFlux;
            this.messageErreur = messageErreur;
            this.fluxJsonSoapEnvoye = fluxJsonSoapEnvoye;
            this.statutDuFlux = stututDuFlux;
            this.tableRecordId = tableRecordId;
            this.reponse = reponse;
        }
    }
}