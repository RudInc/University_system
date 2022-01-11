import { LightningElement, wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import getSpecialities from '@salesforce/apex/FlowController.getSpecialities';
import FORMAT_OF_ED_OBJECT from '@salesforce/schema/Flow__c';
import FORMAT_OF_ED_FIELD from '@salesforce/schema/Flow__c.Format_of_education__c';

export default class CreateFlow extends LightningElement {
    flowName;
    specialty;
    startDate;
    specialties=[];
    formatOfEd = "Full Time";
    chosen = false;
    @wire(getObjectInfo,{
        objectApiName: FORMAT_OF_ED_OBJECT
    }) objectInfo;
    @wire(getPicklistValues,{
        recordTypeId: "$objectInfo.data.defaultRecordTypeId", 
        fieldApiName: FORMAT_OF_ED_FIELD
    }) formatsOfEducation; 

    
    createFlowHandler(){
        this.chosen = true;
        const createFlowEvent = new CustomEvent("createflow",{
            detail : JSON.stringify({
                flowName : this.flowName,
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