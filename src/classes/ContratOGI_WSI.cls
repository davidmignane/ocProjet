/**
 * @author David diop (Salesforce)
 * @date 03.03.2021
 * @description classe d'instantiation  de l'objet ContratOGI_WSI
 */
public class ContratOGI_WSI  extends APIRequest_WSI{
    public generalDTO general ;
    public ContratDTO contrat ;
    public ApporteursDTO[] apporteurs;
    public PrimeAnnuelleDTO prime_annuelle ;
    public GarantieProduitDTO  garantie_produit ;
    public DetailGarantiesPrimeAnnuelleDTO[] detail_garanties_prime_annuelle ;
    public DetailGarantiesPrimePeriodeDTO[] detail_garanties_prime_periode ;
    public ContratOGI_WSI (generalDTO general,ContratDTO contrat,ApporteursDTO[] apporteurs,PrimeAnnuelleDTO primeAnnuelle,GarantieProduitDTO garantieProduit,DetailGarantiesPrimeAnnuelleDTO[] detailGarantiesPrimeAnnuelle,DetailGarantiesPrimePeriodeDTO[] detailGarantiePrimePeriode){
        this.general = general;
        this.contrat = contrat;
        this.apporteurs = apporteurs;
        this.prime_annuelle = primeAnnuelle;
        this.garantie_produit = garantieProduit;
        this.detail_garanties_prime_annuelle = detailGarantiesPrimeAnnuelle;
        this.detail_garanties_prime_periode = detailGarantiePrimePeriode;
    }

    public class generalDTO {
        public String code_action;
        public String code_motif;
        public String canal_de_vente;
        public String mode_paiement;
        public String id_contrat_mere;
        public String id_externe_client_001;
        public String id_externe_client_002;
        public String id_externe_contrat_001;
        public String id_externe_contrat_002;
        public DetailSouscriptionDTO  detail_souscription;
    }

    public class DetailSouscriptionDTO{
        public String num_adherent;
        public String raison_sociale;
        public String civilite;
        public String nom;
        public String prenom;
        public String date_naissance;
        public String telephone_domicile;
        public String telephone_mobile;
        public String email;
        public String iban;
        public String bic;
        public String complement_identitie;
        public String voie;
        public String complement_voie;
        public String commune;
        public String code_postal;
        public String bureau_distributeur;
        public String nom_pays;
        public String code_pays;
    }

    public class ContratDTO{
        public String id_contrat_adherent;
        public String date_effet;
        public String date_fin_contrat;
        public String code_fractionnement;
        public String date_anniversaire_jjmm;
    }

    public class ApporteursDTO{
        public Decimal taux_commission_apporteur;
        public String date_fin_retro_commission;
        public String num_apporteur_verspieren;
        public String mode_calcul_commission;
        public String mnt_commission;
    }

    public class PrimeAnnuelleDTO{
        //public Decimal mnt_prime_yc_fg; modif
        //public Decimal mnt_prime_ht; modif
        public Decimal mnt_frais_gestion;
        public Decimal mnt_taxe_attentats;
    }

    public class GarantieProduitDTO{
        public String id_garantie_rattachee;
        public String code_produit_verspieren;
    }

    public class DetailGarantiesPrimeAnnuelleDTO{
        public String code_garantie;
        public Decimal mnt_commission;
        public Decimal mnt_garantie_ht;
        public Decimal taux_taxe;
        public String code_compagnie_verspieren;
        public String num_convention;
        public String ref_convention;
        public Decimal mnt_garantie_ttc;
    }
    public class DetailGarantiesPrimePeriodeDTO{
        public String code_garantie;
        public Decimal mnt_commission;
        public Decimal mnt_garantie_ht;
        public Decimal taux_taxe;
        public String code_compagnie_verspieren;
        public String num_convention;
        public String ref_convention;
        public Decimal mnt_garantie_ttc;
    }
    /*public override Map<String, String> getParameters() {
        Map<String, String> parameters = new Map<String, String>();
        parameters.put('action', 'invoke');
        return parameters;
    }*/
}