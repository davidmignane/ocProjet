trigger GestionErreursEvent_TRG on GestionErreursEvent__e (after insert) {
    GestionLog_UTL.GestionErreurDTO gestionErreurDTO;
    List<GestionErreurs__c> gestionErreursList = new List<GestionErreurs__c>() ;
    for (GestionErreursEvent__e event : Trigger.new) {
        gestionErreurDTO = new GestionLog_UTL.GestionErreurDTO(event.Name__c, event.FonctionName__c, event.DateHeureErreur__c, event.NomObjetSalesforce__c, event.CodeErreurFlux__c, event.MessageErreur__c, event.FluxJSONSOAPEnvoye__c, event.StatutDuFlux__c, event.TableRecordId__c);
        gestionErreursList.add(GestionLog_UTL.instancierGestionLog(gestionErreurDTO));
    }
    insert gestionErreursList;
}