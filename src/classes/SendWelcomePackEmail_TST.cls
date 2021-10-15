@istest
public class SendWelcomePackEmail_TST {
    
    @isTest static void sendWPEmailTST(){    
        
       Account acc = Account_TDF.getPersonAccount();    
       insert acc;
       
       Asset asst = Asset_TDF.getAsset(acc.id,'TestAsset','00');
       insert asst;
        
       Test.StartTest(); 
        
        SendWelcomePackEmail_ITF.sendWPEmail(new List<Id>{asst.id});
        List<ContentDocumentLink> result = [select id, LinkedEntityId,ContentDocumentId from ContentDocumentLink where LinkedEntityId=:asst.id];
        System.assert(result.size()>0);
        Test.StopTest();
    
    }

}