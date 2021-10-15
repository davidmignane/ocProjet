public  class SubscriptionLog implements WSOVSPLog {
    public void createLog (APIResponse_WSO resp, HttpRequest req, String  exceptionMessage ){
        System.debug(' +++++++++++ resp  SubscriptionLog'+ resp);
        System.debug(' +++++++++++ resp  exceptionMessage'+ exceptionMessage);

        String codeErreurFlux ;
        String statusDuFlux;
        if(resp.statusCode == 200){
            statusDuFlux = resp.status;
            codeErreurFlux = String.valueOf(resp.statusCode);
        }

    }
}