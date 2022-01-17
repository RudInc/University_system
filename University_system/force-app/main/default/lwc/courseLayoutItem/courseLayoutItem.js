import { LightningElement, api } from 'lwc';

export default class CourseLayoutItem extends LightningElement {
    @api course;
    @api chosen = false;
    @api chooseable = false;

    chooseCourseHandler(){
        const chooseCourseEvent = new CustomEvent('choosecourse',{
            detail : JSON.stringify(this.course)
        });
        this.dispatchEvent(chooseCourseEvent);
    }
    rejectCourseHandler(){
        this.dispatchEvent(new CustomEvent('rejectcourse'));
    }
}