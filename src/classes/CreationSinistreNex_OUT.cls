/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 09-21-2021
 * @last modified by  : David Mignane Diop
**/
public with sharing class CreationSinistreNex_OUT {
    public static APIResponse_WSO getSinistre(CreationSinistresNES_WSI Sinistrerequete, String methodType,String accessToken){
        Map<String, Type> mapRespClass = new Map<String, Type>();
        //mapRespClass.put('OK',ContratOGI_WSO.class);
        mapRespClass.put('OK',CreationSinistreNEX_WSO.class);
        //mapRespClass.put('KO',ContratOGI_KO_WSO.class);
        mapRespClass.put('KO',CreationSinitresNEX_KO_WSO.class);
        APIResponse_WSO response= new APIResponse_WSO() ;
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', 'application/json');
        String  authorizationHeader = 'Bearer ' + accessToken;
        System.debug('token test'+accessToken);
        request.setHeader('authorization', authorizationHeader);
        response = (APIResponse_WSO) WSO2VSP_UTL.callApi(WSO2VSP_CST.NAMED_CREDENTIAL_CREATION_SINISTRE, methodType,request, Sinistrerequete, mapRespClass);
        //System.debug('responsetest'+response);
        //String reponse  = getMockResponse('responseSinistre');
        String reponse = getMockResponse('responseSinistre');
        //System.debug('testdebugggg repnse '+reponse);
        //response = (APIResponse_WSO)getMockResponse('responseSinistre');
       APIResponse_WSO res= new APIResponse_WSO();
        res= (APIResponse_WSO) CreationSinistreNEX_WSO.class.newInstance();
        res = (APIResponse_WSO) (JSON.deserialize(reponse, CreationSinistreNEX_WSO.class));
        res.status = 'OK';
        res.statusCode = 200;

        return res;
    }
    public static String getMockResponse( String key )
    { 
        system.debug('---------------------------------------------------------------');
        system.debug('-- - Class Name: ApiUtils2 -- - Method Name: getMockResponse   '); 
        createSinistre__mdt  custMdt = [
            SELECT Id,apiName__c, response__c 
            FROM createSinistre__mdt
            WHERE apiName__c = 'create sinistre'
        ];
        System.debug('custMdt' +custMdt.response__c);
        String body = custMdt.response__c;
        return body;
        /*StaticResource sr = [SELECT Id,NamespacePrefix,SystemModstamp FROM StaticResource WHERE Name = 'MockResponse' LIMIT 1];
        
        system.debug('RISULTATO STATIC RESOURCE ----> '+sr);
        
        if ( sr == null ) return null;
        
        String prefix = sr.NamespacePrefix;
        if( String.isEmpty(prefix) ) {
            prefix = '';
        } else {
            prefix += '__';
        }

        String srPath = '/resource/' + sr.SystemModstamp.getTime() + '/' + prefix + 'MockResponse/response/' + key + '.json';
        System.debug(' srpath xxxxxxxx '+srPath);
        PageReference pg = new PageReference( srPath );
        System.debug(' pg.getContent().toString() '+pg.getContent().toString());
      
        if ( Test.isRunningTest() )
            return null;
        
        String body = pg.getContent().toString();
        
        system.debug('(**) Mocked Response: ' + body );
        
        return body;*/
    }
}