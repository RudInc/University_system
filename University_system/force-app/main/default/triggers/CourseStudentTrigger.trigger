trigger CourseStudentTrigger on Course_Student__c (after insert) {
    if(Trigger.isInsert && Trigger.isAfter){
        CourseStudentTriggerHandler.setCourseStudentName((Trigger.newMap).keySet());
    }
}