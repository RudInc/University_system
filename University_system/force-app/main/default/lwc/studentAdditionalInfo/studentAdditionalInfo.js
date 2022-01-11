import { LightningElement, api} from 'lwc';
import getCourcesOfStudent from '@salesforce/apex/StudentController.getCourcesOfStudent';


export default class StudentAdditionalInfo extends LightningElement {
    @api student;
    studentCourses = [];
    avgMark;
    columns = [
        { label:"Code", fieldName: 'Name', type:"text" },
        { label:"Course", fieldName: 'Course__c', type: "text"},
        { label:"Teacher", fieldName: 'Teacher__c', type:"text"},
        { label:"Mark", fieldName: 'Mark__c', type:"number"}
    ];



    connectedCallback(){
        getCourcesOfStudent({studentId: this.student.Id})
            .then(result =>{
                this.studentCourses = result;
                console.log(this.studentCourses);
            })
            .catch(error=>{
                console.log("getCoursesOfStudents Error: "+error);
            });
    }
    closeHandler(){
        this.dispatchEvent(new CustomEvent('close'));
    }
}