import { LightningElement,api } from 'lwc';

export default class FlowLayoutItem extends LightningElement {
    @api flow;
    @api chosen = false;
    @api chooseable = false;


    chooseFlowHandler(){
        const chooseFlowEvent = new CustomEvent('chooseflow',{
            detail: JSON.stringify(this.flow)
        });
        this.dispatchEvent(chooseFlowEvent);
    }
    rejectFlowHandler(){
        this.dispatchEvent(new CustomEvent('rejectflow'));
    }
}