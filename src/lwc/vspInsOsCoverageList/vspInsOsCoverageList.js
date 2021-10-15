import { LightningElement, api } from "lwc";
import insOsCoverageList from "vlocity_ins/insOsCoverageList";
import { dataFormatter } from 'vlocity_ins/insUtility';
import template from "./vspInsOsCoverageList.html";
import pubsub from 'vlocity_ins/pubsub';

export default class vspInsOsCoverageList extends insOsCoverageList{

    @api channel;

    @api
    get product() {
        return this._product;
    }

    set product(data) {
        this._product = JSON.parse(JSON.stringify(data));
        if (this._product && this._product.childProducts && this._product.childProducts.records) {
            this.coverages = this._product.childProducts.records.filter(coverage => {
                const recordType = dataFormatter.getNamespacedProperty(coverage, 'RecordTypeName__c');
                return recordType === 'CoverageSpec';
            });
            /* this is the OOTB code but is simply not covering all use cases and way more complicated then needed
            let firstUnselectedIndex = this.coverages.findIndex(coverage => {
                const recordType = dataFormatter.getNamespacedProperty(coverage, 'RecordTypeName__c');
                return recordType === 'CoverageSpec' && !coverage.isSelected;
            });
            if (firstUnselectedIndex === -1) {
                firstUnselectedIndex = this.coverages.length;
            }
            this.selectedCoverages = this.coverages.slice(0, firstUnselectedIndex);
            this.unselectedCoverages = this.coverages.slice(firstUnselectedIndex);
            */
            this.selectedCoverages = this.coverages.filter(coverage => {
                return coverage.isSelected;
            });

            this.unselectedCoverages = this.coverages.filter(coverage => {
                return !coverage.isSelected;
            });
        }
    }

    renderedCallback(){
        super.renderedCallback();
        if(this.selectedCoverages.length > 0) {
            pubsub.fire("omni_allow_next_step", 'data', { 
                allowNextStep: true
            });
        } else {
            pubsub.fire("omni_allow_next_step", 'data', { 
                allowNextStep: false
            });
        }
    }

    render() {
        return template;
    }
}