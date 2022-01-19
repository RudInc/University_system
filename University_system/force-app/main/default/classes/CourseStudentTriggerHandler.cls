public with sharing class CourseStudentTriggerHandler {
    public CourseStudentTriggerHandler() {

    }
    public static void setCourseStudentName(Set<Id> courseStudentIds){
        //StudentName + CourseName
        List<Course_Student__c> courseStudentList = [
            SELECT Course__r.Name, Student__r.Full_Name__c 
            FROM Course_Student__c 
            WHERE Id in:courseStudentIds];
        for(Course_Student__c courseStudent : courseStudentList){
            courseStudent.Name = courseStudent.Course__r.Name+'_'+courseStudent.Student__r.Full_Name__c;
        }
        update courseStudentList;
    }
}
