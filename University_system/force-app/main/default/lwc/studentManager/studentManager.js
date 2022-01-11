import { LightningElement } from 'lwc';
import createFlowWithStudents from '@salesforce/apex/FlowController.createFlowWithStudents';

export default class StudentManager extends LightningElement {
    
    columns = [
        { label: "Full Name", fieldName: "fullName", type:"text" },
        { label: "Phone number", fieldName: "phoneNumber", type:"phone" },
        { label: "Email", fieldName: "email", type: "email" },
        { label: "Grand?", fieldName: "grand", type: "boolean"}
    ];
    studentsList=[];
    selectedFlow;


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
    confirmHandler(){
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