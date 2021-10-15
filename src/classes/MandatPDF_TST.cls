@isTest
public class MandatPDF_TST {

    @isTest static void testGetAccount(){    
       
       Account acc = Account_TDF.getPersonAccount();    
       insert acc;
       
       String iban = ''; 
       String rum = 'RUM09091XX1';
       String contractOGI = 'OGI1989981';
        
       Test.StartTest(); 
       
       PageReference mandatPage = Page.MandatPDF_VFP;     
       mandatPage.getParameters().put('id', String.valueOf(acc.Id));
       mandatPage.getParameters().put('iban', iban);
       mandatPage.getParameters().put('ogicontract', contractOGI);
       mandatPage.getParameters().put('rum', rum);
        
       Test.setCurrentPage(mandatPage);
          
       MandatPDF_CTL controler = new MandatPDF_CTL();         
        
       Account result = controler.getAccount();

       System.assertEquals(result.id, acc.id);
       System.assertEquals(controler.getIban(), iban);
       System.assertEquals(controler.getRum(), rum);
       System.assertEquals(controler.getOgiContract(), contractOGI);
        
   }
    
}