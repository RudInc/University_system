public with sharing class UniversityServices {
    //create flow
    public static Database.SaveResult createFlow(Id specialtyId, Date startDate, String formatOfEd, String flowName){
        return Database.insert(
            new Flow__c(
                Name = flowName,
                Specialty__c = specialtyId,
                Start_Date__c = startDate,
                Format_of_education__c = formatOfEd  
            ));
    }
    //create student and bind to flow
    public static List<Database.SaveResult> addStudentsToFlow(List<StudentDTO> studsDTO, Id flowId){
        Flow__c flow = [SELECT Specialty__c FROM Flow__c WHERE Id =:flowId];
        List<Student__c> students = new List<Student__c>();
        for(StudentDTO stud : studsDTO){
            students.add(new Student__c(Flow__c = flowId, 
                                        Full_Name__c = stud.fullName, 
                                        Contact_Phone_Number__c = stud.phoneNumber,
                                        Email__c = stud.email,
                                        Grand__c = stud.grand,
                                        Specialty__c = flow.Specialty__c));
        }
        return Database.insert(students, false);
    }
    //bind existed students to flow
    @future
    public static void bindStudentsToFlow(Id flowId, Set<Id> studentsId){
        List<Student__c> studentsToBind = [SELECT Flow__c, Specialty__c FROM Student__c WHERE Id in: studentsId];
        Flow__c flowToBind = [SELECT Specialty__c FROM Flow__c WHERE Id=:flowId LIMIT 1];
        for(Student__c stud : studentsToBind){
            stud.Flow__c = flowId;
            stud.Specialty__c = flowToBind.Specialty__c;
        }
        return;
    }
        
}
