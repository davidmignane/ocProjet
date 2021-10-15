/**
 * @description classe de base pour les flux sortants
 * @author Madicke BALDE
 * @date 26/02/20021
 */
public virtual class APIResponse_WSO {
    
    public String status {get;set;}
    public Integer statusCode {get;set;} 
    public virtual Boolean isOK () {
        return this.statusCode == 200;
    }
   
}