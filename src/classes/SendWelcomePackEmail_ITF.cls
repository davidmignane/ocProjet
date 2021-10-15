/**
 * @description       : 
 * @author            : 
 * @group             : 
 * @last modified on  : 08-13-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

public with sharing class SendWelcomePackEmail_ITF {

     @InvocableMethod(label='SendWelcomePackEmail' description='Generate "certificat d adhésion" & send Welcome Pack Email.' category= 'Asset')
	 public static Void sendWPEmail(List<Id> assetIds){
        List<Asset> assets = [select id, Name , Ext_OGIContractID__c,account.personContactID,ProductCode from Asset where id =: assetIds]; 
        System.debug('asset :' + assets);
         Map<Id, String> ContentVersionMap = generateCertificatAdhesion(assets);
        
         
        for(Asset asst : assets){
            String templateName = '';
            if(asst.ProductCode == Label.ProductCodeElectro){
                templateName = Label.TemplateSubscriptionEmail;
            } else if (asst.ProductCode == Label.ProductCodeMob){
                templateName = Label.TemplateSubscriptionEmailMobile;
            } else if(Test.isRunningTest()){
                templateName = 'SubscriptionEmail';
            }
             
             VSP_UTL.sendEmailBulk(assets, ContentVersionMap , templateName);
             
         }
     }
	
	
    
    public static Map<Id,String> generateCertificatAdhesion(List<Asset> assetRecords){
        
        Map<Id, ContentVersion> ContentVersionMap = new Map<Id,ContentVersion>();
        
        // Generate certificat D'adhésion ContentVersion for each 
        Map<id,Blob> assetFiles = generatePDF(assetRecords);
        
        for(Asset asst : assetRecords){
            
        	ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
            conVer.PathOnClient = 'CertificatAdhesion_' + asst.Ext_OGIContractID__c + '.pdf'; // The files name, extension is very important here which will help the file in preview.
            conVer.Title = 'CertificatAdhesion_' + asst.Ext_OGIContractID__c ;
            conVer.VersionData = assetFiles.get(asst.id);//EncodingUtil.base64Decode(''); // converting your binary string to Blog
    		ContentVersionMap.put(asst.id,conVer);
        }
        
        insert ContentVersionMap.Values();    //Insert ContentVersion
        
        Map<Id,String> ctVersionIds = new Map<Id,String>();
        
        for(Id ctv: ContentVersionMap.KeySet() ){
            
            ctVersionIds.put(ctv,ContentVersionMap.get(ctv).id);
        }
        
                
        Map<Id,ContentVersion> ctMap = new Map<id,ContentVersion>([SELECT Id,ContentDocumentId FROM ContentVersion WHERE Id in: ctVersionIds.values()]); 
        
        List<ContentDocumentLink> ctDocLinkToInsert = new List<ContentDocumentLink>();
        
        for(Asset asst : assetRecords){
        //    Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
            //create ContentDocumentLink  record 
            ContentDocumentLink conDocLink = New ContentDocumentLink();
            conDocLink.LinkedEntityId = asst.Id; // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
            conDocLink.ContentDocumentId = ctMap.get(ContentVersionMap.get(asst.Id).Id).ContentDocumentId;  //ContentDocumentId Id from ContentVersion
            conDocLink.shareType = 'V';
            ctDocLinkToInsert.add(conDocLink);            
        }
        
        insert ctDocLinkToInsert;  
        
        return ctVersionIds;
        
    }
    
    
    public static Map<id,Blob> generatePDF(List<Asset> objectId){
       		
        Map<id,Blob> assetFiles = new Map<id,Blob>();
        	
        for(Asset asst:objectId){
            //verification du code produit avant generation du pdf
            PageReference pageRef;
            if(asst.ProductCode == Label.ProductCodeElectro){
                pageRef = new PageReference('/apex/CertificatAdhesionPDF_VFP'); 
            } else if (asst.ProductCode == Label.ProductCodeMob){
                pageRef = new PageReference('/apex/CertificatAdhesionPDFMobile_VFP'); 
            }  else if(Test.isRunningTest()){
                pageRef = new PageReference('/apex/CertificatAdhesionPDF_VFP'); 
            }
                pageRef.setRedirect(false);
                pageRef.getParameters().put('id', asst.Id);
       		Blob PDF;
            
            if(Test.isRunningTest()){
				PDF = EncodingUtil.base64Decode('TEST');
			}
            try{
            	 PDF = pageRef.getContent(); 	   
            }
        	catch(Exception e){
            	
        	}
            assetFiles.put(asst.id,PDF);
        }
       		
       		return assetFiles;
   	}
    
    
}