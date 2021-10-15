/**
 * @description       : 
 * @author            : David Mignane Diop
 * @group             : 
 * @last modified on  : 10-13-2021
 * @last modified by  : David Mignane Diop
**/
@istest
public  class WSO2VSPDataFactory_TST {
    
    public static final String NAMED_CREDENTIAL = 'verspierenNamedCredential';

    
   
    public class BreakFastMenu extends APIXMLResponse_WSO {
        public BreakFastMenuDTO   breakfast_menu;
    }
    public class BreakFastMenuDTO  {
        public FoodDTO [] food;
    }
    public class FoodDTO {
        public String name;
        public String price;
        public String description ;
        public String calories;
    }
    public class SidesDTO {
        public SideDTO [] side;
    }
    public class SideDTO {
        public String name;
        public String price;
    }
    
    /**
     * @description permet de construire des objets de type EmailTemplates
     * @return emailsTemplates : list des EmailTemplates à créer
     */
    @Future
    public static void buildEmailTemplateObject (){
        List<Folder> folder = [SELECT Name, Type, Id, AccessType FROM Folder WHERE   DeveloperName='ElectroDepot_TemplateEmail'];
        System.debug('++++++++ folder '+folder);
        List<BrandTemplate> brTemplate = [SELECT DeveloperName, IsActive , Description, Name, Id FROM BrandTemplate WHERE IsActive = true];
        System.debug('++++++++ brTemplate '+brTemplate);
        List<EmailTemplate> emailsTemplates = new List<EmailTemplate>{
            new EmailTemplate (developername = 'LiensPaie',
                               TemplateType = 'html',
                               FolderId= folder[0].Id,
                               IsActive = true,
                               TemplateStyle='freeForm',
                               Name='Lienpaie',
                               BrandTemplateId= brTemplate[0].Id,
                               Description = 'email temlpate pour les paiement',
                               Body = 'Bonjour Mr {!Asset.Contact} Suite à votre contrat N° XXXXX,merci de finaliser le paiement par carte en cliquant sur ce lien:{!Asset.TechBankURL__c}Cordialement')
        };

        insert emailsTemplates;
    }

    public static vlocity_ins__InsuranceClaim__c buildClaimObject(){
        vlocity_ins__InsuranceClaim__c claimObjects = new vlocity_ins__InsuranceClaim__c();
        claimObjects.vlocity_ins__Description__c = 'description';
        //claimObjects.ClaimDeviceFamily__c ='Téléviseur';
        //claimObjects.ClaimDeviceBrand__c ='THOMSON';
        claimObjects.OtherClaimDeviceBrand__c = 'BRUN';
        //claimObjects.ClaimDeviceModel__c ='TV UHD 4K SAMSUNG UE50NU7025 SAMRT HDR W';
        claimObjects.ClaimDeviceCode__c ='UE50NU7025';
        claimObjects.ClaimDeviceInvoiceDate__c =Date.newInstance(2016, 12, 9);
        claimObjects.ClaimVoucherAmount__c = 399.9;
        claimObjects.ClaimImei__c = 123456789012345.9;
        claimObjects.ClaimDeviceInvoiceNumber__c = 'F123456';
        return claimObjects;
    }

    public static vlocity_ins__ClaimCoverage__c buildClaimCovarageObject(){
        vlocity_ins__ClaimCoverage__c claimCoverageObjects = new vlocity_ins__ClaimCoverage__c();
        
        return claimCoverageObjects;
    }

    public static vlocity_ins__ClaimLineItem__c buildClaimLineObject(){
        vlocity_ins__ClaimLineItem__c claimLineObjects = new vlocity_ins__ClaimLineItem__c();
        
        return claimLineObjects;
    }

    public static void buildAccountObject(){

        Id recordTypePersonAccount = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        List<Account> accountObjects = new List<Account>{
            new Account (LastName = 'account 1', PersonEmail='test@gmail.com', Ext_DistributorCustomerID__c ='1421x', FirstName = 'testSendEmail', RecordTypeId = recordTypePersonAccount)
        };
        upsert accountObjects;
    }

    public static List<Asset> buildAssetObject(){
           Datetime dateSignature = System.now();
           List<Asset> assets = new List<Asset>{
           new Asset (Name = 'testAsset', dateConfirmationSignatureMandatYousign__c = dateSignature, Ext_OGIContractID__c='226ec37', TechBankURL__c ='http://test.com/xxxxxxxxx', Tech_identifiantProcedureYousign__c='/procedure/123456',SignConf__c = true, identifiantFichierMandatSignYousign__c = '' ),
           new Asset (Name = 'testAsset2',dateConfirmationSignatureMandatYousign__c = dateSignature, TechBankURL__c ='http://test.com/xxxxxxxxx', Tech_identifiantProcedureYousign__c='/procedure/012365',SignConf__c = true, identifiantFichierMandatSignYousign__c = '' )
        };
        return assets;
    }

    public static User addnewUser(String alias, String email, String lastName, String username, String nomProfile){
        Profile p = [SELECT Id FROM profile WHERE name=: nomProfile ];
        User user = new User(Alias= alias, TimeZoneSidKey='Europe/Paris', LocaleSidKey='fr_FR_EURO', EmailEncodingKey='ISO-8859-1', LanguageLocaleKey='fr', LastName = lastName, Username = username, Email = email, ProfileId = p.Id);
        insert user;
        return user;
    }

    public static BypassValidationRule__c  addByPassValidationRule(){
        BypassValidationRule__c  bypassValidation = new BypassValidationRule__c(Asset__c = false, Account__c = false, Contact__c = false, Opportunity__c = false, Quote__c = false, vlocity_ins_Statement_c__c=false);
        insert bypassValidation;
        return bypassValidation;
    }
}