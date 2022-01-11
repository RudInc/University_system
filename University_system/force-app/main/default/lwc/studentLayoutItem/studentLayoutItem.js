import { LightningElement,api } from 'lwc';



export default class StudentLayoutItem extends LightningElement {
    @api student;

    onclickHandler(){
        const chooseStudent = new CustomEvent('additionalinfo',{
            detail: JSON.stringify(this.student)
        }); 
        this.dispatchEvent(chooseStudent);
    }

}