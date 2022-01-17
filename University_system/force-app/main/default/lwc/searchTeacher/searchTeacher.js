import { LightningElement,api } from 'lwc';

import searchTeacher from '@salesforce/apex/TeacherController.searchTeacher';


export default class SearctTeacher extends LightningElement {
    @api chosen = false;
    teachers = [];
    teacherName = '';
    

    searchTeacherHandler(){
        searchTeacher({
            teacherName : '%'+this.teacherName+'%'
        })
        .then(result=>{
            this.teachers = result;
        })
        .catch(error=>{
            console.log("Seacrh error: "+error);
        });
    }
    changeNameHandler(event){
        this.teacherName = event.detail.value;
    }
    chooseTeacherHandler(event){
        this.teachers = [JSON.parse(event.detail)];
        this.chosen = true;
        const chooseTeacherEvent = new CustomEvent('chooseteacher',{ detail: event.detail });
        this.dispatchEvent(chooseTeacherEvent);
    }
    rejectTeacherHandler(){
        this.chosen = false;
        this.dispatchEvent(new CustomEvent('rejectteacher'));
    }
}