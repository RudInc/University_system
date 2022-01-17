import { LightningElement, api } from 'lwc';

export default class TeacherLayoutItem extends LightningElement {
    @api teacher;
    @api chosen = false;
    @api chooseable = false;


    chooseTeacherHandler(){
        const chooseTeacherEvent = new CustomEvent('chooseteacher',{
            detail : JSON.stringify(this.teacher) 
        });
        this.dispatchEvent(chooseTeacherEvent);
    }
    rejectTeacherHandler(){
        this.dispatchEvent(new CustomEvent('rejectteacher'));
    }
}