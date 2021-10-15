/* 
 * Une classe utilitaire pour analyser le XML et créer le JSON équivalent
 * @author - Madicke BALDE
 * @date 07/03/2021
*/
public class XMLParser {
     
    // Pour trouver l'élément racine afin que nous puissions l'enfermer dans les accolades
    public static String rootElementName; 
     
    /* Méthode qui parse le contenu XML en JSON
     * @param xml : XML String 
     * return     : JSON String
    */
     
    public static String xmlToJson(String xml) {

    // remplacer les sections CDATA par des token analysables
    xml = xml.replaceAll( '<!\\[CDATA\\[', 'XML_CDATA_START' ).replaceAll( ']]>', 'XML_CDATA_END' );
    // nous allons construire une Map du texte original et du texte de remplacement
    Map<String, String> replacementMap = new Map<String, String>();	
    // regular expression to match sections we want to replace	
    Pattern myPattern = Pattern.compile( '(XML_CDATA_START)(.*?)(XML_CDATA_END)' );	
    Matcher myMatcher = myPattern.matcher( xml );	
    while ( myMatcher.find() ) {	    // le regex était trop compliqué pour Matcher.replaceFirst (..)	    // il faut donc le faire manuellement, il suffit donc de mettre dans cette Map 	    // texte original et le texte de remplacement, nous remplaçons plus tard	    
    replacementMap.put( myMatcher.group(), myMatcher.group(2).escapeXML() );	}	
    // remplacer dans le xml chaque section CDATA par le XML échappé de son contenu interne
    for ( String key : replacementMap.keySet() ) {	  
    xml = xml.replace( key, replacementMap.get( key ) );	
    }

         
        // Chargez le xml dans le document
        Dom.Document doc = new Dom.Document();
        doc.load(xml);
        Dom.XMLNode root = doc.getRootElement();
         
        // Passez l'élément racine et false comme deuxième paramètre
        String jsonContent = XMLParser.parse(root, false);
         
        return jsonContent;
    }
     
     
    /* Méthode qui effectue les appels récursifs et crée le JSON pour
     * chaque élément, il traite chaque nœud et trouve les attributs et le contenu textuel d'un nœud
     * @param node      : Instance Dom.XMLNode - nœud XML qui sera traité
     * @param isChild   : Boolean - Pour contrôler la structure de JSON, doit être vrai pour l'élément enfant
     * return           : JSON string 
    */
    public static String parse(Dom.XMLNode node, Boolean isChild){
         
        String json = '';
        Boolean isArray = false;
        if ( rootElementName == null ) {
            rootElementName = node.getName();
        }
         
        if ( node.getNodeType() == Dom.XmlNodeType.ELEMENT ){
             
            Map<String, List<String>> mapChildrenJSON = new Map<String, List<String>>();
            List<String> lstJSONForChildren = new List<String>();
             
            // Check whether node has any child
            List<Dom.XMLNode> children = node.getChildElements();
            //System.debug('################### children '+children );
             
            if ( children.size() > 0 ){
             
                // Process all the children in a row
                for ( Dom.XMLNode child : children ){
                   //  System.debug('####################### balde test '+ child.getChildElements());
                    String tmp = parse( child, true );
                  
                    
                    if( tmp != '' ) {
                     
                        if ( !mapChildrenJSON.containsKey( child.getName() ) ){
                         
                            mapChildrenJSON.put( child.getName(), new List<String>() );     
                         
                        }
                         
                        // Add into a map to make a collection for the repeatative child nodes
                        mapChildrenJSON.get( child.getName() ).add( tmp );  
                     
                    }
                     
                } 
                 
                // Strcuture the JSON based on the repeation 
                // Should be treated as an array if there are multiple elements with the same node name
                for ( String key : mapChildrenJSON.keySet() ){
                     
                    if ( mapChildrenJSON.get(key).size() > 1 ){
                        if(isChild) {
                         
                            lstJSONForChildren.add( '[' + String.join(mapChildrenJSON.get(key), ', ') + ']' );
                         
                        }
                        else {
                         
                            lstJSONForChildren.add( '"' + key + '": [' + String.join(mapChildrenJSON.get(key), ', ') + ']' );
                                 
                        }
                        isArray = true;
                    }
                    else {
                     
                        lstJSONForChildren.add( '"' + key + '": ' + mapChildrenJSON.get(key)[0] );
                     
                    }
                }
            }
             
            // Construc the JSON for all the node attributes 
            List<String> lstAttributes = new List<String>( lstJSONForChildren );
             
            for ( Integer i=0; i<node.getAttributeCount(); i++){
                 
                String key = node.getAttributeKeyAt( i );
                String value = node.getAttribute( key, '' );
                lstAttributes.add( '"' + key + '": "' + value + '"' );    
             
            }  
             
            // Look for the text content 
            String textContent = node.getText();
            if ( textContent != null && textContent.trim() != '' ) {
             
                textContent = textContent.replace( '"', '\\"' );
                lstAttributes.add( '"ele_text": "' + textContent + '"' );  
                   
            }
            if (!isChild ){
             
                if(!isArray) {
                 
                    json = '"' + node.getName() + '": {' + String.join(lstAttributes,  ', ') + '}'; 
                     
                }
                else {
                 
                    json = ' {' + String.join(lstAttributes,  ', ') + '}'; 
                     
                }
            }
            else {
                if ( lstAttributes.size() == 1 && textContent != null && textContent.trim() != '' ){
                     
                    json = '"' + textContent + '"';
                     
                } 
                else {
                    if(!isArray) {
                     
                        if( lstAttributes.size() > 0 ){
                         
                            json = '{' + String.join(lstAttributes,  ', ') + '}'; 
                             
                        }
                         
                    }
                    else {
                     
                        json = String.join(lstAttributes,  ', '); 
                         
                    }
                }   
            }
        }
        if ( rootElementName == node.getName() ) {
         
            if(!isArray) {
             
                json = '{' + json + '}';
             
            }
            else {
                 
                json = '{"' + node.getName() + '" : ' + json + '}';
                 
            }
         
        }
         
        system.debug(node.getName()+ ':' + json);
         
        return json;
    }

   
}