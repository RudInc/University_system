import { LightningElement, api} from 'lwc';

export default class StudentCourses extends LightningElement {
    @api record;
    color="width: 100px height: 100px ";
    connectedCallback(){
        if(this.record.Mark__c < 64){
            this.color =+"background-color: red"
        } 
        else if(this.record.Mark__c >= 64 &&this.record.Mark__c < 90)
        {
            this.color =+"background-color: yellow";
        }
        else if(this.record.Mark__c >= 90){
            this.color =+"background-color: green";
        }
    }
    
}