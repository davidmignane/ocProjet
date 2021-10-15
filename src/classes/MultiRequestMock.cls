/**
 * Created by David on 08.03.2021.
 */
@isTest
public class MultiRequestMock  implements HttpCalloutMock{
    Map<String,HttpCalloutMock> requests;
    public MultiRequestMock(Map<String, HttpCalloutMock> requests) {
        this.requests = requests;
    }

    public HTTPResponse respond(HTTPRequest req) {
        System.debug('req'+req.getEndpoint());
        System.debug('requests'+requests);
        System.debug('requests'+requests.get(req.getEndpoint()));
        HttpCalloutMock mock = requests.get(req.getEndpoint());
        if(mock != null){
            return mock.respond(req);
        }
        else {
        System.debug('HTTP callout not supported for test methods');
            return mock.respond(req);
    }
    }

    public void addRequestMock(String url, HttpCalloutMock mock) {
        requests.put(url, mock);
    }
}