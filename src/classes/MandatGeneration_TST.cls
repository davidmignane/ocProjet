@istest
public class MandatGeneration_TST {
    
     @isTest static void generateMandatPDF(){    
       
       Account acc = Account_TDF.getPersonAccount();    
       insert acc;
       
       Asset asst = Asset_TDF.getAsset(acc.id,'TestAsset','Enregistré');
       insert asst;
       
         String iban = 'FR14 2004 1010 0505 0001 3M02 606';
         String rum = 'RUMXXXX';
         String ogiContractId = 'OGIC176761';
         
       Test.StartTest(); 
       
       Blob result = MandatGeneration_SVE.generateMandatPDF(asst.id,iban,rum,ogiContractId);  
         
       System.assert(result != null, result);
   } 

}