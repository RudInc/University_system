@isTest
public with sharing class BindTeacherToFlowCoursesTest {
    @TestSetup
    static void makeData(){
        Specialty__c testSpecialty = new Specialty__c(Name='Test Specialty',
                                                      Code__c = 'Test');
        insert(testSpecialty);                                              
        Course__c testCourse = new Course__c(Name = 'Test Course',
                                             Hours__c = 90,
                                             Specialty__c = testSpecialty.Id,
                                             Code__c = 'Test');
        Flow__c testFlow = new Flow__c(Name = 'test',
                                       Start_Date__c = Date.newInstance(2000, 10, 10),
                                       Format_of_education__c = 'FullTime',
                                       Number_of_students__c = 0,
                                       Specialty__c = testSpecialty.Id);
        insert(testFlow);
        
        Teacher__c testTeacher = new Teacher__c(Full_Name__c = 'Test Teacher', 
                                                Email__c = 'teacher@test.te',
                                                Contact_phone_number__c = '999951587');
        List<Student__c> testStudents = new List<Student__c>();
        for(StudentDTO studDTO : TestDataFactory.generateStudentDTO(20)){
            testStudents.add(new Student__c(Full_Name__c = studDTO.fullName,
                                            Email__c = studDTO.email,
                                            Contact_phone_number__c = studDTO.phoneNumber,
                                            Grand__c = studDTO.grand,
                                            Flow__c = testFlow.Id,
                                            Specialty__c = testFlow.Specialty__c));
        }
        
        //insert(testSpecialty);
        //insert(testFlow);
        insert(testCourse);
        insert(testTeacher);
        insert(testStudents);
    }
    @isTest
    static void BindTeacherToFlowCourses(){
        String[] error = new String[]{
            'Uptade Course_Student__c object is not successful',
            'Expected and actual teacherIds are different'};
        Id teacherId = [SELECT Id FROM Teacher__c LIMIT 1].Id;
        Id flowId = [SELECT Id FROM Flow__c LIMIT 1].Id;
        Id courseId = [SELECT Id FROM Course__c LIMIT 1].Id;
        Test.startTest();
        List<Database.SaveResult> results = UniversityServices.bindTeacherToFlowCourses(teacherId, flowId, courseId);
        Test.stopTest();
        Set<Id> courseStudentsId = new Set<Id>();
        for(Database.SaveResult result : results){
            system.assert(result.isSuccess(),error[0]);
            courseStudentsId.add(result.getId());
        }
        List<Course_Student__c> testCourseStudents = [SELECT Id, Teacher__c
                                                      FROM Course_Student__c 
                                                      WHERE Id in:courseStudentsId];
        for(Course_Student__c testCourseStudent : testCourseStudents){
            system.assertEquals(teacherId, testCourseStudent.Teacher__c, error[1]);
        }
    }
}
