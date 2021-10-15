/**
 * @author David diop (Salesforce)
 * @date 26.02.2021
 * @description classe de test de gestion des log liée  au retour d'un flux synchrone sortant de salesforce, d'une erreur trappée dans try/catch d'une classe Apex et omniscript
 */
@IsTest
public  class GestionLog_UTL_TST {
    @IsTest
    static  void testCreerLog(){
        GestionLog_UTL.gestionErreurDTO  gestionErreurRecord = new GestionLog_UTL.gestionErreurDTO(
                'FLUX','creation', System.now(),'Account','code','message','flux json','OK','ss4584s5sdsd'
        );
        String recordId = GestionLog_UTL.creerLog(gestionErreurRecord);
        Test.startTest();
        System.assertNotEquals(recordId,null);
        Test.stopTest();
    }
    @IsTest
    static  void testTwoCreerLog(){
        String recordId = GestionLog_UTL.creerLog('FLUX','creation', System.now(),'Account','code','message','flux json','OK','ss4584s5sdsd');
        Test.startTest();
        System.assertNotEquals(recordId,null);
        Test.stopTest();
    }
    @IsTest
    static  void testTwoCreerLogEx(){
        String recordId = GestionLog_UTL.creerLog('','creation', System.now(),'Account','code','message','flux json','OK','ss4584s5sdsd');
        Test.startTest();
        System.assertNotEquals(recordId,null);
        Test.stopTest();
    }
}