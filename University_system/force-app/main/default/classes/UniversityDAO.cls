public with sharing class UniversityDAO {
   //get specialities
   public static List<Specialty__c> getSpecialities(){
      return new List<Specialty__c>([SELECT Id, Name, Code__c 
                                       FROM Specialty__c]);
   }
   //query student`s marks 
   public static List<Course_Student__c> getCourcesOfStudent(Id studentId){
      return [SELECT Id, Name, Mark__c, Teacher__c, Course__c
              FROM Course_Student__c 
              WHERE Student__c =:studentId];
   }
   //find student by name
   public static List<Student__c> searchStudent(String studentName){
      return [SELECT Id, Name, Full_Name__c, Grand__c, Specialty__c, Flow__c, Email__c,Contact_Phone_Number__c, Co_Living__c
              FROM Student__c
              WHERE Full_Name__c LIKE :studentName];
   }
}
