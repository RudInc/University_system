import { LightningElement } from 'lwc';
import searchFlow from '@salesforce/apex/FlowController.searchFlow';

export default class SearchFlow extends LightningElement {
    chosen = false;
    flowName ='';
    flows = [];

    changeFlowNameHandler(event){
        this.flowName = event.detail.value;
    }
    searchFlowHandler(){
        searchFlow({
            flowName: '%'+this.flowName +'%'
        })
        .then(result=>{
            this.flows = result;
            console.log( this.flows);
        })
        .catch(error=>{
            console.log("Search Flow Error: "+ error);
        });
    }
    chooseFlowHandler(event){
        this.flows = [JSON.parse(event.detail)];
        this.chosen = true;
        const chooseFlowEvent = new CustomEvent('chooseflow',{
            detail : event.detail
        });
        this.dispatchEvent(chooseFlowEvent);
        
    }
    rejectFlowHandler(){
        this.chosen = false;
        this.dispatchEvent(new CustomEvent('rejectflow'));
        
    }
}