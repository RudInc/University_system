trigger FlowTrigger on Flow__c (before insert) {
    if(Trigger.isInsert){
        FlowTriggerHandler.setFlowName(Trigger.New);
    }
}