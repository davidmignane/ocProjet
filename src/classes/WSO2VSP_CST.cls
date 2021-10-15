/**
 * @File            :   WSO2VSP_CST.cls
 * @description     :   Class dedicated to storing the constants used in the various apex classes and methods of the project
 * @author          :   Madicke BALDE   
 * @date            :   26/02/2021
 */
public  class WSO2VSP_CST {
    //WSO2VSP Utils
    public static final Integer TIMEOUT = 120000; 

    public static final String NAMED_CREDEBTIAL_AUTHENTIFICATION = 'NamedCredentialAuthentification';

    public static final String NAMED_CREDENTIAL_SUBSCRIPTION = 'verspierenSubscriptionNamedCredential';
    
    public static final String NAMEDCREDENTIAL = 'verspierenNamedCredential';

    public static final String NAMED_CREDENTIAL_SIGNATURE = 'SignatureNamedCredential';

    public static final String NAMED_CREDENTIAL_URLPAIEMENT = 'UrlPaiementNamedCredential';

    public static final String NAMED_CREDENTIAL_ImpressionTicket = 'ImpressionTicketCaisseNamedCredential';

    public static final String NAMED_CREDEBTIAL_CONFIRMATION_CONTRAT = 'ConfirmationContratNamedCredential';

    public static final String NAMED_CREDENTIAL_CREATION_SINISTRE = 'CreationSinistreNamedCredential';

    public static final Map<String, String> MAPCLASS_NAME = new Map<String, String>
    {
        NAMED_CREDEBTIAL_AUTHENTIFICATION => 'AuthentificationLog',
        NAMED_CREDENTIAL_SUBSCRIPTION => 'SubscriptionLog',
        NAMED_CREDENTIAL_SIGNATURE    => 'SignatureElectroniqueLog',
        NAMED_CREDEBTIAL_CONFIRMATION_CONTRAT => 'ConfirmationContratLog',
        NAMED_CREDENTIAL_URLPAIEMENT => 'UrlPaiementMoneticoLog'
    };
}