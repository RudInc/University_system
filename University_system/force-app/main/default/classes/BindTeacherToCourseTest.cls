@isTest
public with sharing class BindTeacherToCourseTest {
    /*
    public static List<Database.UpsertResult> bindTeacherToCourse(Id teacherId, Set<Id> coursesId){
        List<Course_Teacher__c> courseTeachers = new List<Course_Teacher__c>();
        for(Id courseId : coursesId){
            courseTeachers.add(new Course_Teacher__c(Course__c = courseId, Teacher__c = teacherId));
        }
        return Database.upsert(courseTeachers);
    }   
     */
    @TestSetup
    static void makeData(){
        Specialty__c testSpecialty = new Specialty__c(Name='Test Specialty',
                                                      Code__c='Test'); 
        insert testSpecialty;
        insert(new Teacher__c(Full_Name__c='Test Teacher',
                              Contact_phone_number__c='959494949',
                              Email__c ='test@tea.re'));
        List<Course__c> testCourses = new List<Course__c>();
        for(Integer i = 0; i<200;i++){
            testCourses.add(new Course__c(Name = 'Test'+i,
                                          Code__c = 'Code'+i,
                                          Specialty__c = testSpecialty.Id,
                                          Hours__c = 90));
        }
        insert(testCourses);
    }
    @isTest 
    static void bindTeacherToOneCourse(){
        String[] error = new String[]{
            'Upsert Course_Teacher error',
            'Course_Teacher`s TeacherId isn`t right'
        };

        Id teacherId = [SELECT Id FROM Teacher__c LIMIT 1].Id;
        Id courseId = [SELECT Id FROM Course__c LIMIT 1].Id;
        Test.startTest();
        Database.UpsertResult testResult = UniversityServices.bindTeacherToCourse(teacherId, new Set<Id>{courseId})[0];
        Test.stopTest();
        system.assert(testResult.isSuccess(),error[0]);
        Course_Teacher__c testCourseTeacher =
           [SELECT Teacher__c 
            FROM Course_Teacher__c 
            WHERE Id=:testResult.getId() 
            LIMIT 1];
        system.assertEquals(teacherId,testCourseTeacher.Teacher__c, error[1]);

    }
    @isTest
    static void bindTeacherToManyCourses(){
        String[] error = new String[]{
            'Upsert Course_Teacher error',
            'Course_Teacher`s TeacherId isn`t right'
        };
        Id teacherId = [SELECT Id FROM Teacher__c LIMIT 1].Id;
        Set<Id> coursesId = new Map<Id,Course__c>([SELECT Id FROM Course__c]).keySet();
        
        Test.startTest();
        List<Database.UpsertResult> testResults = UniversityServices.bindTeacherToCourse(teacherId,coursesId);
        Test.stopTest();
        Set<Id> courseTeachersId = new Set<Id>();
        for(Database.UpsertResult testResult : testResults){
            system.assert(testResult.isSuccess(),error[0]);
            courseTeachersId.add(testResult.getId());
        }
        for(Course_Teacher__c courseTeacher : [SELECT Teacher__c FROM Course_Teacher__c]){
            system.assertEquals(teacherId ,courseTeacher.Teacher__c, error[1]);
        }
    }
}
