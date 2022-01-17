import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createFlowWithStudents from '@salesforce/apex/FlowController.createFlowWithStudents';

export default class StudentManager extends LightningElement {
    
    columns = [
        { label: "Full Name", fieldName: "fullName", type:"text" },
        { label: "Phone number", fieldName: "phoneNumber", type:"phone" },
        { label: "Email", fieldName: "email", type: "email" },
        { label: "Grand?", fieldName: "grand", type: "boolean"}
    ];
    studentsList=[];
    selectedFlow = undefined;


    createStudentHandler(event){
        console.log(event.detail);

        this.studentsList = this.studentsList.concat([JSON.parse(event.detail)]);
        console.log(this.studentsList);
    }
    createFlowHandler(event){
        console.log(event.detail);
        this.selectedFlow = event.detail;
        console.log(this.selectedFlow);
    }
    dropStudentsHandler(){
        this.studentsList = [];
    }
    confirmHandler(){
        if(this.selectedFlow==undefined){
            const flowError = new ShowToastEvent({
                title:"Flow dont created",
                variant: 'error'
            });
            this.dispatchEvent(flowError);
            return;
        }
        if(this.studentsList.length==0){
            const studError = new ShowToastEvent({
                title:"Students dont created",
                variant: 'error'
            });
            this.dispatchEvent(studError);
            return;
        }
        createFlowWithStudents({
            flow :  this.selectedFlow,
            students : JSON.stringify(this.studentsList)
        })
        .then(result=>{
            console.log(result);
        })
        .catch(error=>{
            console.log(error);
        });
    }
}