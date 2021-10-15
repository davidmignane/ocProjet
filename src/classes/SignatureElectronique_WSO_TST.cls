/**
 * @author Madicke BALDE
 * @description classe de test pour la classe SignatureElectronique_WSO
 * @date 09/03/2021
 */
@istest
public  class SignatureElectronique_WSO_TST {
    
    @istest
    static void testGetTagNamesAsArray(){
        Test.startTest();
         SignatureElectronique_WSO.ErreurDTO erreur = new SignatureElectronique_WSO.ErreurDTO ('021E','REDS3','01/04/2021 11:25:59');
         
        SignatureElectronique_WSO.Fault fault = new SignatureElectronique_WSO.Fault();
        fault.code = 'code1';
        fault.description = 'description';
        fault.message = 'message';
        fault.type = 'type';
        SignatureElectronique_WSO wso = new SignatureElectronique_WSO();
        wso.fault = fault;
        wso.erreurs = new List<SignatureElectronique_WSO.ErreurDTO>{erreur};

        Set<String> tags = wso.getTagNamesAsArray();
        System.debug(' +++++++ tags ++ '+tags);
        System.assertNotEquals( 0, tags.size(), ' ## pass ##');

        Test.stopTest();
    }
    
   
}