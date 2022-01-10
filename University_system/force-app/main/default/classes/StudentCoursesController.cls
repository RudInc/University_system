public with sharing class StudentCoursesController {
    public studentCoursesController() {

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
