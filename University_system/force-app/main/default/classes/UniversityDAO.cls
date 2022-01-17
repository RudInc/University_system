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
              WHERE Full_Name__c LIKE :studentName
              LIMIT 30];
   }
   //find teacher by name
   public static List<Teacher__c> searchTeacher(String teacherName){
      return [SELECT Id, Name, Full_Name__c, Contact_phone_number__c, Degree__c, Email__c
              FROM Teacher__c 
              WHERE Full_Name__c LIKE :teacherName
              LIMIT 30];
   }
   //find flow by name
   public static List<Flow__c> searchFlow(String flowName){
      return [SELECT ID, Name, Start_Date__c, End_Date__c, Format_of_education__c, Specialty__c, Number_of_students__c
              FROM Flow__c
              WHERE Name LIKE :flowName
              LIMIT 30];
   }
   //find course by name
   public static List<Course__c> searchCourse(String courseName){
      return [SELECT Id, Name, Specialty__c, Code__c, Hours__c, Credits__c 
              FROM Course__c
              WHERE Name LIKE :courseName
              LIMIT 30];
   }
   //find courses binded to flow 
   public static List<Course__c> searchFlowCourses(Flow__c flow){
      system.debug('Flow received ' + flow);
      return [SELECT Id, Name, Code__c, Hours__c 
              FROM Course__c 
              WHERE Specialty__c =:flow.Specialty__c];
   }
}
