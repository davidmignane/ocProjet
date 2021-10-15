public  class VerspierenJSONSerializer implements VerspirenSerializer {
        
    public APIResponse_WSO deserialize (HttpResponse response, Type repClass) {
           APIResponse_WSO res = (APIResponse_WSO) repClass.newInstance();
           res = (APIResponse_WSO) JSON.deserialize(response.getBody(), repClass);
           return res;
    }
}