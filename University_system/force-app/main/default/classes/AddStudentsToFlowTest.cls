@isTest
public with sharing class AddStudentsToFlowTest {
    @TestSetup
    static void makeData(){
        Specialty__c testSpecialty = new Specialty__c(Name='TestSpecialty', Code__c = 'Test');
        insert (testSpecialty);
        insert (new Flow__c(Start_Date__c = Date.today(), Specialty__c = testSpecialty.Id,Format_of_education__c='FullTime'));
    }
    @isTest
    static void addOneStudentToFlow(){
        Flow__c testFlow = 
                [SELECT Id, Specialty__c
                FROM Flow__c 
                LIMIT 1];
        List<StudentDTO> testStudentsDTO = TestDataFactory.generateStudentDTO(1);
        Test.startTest();
        List<Database.SaveResult> results = UniversityServices.addStudentsToFlow(testStudentsDTO,testFlow.Id);
        Test.stopTest();
        List<Student__c> testStudents = [SELECT Flow__c, Specialty__c FROM Student__c];
        for(Student__c testStud : testStudents){
            system.debug('Student`s flow: '+ testStud.Flow__c +  'Specialty: ' +testStud.Specialty__c);
            system.assertEquals(testStud.Flow__c, testFlow.Id);
            system.assertEquals(testStud.Specialty__c, testFlow.Specialty__c);
        }
    }
    @isTest 
    static void addBulkStudentToFlow(){
        Flow__c testFlow = 
                [SELECT Id, Specialty__c
                FROM Flow__c 
                LIMIT 1];
        List<StudentDTO> testStudentsDTO = TestDataFactory.generateStudentDTO(200);
        Test.startTest();
        List<Database.SaveResult> results = UniversityServices.addStudentsToFlow(testStudentsDTO,testFlow.Id);
        Test.stopTest();
        List<Student__c> testStudents = [SELECT Flow__c, Specialty__c FROM Student__c];
        for(Student__c testStud : testStudents){
            system.debug('Student`s flow: '+ testStud.Flow__c +  'Specialty: ' +testStud.Specialty__c);
            system.assertEquals(testStud.Flow__c, testFlow.Id);
            system.assertEquals(testStud.Specialty__c, testFlow.Specialty__c);
        }
    }
}
