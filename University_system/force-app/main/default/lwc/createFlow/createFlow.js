import { LightningElement } from 'lwc';
import getSpecialities from '@salesforce/apex/FlowController.getSpecialities';


export default class CreateFlow extends LightningElement {
    flowName;
    specialty;
    startDate;
    specialties=[];
    formatOfEd = "FullTime";
    formatsOfEducation = [
        {label: "FullTime", value: "FullTime"},
        {label: "Distance", value: "Distance"}
    ];
    chosen = false;
    createFlowHandler(){
        this.chosen = true;
        const createFlowEvent = new CustomEvent("createflow",{
            detail : JSON.stringify({
                z : this.flowName,
                specialty : JSON.parse(this.specialty).Id,
                formatOfEd: this.formatOfEd,
                startDate: this.startDate
            })
        });
        this.dispatchEvent(createFlowEvent);
    }
    rejectFlowHandler(){
        this.chosen = false;
    }
    setFlowNameHandler(event){
        this.flowName = event.detail.value;
    }
    setFlowStartDateHandler(event){
        this.startDate = event.detail.value;
    }
    chooseSpecialtyHandler(event){
        this.specialty = event.detail.value;
        console.log(this.specialty);
    }
    chooseFormatOfEdHandler(event){
        this.selectedFormatOfEd = event.detail.value;
    }
    connectedCallback(){
        getSpecialities()
            .then(result =>{
                result.forEach(element => 
                    {
                        this.specialties = this.specialties.concat(
                        [{ 
                            label: element.Name+' '+element.Code__c,
                            value: JSON.stringify(element)
                        }]
                    )});
                console.log(this.specialties);
            })
            .catch(error=>{
                console.log("getSpecialities Error: "+ error);
            });
    console.log("Format:" + JSON.stringify(this.objectInfo));
    }
}