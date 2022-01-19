@isTest
private class SetFlowNameTest {
    @TestSetup
    static void makeData(){
        insert new Specialty__c(Name='TestSpecialty',Code__c = 'Test');
    }
    @isTest
    static void setNameForOneFlow(){
        Id testSpecialtyId = ([SELECT Id FROM Specialty__c LIMIT 1]).Id;
        String errorMessage = 'Flow`s name is bad';
        Test.startTest();
        insert (new Flow__c(Name='Test',
                            Format_of_education__c = 'FullTime',
                            Start_Date__c=Date.today(), 
                            Specialty__c=testSpecialtyId));
        Test.stopTest();
        Flow__c testFlow = [SELECT Name FROM Flow__c LIMIT 1];
        system.assertEquals((Date.today()).year()+'Test', testFlow.Name, errorMessage);

    }
    @isTest 
    static void setNameForManyFlows(){
        Id testSpecialtyId = ([SELECT Id FROM Specialty__c LIMIT 1]).Id;
        String errorMessage = 'Flow`s name is bad';
        List<Flow__c> testFlows = new List<Flow__c>();
        for(Integer i = 0; i<200;i++){
            testFlows.add(new Flow__c(Name='Test'+i,
                                      Format_of_education__c = 'FullTime' ,
                                      Start_Date__c=Date.today().addYears(i), 
                                      Specialty__c = testSpecialtyId));
        }
        Test.startTest();
        insert testFlows;
        Test.stopTest();
        testFlows = [SELECT Name, Start_Date__c FROM Flow__c LIMIT 200];
        for(Flow__c testFlow : testFlows){
            system.assertEquals( (testFlow.Start_Date__c.year()+'Test'), testFlow.Name, errorMessage);
        }


    }
}
