import { LightningElement, api } from 'lwc';

export default class FlowCoursesLayoutItem extends LightningElement {
    @api flowCourse;
    @api chosen = false;
    @api chooseable  = false;


    chooseFlowCourseHandler(){
        const chooseEvent = new CustomEvent('choose',{
            detail : JSON.stringify(this.flowCourse) 
        });
        this.dispatchEvent(chooseEvent);
    }
    rejectFlowCourseHandler(){
        this.dispatchEvent(new CustomEvent('reject'));
    }
}