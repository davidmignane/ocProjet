import insOsSingleInstance from "vlocity_ins/insOsSingleInstance";
import template from "./vspUILWCinsOsSingleInstance.html";
import { LightningElement, api, track } from "lwc";
import { dataFormatter } from 'vlocity_ins/insUtility';
import { cloneDeep } from "vlocity_ins/lodash";
import pubsub from 'vlocity_ins/pubsub';

export default class vspUILWCinsOsSingleInstance extends insOsSingleInstance {
  @track _channel;
  @track showTextElements = false;
  @api sortByKey;
  
  @api 
  get channel() {
    return this._channel;
  }

  set channel(data) {
    this._channel = data;  
    if(data === "SHOP") {
      this.showTextElements = true;
    }
  }
  
  render() {
    return template;
  }

  get totalAnnualPrice() {
        const price = this.product.Price || 0;
        const taxFee = this.product.totalTaxFeeAmount || 0;
        return (Math.round(price + taxFee))*12;
    }

  get totalPrice() {
    const price = this.product.Price || 0;
    let totalTaxFeeAmount = this.product.totalTaxFeeAmount || 0;
    if (!totalTaxFeeAmount) {
      totalTaxFeeAmount = this.calcTotalTaxFeeAmount();
    }
    return (Math.round(price + totalTaxFeeAmount));
  }

  connectedCallback() {
    super.connectedCallback();
    pubsub.register("omni_allow_next_step", {
      data: this.updateValidity.bind(this)
    });
  }

  updateValidity(data) {
    this.omniApplyCallResp(
      data
    );
  }

  formatProduct(data) {
    super.formatProduct(data);
    
    if(this.sortByKey && this._channel !== "SHOP") {
      let copy = cloneDeep(this.product);
      copy.childProducts.records = dataFormatter.sortByKey(copy.childProducts.records, this.sortByKey);
      this.product = copy;
    }
  }
}