import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import bindTeacherToCourse from '@salesforce/apex/TeacherController.bindTeacherToCourse';
import bindTeacherToStudentsCourse from '@salesforce/apex/TeacherController.bindTeacherToStudentsCourse';

export default class TeacherManager extends LightningElement {

    chosenCourse = null;
    chosenTeacher = null;
    chosenFlow = null;

    chooseTeacherHandler(event){
        console.log("Teacher received: "+ event.detail);
        this.chosenTeacher = JSON.parse(event.detail);
    }
    rejectTeacherHandler(){
        this.chosenTeacher = null;
    }

    chooseFlowHandler(event){
        console.log("Flow received: "+ event.detail);
        this.template.querySelector("c-search-flow-courses").searchFlowCoursesHandler(event.detail);
        this.chosenFlow = JSON.parse(event.detail);
    }
    rejectFlowHandler(){
        this.chosenFlow = null;

    }
    chooseCourseHandler(event){
        console.log("Course chosen: "+ event.detail);
        this.chosenCourse = JSON.parse(event.detail);
    }
    rejectCourseHandler(){
        this.chosenCourse = null;
    }
    bindTeacherToCourseHandler(){
        if(this.chosenTeacher!=null&& this.chosenCourse != null){
            bindTeacherToCourse({
                teacherId: this.chosenTeacher.Id,
                courseId: this.chosenCourse.Id
            })
            .then(result=>{
                //`%${this.courseName}%`
                const toastEvent = new ShowToastEvent({
                    title: "Teacher binding status "+ result,
                    message: `Teacher: ${this.chosenTeacher.Full_Name__c} Course: ${this.chosenCourse.Name}`,
                    variant: "info"
                });
                this.dispatchEvent(toastEvent);
            })
            .error(error=>{
                console.log("Bind Teacher To Course Error: "+error);
            });
        }else{
            const toastEvent = new ShowToastEvent({
                title: "Error",
                message: "Teacher or course did  not selected",
                variant: "error"
            });
            this.dispatchEvent(toastEvent);

        }
    }
    chooseCourseToBind(event){
        bindTeacherToStudentsCourse({
            teacherId : this.chosenTeacher.Id,
            flowId : this.chosenFlow.Id, 
            courseId : JSON.parse(event.detail).Id
        })
        .then(result=>{
            const toastEvent = new ShowToastEvent({
                title : "Binding status " + result,
                variant: "info"
            });
            this.dispatchEvent(toastEvent);
        })
        .catch(error=>{
            console.log("bindTeacherToStudentsCourse Error: "+ error);
        });
    }
}