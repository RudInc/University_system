@isTest
public with sharing class CourseStudentTriggerTest {
    @TestSetup
    static void makeData(){
        Specialty__c testSpecialty = new Specialty__c(
            Name = 'TestSpecialty',
            Code__c = 'SP');
        insert testSpecialty;
        Flow__c testFlow = new Flow__c(
            Name = 'flowTest',
            Format_of_education__c = 'FullTime',
            Number_of_students__c = 0,
            Specialty__c = testSpecialty.Id,
            Start_Date__c = Date.today());
        List<Course__c> testCourses = TestDataFactory.generateCourse(testSpecialty.Id, 200);
        insert testFlow;

    }
    @isTest
    static void setCourseStudentNameTest(){
        String error = 'Name of the Course_Student__c record is not right';
        Flow__c testFlow = [SELECT Id, Specialty__c 
                            FROM Flow__c 
                            LIMIT 1];
                  
        Test.startTest();
        insert (TestDataFactory.generateStudents(testFlow.Id, testFlow.Specialty__c,200));
        Test.stopTest();
        List<Course_Student__c> testCourses = [SELECT Name, Course__r.Name, Student__r.Full_Name__c 
                                       FROM Course_Student__c];
        for(Course_Student__c testCourse : testCourses){
            system.assertEquals(testCourse.Student__r.Full_Name__c + '_'+testCourse.Course__r.Name, testCourse.Name, error);
        }                              

    }
}
