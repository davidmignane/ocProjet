/**
 * Created by DAVID DIOP on 22.03.2021.
 */

public  class UrlPaiementMonetico_WSI extends APIRequest_WSI{
    public String reference ;
    public String texte_libre ;
    public String date_commande;
    public Decimal montant ;
    public contexteCommandeDTO contexte_commande ;

    public UrlPaiementMonetico_WSI (String reference,String texteLibre,String dateCommande,Double montant,contexteCommandeDTO contexteCommande){
        this.reference = reference;
        this.texte_libre = texteLibre;
        this.date_commande = dateCommande;
        this.montant = montant;
        this.contexte_commande = contexteCommande;
    }
    public class contexteCommandeDTO {
        public addressFacturationDTO  adresse_facturation;
    }
    public virtual class addressFacturationDTO {
        public String  civilite;
        public String  nom;
        public String  prenom;
        public String  adresse_ligne_1;
        /*public String  adresse_ligne_2;
        public String  adresse_ligne_3;*/
        public String  ville;
        public String  code_postal;
        public String  pays;
        public String  email;
    }

    public class addressFacturationTwoDTO extends addressFacturationDTO{
        /*public String  civilite;
        public String  nom;
        public String  prenom;
        public String  adresse_ligne_1;
        public String  ville;
        public String  code_postal;
        public String  pays;
        public String  email;*/
        public String  adresse_ligne_2;
        public String  adresse_ligne_3;

    }
}