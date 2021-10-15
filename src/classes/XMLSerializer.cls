/**
 * @author Madicke BALDE 
 * @description 
 * @date 04/03/2021
 */
public  class XMLSerializer {
      //Private Members
      private boolean serializeNulls = true;  				// Sérialise les nœuds XML même si le contenu est nul
      private string rootElement;              				// Élément racine à enrouler autour de la chaîne sérialisée.
      private Set<string> deSerializeAsArrayNodes = new Set<string>();	// Collection de noms de nœuds à désérialiser en tant que tableau.
      

      /*
  @description    : désérialise le xml dans l'objet d'apextype
  @param          : xmlString = xml String à désérialiser 
  @param          : apexType = type d'objet vers lequel désérialiser 
  @return         : objet de type apexType
  */
      public object deSerialize(string xmlString, System.Type apexType){   
      
              String json = XMLParser.xmlToJson(xmlString);
          
          try {
               System.debug('##########   System.JSON.deserialize(json,apexType) '+ System.JSON.deserializeStrict(json,apexType));
          } catch (Exception e) {
              System.debug('################ error Message '+e.getMessage());
          }
          
          return System.JSON.deserialize(json,apexType);  		
      }
      
      /*
  @description    : désérialise le xml dans l'objet du type passé
  @param          : xmlString = xml String à désérialiser
  @param          : apexType = type d'objet vers lequel désérialiser
  @param          : deSerializeNodesAsArray  = collection de noms de nœuds à désérialiser en tant que tableau (même si la représentation xml n'est pas un tableau)
  @return         : objet de type apexType 
  */
      public object deSerialize(string xmlString, System.Type apexType,Set<String> deSerializeNodesAsArray){ 
        
          this.deSerializeAsArrayNodes = toLower(deSerializeNodesAsArray);
          return deSerialize(xmlString,apexType);		
      }    
      
 
      /*
  @description    : Convertit tous les éléments de l'ensemble en minuscules
  @param          : stringSet = Ensemble de chaînes à convertir en minuscules.
  @return         : Ensemble converti de chaînes.
  */
      private Set<string> toLower(Set<string> stringSet){
          Set<string> lowerStringSet = new Set<string>();
          for(string s:stringSet) lowerStringSet.add(s.toLowerCase());
          return lowerStringSet;
      }
}