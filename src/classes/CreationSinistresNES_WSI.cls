/**
 * @description       : 
 * @author            : David  Diop
 * @group             : 
 * @last modified on  : 10-04-2021
 * @last modified by  : David Mignane Diop
**/
public with sharing class CreationSinistresNES_WSI extends APIRequest_WSI {
    public String id_sinistre_verspieren_sf ;
    public String description ;
    public ContratDTO contrat ;
    public produitSinistreDTO produit_sinistre ;

    /*public CreationSinistresNES_WSI(vlocity_ins__InsuranceClaim__c claimRecord) {
        this.id_sinistre_verspieren_sf = claimRecord.Id;
        this.description = claimRecord.vlocity_ins__Description__c;
        CreationSinistresNES_WSI.adresseDTO adresse= new CreationSinistresNES_WSI.adresseDTO();
        CreationSinistresNES_WSI.offreDTO offre = new CreationSinistresNES_WSI.offreDTO();
        CreationSinistresNES_WSI.clientDTO client= new CreationSinistresNES_WSI.clientDTO();
        CreationSinistresNES_WSI.produitSinistreDTO produitSinistre = new CreationSinistresNES_WSI.produitSinistreDTO();
        CreationSinistresNES_WSI.marqueDTO  marque= new CreationSinistresNES_WSI.marqueDTO();
        CreationSinistresNES_WSI.categorieDTO categorie= new CreationSinistresNES_WSI.categorieDTO();
        CreationSinistresNES_WSI.familleDTO famille = new CreationSinistresNES_WSI.familleDTO();

            produitSinistre.marque = marque;
            produitSinistre.categorie = categorie;
            produitSinistre.famille = famille;
        CreationSinistresNES_WSI.ContratDTO contrat = new CreationSinistresNES_WSI.ContratDTO();
            contrat.offre = offre;
            contrat.client = client;
    }*/
    public CreationSinistresNES_WSI() {
        
    }

    public CreationSinistresNES_WSI createSinistre(vlocity_ins__InsuranceClaim__c claimRecord){
        Claim_QR claimQuery =  new Claim_QR();
        vlocity_ins__ClaimCoverage__c  claimCoverage =  claimQuery.getClaimCoverage(claimRecord.Id);
        /*[
            SELECT Id,vlocity_ins__AssetCoverageId__r.vlocity_ins__Product2Id__r.CarrierContract__r.PolicyConvetionNumber__c
             from vlocity_ins__ClaimCoverage__c 
             WHERE vlocity_ins__ClaimId__c   =: claimRecord.Id 
             LIMIT 1
        ];*/

        CreationSinistresNES_WSI sinistre = new CreationSinistresNES_WSI();
        

        CreationSinistresNES_WSI.adresseDTO adresse= new CreationSinistresNES_WSI.adresseDTO();
        CreationSinistresNES_WSI.offreDTO offre = new CreationSinistresNES_WSI.offreDTO();
        CreationSinistresNES_WSI.clientDTO client = new CreationSinistresNES_WSI.clientDTO();
        CreationSinistresNES_WSI.produitSinistreDTO produitSinistre = new CreationSinistresNES_WSI.produitSinistreDTO();
        CreationSinistresNES_WSI.marqueDTO  marque= new CreationSinistresNES_WSI.marqueDTO();
        CreationSinistresNES_WSI.categorieDTO categorie= new CreationSinistresNES_WSI.categorieDTO();
        CreationSinistresNES_WSI.ContratDTO contrat = new CreationSinistresNES_WSI.ContratDTO();
        //famille
        CreationSinistresNES_WSI.familleDTO famille = new CreationSinistresNES_WSI.familleDTO();
        famille.code = claimRecord.ClaimDeviceFamily__c;
        famille.nom = claimRecord.ClaimDeviceFamily__c;
        //categorie
        categorie.code = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.ProductCategory__c ;
        categorie.nom = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Tech_ProductUnivers__c;
        //marque
        marque.code = claimRecord.ClaimDeviceBrand__c;
        if(claimRecord.ClaimDeviceBrand__c == 'Autre'){
            marque.nom = claimRecord.OtherClaimDeviceBrand__c;
        }else {
            marque.nom = claimRecord.ClaimDeviceBrand__c;
        }
        //produitSinistre
        produitSinistre.code = claimRecord.ClaimDeviceCode__c;
        produitSinistre.nom = claimRecord.ClaimDeviceModel__c;
        produitSinistre.date_achat = string.valueof(claimRecord.ClaimDeviceInvoiceDate__c);
        produitSinistre.prix_achat_net_ttc = claimRecord.ClaimVoucherAmount__c;
        produitSinistre.numero_serie = '';
        produitSinistre.imei = string.valueof(claimRecord.ClaimImei__c);
        produitSinistre.numero_facture  = claimRecord.ClaimDeviceInvoiceNumber__c ;
        produitSinistre.marque = marque;
        produitSinistre.categorie = categorie;
        produitSinistre.famille = famille ;

        //adresse 
        adresse.ligne_1 = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingStreet;
        adresse.ligne_2 = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingStreet;//à revoir
        adresse.ligne_3 = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingStreet;//à revoir
        adresse.ligne_4 = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingStreet;//à revoir
        adresse.ville = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingCity;
        adresse.code_postal = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingPostalCode;
        adresse.pays = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.BillingCountry;
        //client
        client.prenom = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.FirstName ;
        client.nom = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.LastName;
        client.telephone = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.PersonMobilePhone;
        client.email = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Account.PersonEmail;
        client.adresse = adresse;
        //offre
        offre.code = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.Name;
        offre.libelle = claimRecord.vlocity_ins__PrimaryPolicyAssetId__r.ProductName__c ;
        //contrat
        if(claimCoverage != null){
            contrat.numero_contrat_collectif = claimCoverage.Id;
        } else {
            contrat.numero_contrat_collectif = null;
        }
        contrat.plafond_indemnisation = claimRecord.Tech_AcceptedRemainingAmount__c ; //ok
        contrat.offre = offre ;
        contrat.client = client ;

        //sinistre
        sinistre.id_sinistre_verspieren_sf = claimRecord.Id;
        sinistre.description = claimRecord.vlocity_ins__Description__c;
        sinistre.contrat = contrat;
        sinistre.produit_sinistre = produitSinistre;
        return sinistre;
    }
   
    public  class ContratDTO{
        public String numero_contrat_collectif;
        public Decimal plafond_indemnisation;
        public  offreDTO offre;
        public  clientDTO client;
    }

    public class offreDTO{
        public String code;
        public String libelle;
    }
    
    public class clientDTO{
        public  adresseDTO adresse;
        public String prenom;
        public String nom;
        public String telephone;
        public String email;
    }

    public class adresseDTO{
        public String ligne_1;
        public String ligne_2;
        public String ligne_3;
        public String ligne_4;
        public String ville;
        public String code_postal;
        public String pays;
    }

    public class produitSinistreDTO {
        public String code;
        public String nom;
        public String date_achat;
        public Decimal prix_achat_net_ttc;
        public String numero_serie;
        public String imei;
        public  String numero_facture;
        public  marqueDTO marque;
        public  categorieDTO categorie;
        public  familleDTO famille;
    }
    
    public class marqueDTO{
        public String code;
        public String nom;
    }

    public class categorieDTO{
        public String code;
        public String nom;
    }

    public class familleDTO{
        public String code;
        public String nom ;
    }
}