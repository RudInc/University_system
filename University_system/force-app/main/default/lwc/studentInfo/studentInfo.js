import { LightningElement } from 'lwc';

export default class StudentInfo extends LightningElement {
    student;
    chosen = false;

    additionalInfoHandler(event){
        this.student = JSON.parse(event.detail);
        this.chosen = true;
    }
    closeHandler(){
        this.chosen = false;
    }
    
}