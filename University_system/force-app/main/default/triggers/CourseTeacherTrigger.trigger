trigger CourseTeacherTrigger on Course_Teacher__c (before insert) {
    if(Trigger.isInsert && Trigger.isBefore){
        CourseTriggerHandler.setCourseTeacherName(Trigger.new);
    }
}