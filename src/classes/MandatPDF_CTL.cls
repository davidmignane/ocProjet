public class MandatPDF_CTL {
    
    /**
     * @description     :   MandatPDF VisualForce Page Controler
     * @author          :   ALAMZABI
     * @date            :   15/03/2021
     * Paramétres: 
	*/
    
    private final Account account;
    private final String iban;
    private final String ogiContract;
    private final String rum;

    
 
    public MandatPDF_CTL() {
        
        account = [SELECT Id, Name, LastName,FirstName, BillingStreet,BillingPostalCode,BillingCity,
                   BillingCountry FROM Account 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        iban = ApexPages.currentPage().getParameters().get('iban');
        ogiContract = ApexPages.currentPage().getParameters().get('ogicontract');
        rum = ApexPages.currentPage().getParameters().get('rum');
        
    }
 
    public Account getAccount() {
        return account;
    }
    
    public String getIban() {
        return iban;
    }
    
    public String getOgiContract() {
        return ogiContract;
    }
	
    public String getRum() {
        return rum;
    }
}