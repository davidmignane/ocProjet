/**
 *@author Madicke BALDE
 *@description  interface de deserialisation du XML/JSON en object 
 *@date 07/03/2021
 */
public interface WSO2VSPSerializer {
    APIResponse_WSO deserialize (HttpResponse response, Type repClass);
}