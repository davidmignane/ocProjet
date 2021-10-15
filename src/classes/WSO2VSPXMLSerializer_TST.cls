/**
 * @author Madicke BALDE 
 * @description classe test pour tester le parse le xml en sjon
 */
@isTest
public with sharing class WSO2VSPXMLSerializer_TST {
    
    @isTest
    static void testdeserialize(){
      Test.startTest();
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/xml');
            String  body = '<ams:fault xmlns:ams="http://wso2.org/apimanager/security"> \n'+
            '<ams:code>900901</ams:code> \n'+
            '<ams:message>Invalid Credentials</ams:message>\n'+
            '<ams:description>Access failure for API: /ogiSubscription/1.0.0, version: 1.0.0 status: (900901) - Invalid Credentials. Make sure you have given the correct access token</ams:description>\n'+
            '</ams:fault>';
            response.setBody(body);
            WSO2VSPXMLSerializer xml = new WSO2VSPXMLSerializer();
            APIResponse_WSO resp =  xml.deserialize(response, ContratOGI_Wrapper_WSO.class);
            System.debug('++++++++++ resp ++'+resp);
      Test.stopTest();
    }
    
    @isTest
    static void testdeserialize2(){
      Test.startTest();
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/xml');
            String  body = '<ams:fault xmlns:ams="http://wso2.org/apimanager/security"> \n'+
            '<ams:code>900901</ams:code> \n'+
            '<ams:message>Invalid Credentials</ams:message>\n'+
            '<ams:description>Access failure for API: /ogiSubscription/1.0.0, version: 1.0.0 status: (900901) - Invalid Credentials. Make sure you have given the correct access token</ams:description>\n'+
            '</ams:fault>';
            response.setBody(body);
            WSO2VSPXMLSerializer xml = new WSO2VSPXMLSerializer();
            APIResponse_WSO resp =  xml.deserialize(response, ContratOGI_Wrapper_WSO.class);
      Test.stopTest();
    }
    

    @isTest
    static void  testmeth (){
        Test.startTest();
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/xml');
        String body = '<?xml version="1.0" encoding="UTF-8"?>\n'+
        ' <breakfast_menu>\n'+
        ' <food> \n'+
        '  <name>Belgian Waffles</name> \n'+
        '  <price>$5.95</price> \n'+
        '  <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description> \n'+
        '   <calories>650</calories> \n'+
        ' </food>   <food> \n'+
        '<name>Strawberry Belgian Waffles</name>\n'+
        ' <price>$7.95</price> \n'+
        '    <description>Light Belgian waffles covered with strawberries and whipped cream</description> \n'+
        '  <calories>900</calories> </food>  <food>\n'+
        ' <name>Berry-Berry Belgian Waffles</name> <price>$8.95</price> \n'+
          
        ' <description>Light Belgian waffles covered with an assortment of fresh berries and whipped cream</description>\n'+
        '   <calories>900</calories> </food> <food> <name>French Toast</name> \n'+
        ' <price>$4.50</price> \n'+
             
        ' <description>Thick slices made from our homemade sourdough bread</description> \n'+
        '   <calories>600</calories> </food> <food> \n'+
        '  <name>Homestyle Breakfast</name> \n'+
        ' <price>$6.95</price> \n'+
        ' <description>Two eggs, bacon or sausage, toast, and our ever-popular hash browns</description> \n'+
        ' <calories>950</calories> </food> \n'+
        '</breakfast_menu>';
        response.setBody(body);
        WSO2VSPXMLSerializer xml = new WSO2VSPXMLSerializer();
        WSO2VSPDataFactory_TST.BreakFastMenu resp = (WSO2VSPDataFactory_TST.BreakFastMenu) xml.deserialize(response, WSO2VSPDataFactory_TST.BreakFastMenu.class);
        System.assertEquals(5, resp.breakfast_menu.food.size(), ' ### pass ### ');

        Test.stopTest();
    }
   
    public class ContratOGI_Wrapper_WSO  extends APIXMLResponse_WSO{
      public string num_client;
      public string num_contrat;
      public string num_quittance;
      public string rum;
      public Fault fault ;

      public override Set<String> getTagNamesAsArray() {
        Set<String> tagNamesAsArray = new Set<String>();
        tagNamesAsArray.add('fault');
        return tagNamesAsArray;
     }
    }

    public class Fault {
      public String code ;
      public String message;
      public String description ;
  }
  
}