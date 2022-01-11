import { LightningElement } from 'lwc';



export default class CreateStudent extends LightningElement {
    
    student = {
        fullName : "",
        phoneNumber : "" ,
        email : "",
    };
    
    changeFullNameHandler(event){
        this.student.fullName = event.detail.value;
    }
    changeEmailHandler(event){
        this.student.email = event.detail.value;
    }
    changePhoneNumberHandler(event){
        this.student.phoneNumber = event.detail.value;
    }
    createStudentHandler(){
        const createStudentEvent = new CustomEvent('createstudent',{
            detail : JSON.stringify(this.student)
        });
        this.dispatchEvent(createStudentEvent);
    }
}