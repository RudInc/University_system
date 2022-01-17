public with sharing class CourseController {
    public CourseController() {

    }
    @AuraEnabled
    public static List<Course__c> searchCourse(String courseName){
        try {
            return UniversityDAO.searchCourse(courseName);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
