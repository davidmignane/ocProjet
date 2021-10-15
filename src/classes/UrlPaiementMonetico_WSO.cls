/**
 * Created by David DIOP on 22.03.2021.
 */

public  class UrlPaiementMonetico_WSO extends APIXMLResponse_WSO{
    public string url_paiement;

    public UrlPaiementMonetico_WSO(){}
    public  UrlPaiementMonetico_WSO (String urlPaiement){
        this.url_paiement = urlPaiement;
    }
}