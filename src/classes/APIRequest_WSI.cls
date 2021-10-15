/**
 * @description
 * @author Madicke BALDE
 * @date 27/02/2021
 */
public virtual class APIRequest_WSI {
    
    /**
     * @description
     * @return Map<String,String>
     */
    public virtual Map<String,String> getParameters (){
        return new Map<String,String>();
    }
    /**
     * @description 
     * @param f
     * @param 
     * @return 
     */
    public String getFullUrl (  Map<String,String> parameters , String endPoint){
        Pagereference pgEndPoint = new Pagereference(endPoint);
        if(parameters != null){
            for(String key : parameters.keySet()){
                String value = parameters.get(key);
                pgEndPoint.getParameters().put(key, value);
            }
                 return pgEndPoint.getUrl();
        }
        else {
                return null;
        }

    }
}