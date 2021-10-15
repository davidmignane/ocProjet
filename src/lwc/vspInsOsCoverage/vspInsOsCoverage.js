import { LightningElement, api, track } from "lwc";
import insOsCoverage from "vlocity_ins/insOsCoverage";
import template from "./vspInsOsCoverage.html";

export default class vspInsOsCoverage extends insOsCoverage{
    @track _channel;
    @track showCheckbox = false;

    render() {
        return template;
    }

    get isCoverageSpec(){
        
        return this.coverage.RecordTypeName__c === "CoverageSpec";
    }

  @api 
  get channel() {
    return this._channel;
  }

  set channel(data) {
      if(!data || data !== "SHOP") {
        this.showCheckbox = true;
      }
    }
}