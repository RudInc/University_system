trigger FlowTrigger on Flow__c (before insert) {
    if(Trigger.isInsert&&Trigger.isBefore){
        FlowTriggerHandler.setFlowName(Trigger.New);
    }
}