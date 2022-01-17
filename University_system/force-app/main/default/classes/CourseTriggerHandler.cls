public with sharing class CourseTriggerHandler {
    public CourseTriggerHandler() {

    }
    public static void setCourseTeacherName(List<Course_Teacher__c> courses){
        
        for(Course_Teacher__c course : courses){
            course.Name = course.Teacher_Name__c + '_' + course.Course_Name__c;
        }
        
    }
}
