trigger StudentTrigger on Student__c (before insert, after insert) {
    StudentTriggerHandler handler = new StudentTriggerHandler();
    if(Trigger.isInsert&&Trigger.isBefore){
        handler.changeNumberOfStudentsInFlow(Trigger.new);
    }
    if(Trigger.isInsert&&Trigger.isAfter){
        handler.addStudentToCourses(Trigger.new);
    }

}