import { LightningElement, api } from 'lwc';
import searchFlowCourses from '@salesforce/apex/FlowController.searchFlowCourses';


export default class SearchFlowCourses extends LightningElement {
    courses;

    @api
    searchFlowCoursesHandler(flow){
        console.log(JSON.parse(flow));
        searchFlowCourses({
            flowString : flow
        })
        .then(result=>{
            this.courses = result;
        })
        .catch(error=>{
            console.log('Search Flow Courses Error: ' + JSON.stringify(error));
        });
    }
    chooseCourseHandler(event){
        const chooseCourseEvent = new CustomEvent('choosecourse',{
            detail : event.detail
        });
        this.dispatchEvent(chooseCourseEvent);
    }

}