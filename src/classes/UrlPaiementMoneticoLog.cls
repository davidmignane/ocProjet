public class UrlPaiementMoneticoLog implements WSOVSPLog{
    public void createLog (APIResponse_WSO resp, HttpRequest req, String  exceptionMessage ){
        System.debug(' +++++++++++ resp  UrlPaiementMoneticoLog'+ resp);
        System.debug(' +++++++++++ resp  UrlPaiementMoneticoLog'+ exceptionMessage);

        String codeErreurFlux ;
        String statusDuFlux;
        if(resp.statusCode == 200){
            statusDuFlux = resp.status;
            codeErreurFlux = String.valueOf(resp.statusCode);
        }

    }
}