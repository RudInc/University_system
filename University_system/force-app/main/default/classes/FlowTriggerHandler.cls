public with sharing class FlowTriggerHandler {
    public FlowTriggerHandler() {

    }
    //set name of flow to standartForm
    public static void  setFlowName(List<Flow__c> flows){
        Set<Id> specialtyIdSet = new Set<Id>();
        for(Flow__c flow : flows){
            specialtyIdSet.add(flow.Specialty__c);
        }
        Map<Id, Specialty__c> specialtyCodeMap = new Map<Id, Specialty__c>([SELECT Code__c 
                                                                            FROM Specialty__c 
                                                                            WHERE Id in: specialtyIdSet]); 
        for(Flow__c flow : flows){
            flow.Name = flow.Start_Date__c.year() + specialtyCodeMap.get(flow.Specialty__c).Code__c;
            if(flow.Format_of_education__c == 'Distance'){
                flow.Name +='d';
            }
        }
    }
    
}
