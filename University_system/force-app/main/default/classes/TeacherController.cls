public with sharing class TeacherController {
    public TeacherController() {

    }
    @AuraEnabled
    public static List<Teacher__c> searchTeacher(String teacherName){
        try {
            return UniversityDAO.searchTeacher(teacherName);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static boolean bindTeacherToCourse(Id teacherId, Id courseId){
        try {
            return UniversityServices.bindTeacherToCourse(teacherId, courseId).isSuccess();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    //Id teacherId, Id flowId, Id courseId
    public static boolean bindTeacherToStudentsCourse(Id teacherId, Id flowId, Id courseId){
        try {
            List<Database.SaveResult> bindingResult = UniversityServices.bindTeacherToFlowCourses(teacherId, flowId, courseId);
            system.System.debug(bindingResult);
            for(Database.SaveResult result : bindingResult){
                if(!result.isSuccess()){
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
