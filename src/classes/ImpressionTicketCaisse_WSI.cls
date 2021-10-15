/**
 * Created by DAVID DIOP on 26.03.2021.
 */

public class ImpressionTicketCaisse_WSI extends APIRequest_WSI{
        public String identifiant_requete ;
        public String pays_magasin ;
        public String identifiant_partenaire;
        public String identifiant_transaction_partenaire;
        public String identifiant_magasin ;
        public String date_transaction_magasin ;
        public String identifiant_transaction_magasin ;
        public String statut_transaction ;

        public ImpressionTicketCaisse_WSI (String identifiant,String paysMagasin,String identiantPartenaire,String identifantTransactionPartenaire,String identiantMagasin,String dateTransactionMagasin,String identifantTransactionMagasin,String statusTransaction){
            this.identifiant_requete = identifiant;
            this.pays_magasin = paysMagasin;
            this.identifiant_partenaire = identiantPartenaire;
            this.identifiant_transaction_partenaire = identifantTransactionPartenaire;
            this.identifiant_magasin = identiantMagasin;
            this.date_transaction_magasin = dateTransactionMagasin;
            this.identifiant_transaction_magasin = identifantTransactionMagasin;
            this.statut_transaction = statusTransaction;
        }
}