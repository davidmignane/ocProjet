/**
 * @author Madicke BALDE 
 * @description classe pour desérialiser XML en objet
 * @date 04/03/2021
 */
public  class WSO2VSPXMLSerializer implements WSO2VSPSerializer {
    
    /**
    *@description cette methode permet de deserialiser la response de type xml 
    *@param resp        : HttpResponse la response du web service
    *@param respClass   : la response sera deserialisé en une instance de type respClass
    *@return             :  APIResponse_WSO
     */
    public APIResponse_WSO deserialize (HttpResponse resp, Type respClass){
        
        APIXMLResponse_WSO r =  (APIXMLResponse_WSO) respClass.newInstance();
        Set<String> tagNamesAsArray = r.getTagNamesAsArray();
        System.debug('+++++++ tagNames '+tagNamesAsArray);
        XMLSerializer xmls = new XMLSerializer();
        String body = resp.getbody().replaceAll('\n','').replaceAll('\r','');
        if(tagNamesAsArray != null & tagNamesAsArray.size() >= 1  ){
           
            return (APIXMLResponse_WSO) xmls.deSerialize( body , respClass, tagNamesAsArray);
        }
        else {
            return (APIXMLResponse_WSO) xmls.deSerialize(body , respClass);
        }
    }
   
}