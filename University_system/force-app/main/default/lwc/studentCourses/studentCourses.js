import { LightningElement, api} from 'lwc';

export default class StudentCourses extends LightningElement {
    @api record;
    
    get color(){
        console.log(this.record.Mark__c);
        if(this.record.Mark__c < 64||this.record.Mark__c == undefined){
            return "color_red";
        } 
        else if(this.record.Mark__c >= 64 &&this.record.Mark__c < 90)
        {
            return "color_yellow";
        }
        else if(this.record.Mark__c >= 90){
            return "color_green";
        }
    }
    
}