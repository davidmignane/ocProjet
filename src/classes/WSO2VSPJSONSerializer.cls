public  class WSO2VSPJSONSerializer implements WSO2VSPSerializer {
    
    public APIResponse_WSO deserialize (HttpResponse response, Type repClass) {
        System.debug('+++++ response status '+response.getStatus());
        System.debug('+++++ response status '+response );
        APIResponse_WSO res = (APIResponse_WSO) repClass.newInstance();
       // String formattedResponse = WSO2VSP_UTL.formatResponse(response.getBody());
        res = (APIResponse_WSO) JSON.deserialize(response.getBody(), repClass);
        return res;
    }
}