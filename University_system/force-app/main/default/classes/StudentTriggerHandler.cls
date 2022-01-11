public with sharing class StudentTriggerHandler {
    //constructor
    public StudentTriggerHandler() {

    }
    //change number of students in flows, that students assigned
    public void changeNumberOfStudentsInFlow(Student__c[] students){
        Set<Id> flowsId = new Set<Id>();
        for(Student__c student : students){
            flowsId.add(student.Flow__c);
        }
        Map<Id,Flow__c> studentsPerFlow = new Map<Id,Flow__c>([SELECT Id, Number_of_students__c FROM Flow__c WHERE Id in:flowsId]);
        for(Student__c student : students){
            studentsPerFlow.get(student.Flow__c).Number_of_students__c += 1;
        }
        update studentsPerFlow.values();
        return;
    }
    //assign courses to student based on student`s specialty
    public void addStudentToCourses(Student__c[] students){
        Set<Id> specialtyId = new Set<Id>();
        List<Course_Student__c> studentsCourses = new List<Course_Student__c>();
        
        for(Course__c course : [SELECT Specialty__c, Id, Name, Code__c 
                                FROM Course__c ])
        {

            for(Student__c student : students){
                if(student.Specialty__c == course.Specialty__c){
                    studentsCourses.add(new Course_Student__c(Name = student.Name + '_'+ course.Code__c,
                                                                   Student__c = student.Id,
                                                                   Course__c = course.Id));
                    
                }
            }
        }
        
        system.debug(Database.insert(studentsCourses, false));
        
    }
}
