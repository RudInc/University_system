import { LightningElement } from 'lwc';
import searchCourse from '@salesforce/apex/CourseController.searchCourse';

export default class SearchCourse extends LightningElement {
    courses = [];
    courseName = '';
    chosen=false;

    searchCourseHandler(){
        searchCourse({
            courseName: `%${this.courseName}%`
        })
        .then(result=>{
            this.courses = result;
        })
        .catch(error=>{
            console.log(`Search Course Error: ${error}`);
        });
    }
    changeNameHandler(event){
        this.courseName = event.detail.value;
    }
    chooseCourseHandler(event){
        this.courses = [JSON.parse(event.detail)];
        const chooseCourseEvent = new CustomEvent("choosecourse",{
            detail: event.detail
        });
        this.dispatchEvent(chooseCourseEvent);
        this.chosen = true;
    }
    rejectCourseHandler(){
        this.dispatchEvent(new CustomEvent('rejectcourse'));
        this.chosen = false;
    }
}