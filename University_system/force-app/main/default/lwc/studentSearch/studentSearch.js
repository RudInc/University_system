import { LightningElement } from 'lwc';
import searchStudent from '@salesforce/apex/StudentController.searchStudent';
export default class StudentSearch extends LightningElement {
    students = '';
    studentName;

    searchStudentHandler(){
        searchStudent({studentName: '%'+this.studentName+'%'})
            .then(result=>{
                    console.log(result);
                    this.students = result;
            })
            .catch(error=>{
                console.log("Search error:" + error);
            })
        }
    nameChangeHandler(event){
        this.studentName = event.detail.value; 
    }
    additionalInfoHandler(event){
        console.log("studentSearch");
        this.dispatchEvent(new CustomEvent('additionalinfo',{detail : event.detail}));
    }
}