/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-13-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   07-08-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class VSP_UTL {
    
    /**
     * @description     :   Méthode générique d'envoi d'email
     * @author          :   MMBODJI
     * @date            :   11/03/2021
     * Paramétres: WhatID(Identifiant de l'objet associé au template 'Asset'), TargetObjectID(identifiant du Contact)
     *             templateName (Nom du template), ContentVersionIds (Identifiant des documents à envoyer en PJ)
     */

    public static Void sendEmail(Id whatID, ID targetObjectID, String templateUniqueName, List<String> ContentVersionIds){
        List<EmailTemplate> templates = [select Id from EmailTemplate where developername =: templateUniqueName];
        If(templates.size() != 1){
			throw new VSP_Exception('Probléme lors de la récupération du template');            
        }    
        Id templateId = templates.get(0).id;
        Asset asst = [select id, Name , Ext_OGIContractID__c,account.personContactID,ProductCode from Asset where id =: whatID LIMIT 1];
        String wideAdressEmail;
        if(asst.ProductCode == Label.ProductCodeElectro){
            wideAdressEmail = Label.OrgWideAdresseEmail;
        } else if (asst.ProductCode == Label.ProductCodeMob){
            wideAdressEmail = Label.OrgWideAdresseEmailMobile;
        }else if(Test.isRunningTest()){
            wideAdressEmail = 'test.apex@yopmail.com';
        }
        OrgWideEmailAddress owa = [SELECT Id,Address,DisplayName FROM OrgWideEmailAddress WHERE  Address =: wideAdressEmail LIMIT 1];
        String owaId;
        if(String.isNotBlank(owa.Id)){
            owaId = owa.Id;
        }
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setTargetObjectId(targetObjectID);
        message.setWhatId(whatID);
        message.setTemplateId(templateId);
        message.setSaveAsActivity(true);
        message.setEntityAttachments(ContentVersionIds);
        message.setOrgWideEmailAddressId(owaId);
        Messaging.SingleEmailMessage[] messages = 
            new List<Messaging.SingleEmailMessage> {message};
            System.debug('+++++ message ++'+message);
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('Email envoyé avec succés !');
        } else {
            Throw new VSP_Exception('Echec lors de l\'envoi de l\'email: '
                         + results[0].errors[0].message);
        }
    }

    
    
      public static Void sendEmailBulk  (List<Asset> assets, Map<Id,String> contentVersionsIds,String templateUniqueName){
          
        List<EmailTemplate> templates = [select Id from EmailTemplate where developername =: templateUniqueName];
        If(templates.size() != 1){
			throw new VSP_Exception('Probléme lors de la récupération du template');            
        } 
          
        Id templateId = templates.get(0).id;
          //electrosur@verspieren.com
          //achabanne@verspieren.com
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
        String wideAdressEmail;
        
          OrgWideEmailAddress owaTestClass;
          OrgWideEmailAddress owaElectrosur;
          OrgWideEmailAddress owaElectrosurMobile;
          if(Test.isRunningTest()){
              String AddressTestClass = 'test.apex@yopmail.com';
               owaTestClass = [SELECT Id,Address,DisplayName FROM OrgWideEmailAddress WHERE   Address =: AddressTestClass LIMIT 1];
          } else {
               owaElectrosur = [SELECT Id,Address,DisplayName FROM OrgWideEmailAddress WHERE   Address =: Label.OrgWideAdresseEmail LIMIT 1];
               owaElectrosurMobile = [SELECT Id,Address,DisplayName FROM OrgWideEmailAddress WHERE   Address =: Label.OrgWideAdresseEmailMobile LIMIT 1];
          }
          String owaId;
              /*if(String.isNotBlank(owa.Id)){
                  owaId = owa.Id;
                  System.debug('owaId'+owaId);
              }*/
        for(Asset asst:assets){
            if(asst.ProductCode == Label.ProductCodeElectro){
                if(String.isNotBlank(owaElectrosur.Id)){
                    owaId = owaElectrosur.Id;
                }
            } else if(asst.ProductCode == Label.ProductCodeMob){
                if(String.isNotBlank(owaElectrosurMobile.Id)){
                    owaId = owaElectrosurMobile.Id;
                }
            } else if(Test.isRunningTest()){
                owaId = owaTestClass.Id;
            }
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setTargetObjectId(asst.account.personContactID);
            message.setWhatId(asst.id);
            message.setTemplateId(templateId);
            message.setSaveAsActivity(true);
            message.setOrgWideEmailAddressId(owaId);
            message.setEntityAttachments(new List<String> {contentVersionsIds.get(asst.id)});
          	
            System.debug('+++++ message ++'+message);
          
            messages.add(message);  
              
        }
          
         
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
          for(Messaging.SendEmailResult res :results)
          if (res.success) {
            System.debug('Email envoyé avec succés !');
        } else {
            Throw new VSP_Exception('Echec lors de l\'envoi de l\'email: '
                         + res.errors[0].message);
        }
    }
    
    
    
    
    
    
    
    
}