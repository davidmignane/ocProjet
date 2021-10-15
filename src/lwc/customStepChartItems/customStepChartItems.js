import { LightningElement, api, track } from 'lwc';
import omniscriptStepChartItems from 'vlocity_ins/omniscriptStepChartItems';
import tmpl_nds from './customStepChartItems_nds.html';
import tmpl_vertical from './omniscriptStepChartItems_vertical.html';
import tmpl_horizontal from './omniscriptStepChartItems_horizontal.html';

export default class CustomStepChartItems extends omniscriptStepChartItems {
    @api numberOfSteps;

    get stepWidth() {
        if(this.numberOfSteps) {
            return `width: ${100 / this.numberOfSteps}%`;
        }
        return `width: 0%`;
    }

    get stepLabel() {
        let stepLabel = '';

        if (this.jsonDef.bShow !== false) {
            stepLabel = this.jsonDef.propSetMap.chartLabel || this.jsonDef.propSetMap.label;

            if (this.scriptHeaderDef && this.scriptHeaderDef.multiLang) {
                stepLabel = this.scriptHeaderDef.allCustomLabels[stepLabel];
            }
        }

        return stepLabel;
    }

    render() {
        if (this.theme === 'nds') {
            return tmpl_nds;
        }
        return this.isVertical ? tmpl_vertical : tmpl_horizontal;
    }
}