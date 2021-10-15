public class MandatGeneration_SVE {
    
   /**
     * @description     :   Génration du Mandat PDF en Blob  
     * @author          :   ALAMZABI
     * @date            :   18/03/2021
     * Paramétres: AssetId(Identifiant de l'asset), Iban(Iban Client)
     *             Rum (Numero rum retourné par OGI), ogiContractId (Identifiant du contrat OGI)
     */
    
    public static Blob generateMandatPDF(Id accountId , String iban , String rum , String ogiContractId){
       		
            PageReference pageRef = new PageReference('/apex/MandatPDF_VFP');
       		pageRef.setRedirect(false);
            pageRef.getParameters().put('id', accountId);
        	pageRef.getParameters().put('iban', iban);
        	pageRef.getParameters().put('rum', rum);
        	pageRef.getParameters().put('ogicontract', ogiContractId);
       		
        	Blob PDF;
        	
        	if(Test.isRunningTest()){
				PDF = EncodingUtil.base64Decode('TEST');
			}
        	try{
            	 PDF = pageRef.getContent(); 	   
            }
        	catch(Exception e){
            	
        	}
       		return PDF; 
   	}
    
    
    
}