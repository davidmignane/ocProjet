@isTest
public class CertificatAdhesionPDF_TST {

    @isTest static void testGetAsset(){    
       
       Account acc = Account_TDF.getPersonAccount();    
       insert acc;
       
       Asset asst = Asset_TDF.getAsset(acc.id,'TestAsset','Enregistré');
       insert asst;
        
       Test.StartTest(); 
       
       PageReference certificatPage = Page.CertificatAdhesionPDF_VFP;     
       certificatPage.getParameters().put('Id', String.valueOf(asst.Id));
       Test.setCurrentPage(certificatPage);
          
       CertificatAdhesionPDF_CTL controler = new CertificatAdhesionPDF_CTL();         
        
       Asset result = controler.getAsset();

       System.assertEquals(result.id, asst.id);
   } 
    
    
}