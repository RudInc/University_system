public with sharing class StudentController {
    public studentController() {

    }
    @AuraEnabled
    public static List<Student__c> searchStudent(String studentName){
        try {
            return UniversityDAO.searchStudent(studentName);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Course_Student__c> getCourcesOfStudent(Id studentId){
        try {
            return UniversityDAO.getCourcesOfStudent(studentId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
