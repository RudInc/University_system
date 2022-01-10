public with sharing class UniversityDAO {
   //query student`s marks 
   public static List<Course_Student__c> getCourcesOfStudent(Id studentId){
      return [SELECT Id, Name, Mark__c 
              FROM Course_Student__c WHERE Student__c =:studentId];
   }
}
