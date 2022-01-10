import { LightningElement, api } from 'lwc';
import getCourcesOfStudent from '@salesforce/apex/StudentCoursesController.getCourcesOfStudent'

export default class StudentCoursesLayout extends LightningElement {
    @api recordId;
    studentCourses = [];
 

    connectedCallback(){
        getCourcesOfStudent({studentId : this.recordId})
            .then(result=>{
                this.studentCourses = result;
            })
            .catch(error=>{
                console.log(error);
            });
    }
    
}