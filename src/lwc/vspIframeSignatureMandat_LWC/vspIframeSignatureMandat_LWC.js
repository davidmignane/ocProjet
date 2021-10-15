import { LightningElement } from 'lwc';
    import { OmniscriptBaseMixin } from 'vlocity_ins/omniscriptBaseMixin';
    import Template from './vspIframeSignatureMandat_LWC.html';  
    export default class vspIframeSignatureMandat_LWC extends OmniscriptBaseMixin(LightningElement) {
      
      get mandat(){
          return this.omniJsonData.url_signature;
      }    

      connectedCallback() {
        // Call omniUpdateDataJson to update the omniscript
        // this.omniUpdateDataJson({'key':'value'});
      }

      render(){
        return Template;
    }
    
    }