import { LightningElement } from 'lwc';
import omniScriptStepChart from 'vlocity_ins/omniscriptStepChart';
import tmpl_nds from './customStepChart_nds.html';
import tmpl from './customStepChart_slds.html';

export default class CustomStepChart extends omniScriptStepChart {
    get stepWidth() {
        if(this._numOfSteps) {
            return `width: ${100 / this._numOfSteps}%;border-left: 1px solid;border-right: 1px solid;`;
        }
        return `width: 0%;border-left: 1px solid;border-right: 1px solid;`;
    }

    render() {
        return this._theme === 'nds' ? tmpl_nds : tmpl;
    }
}