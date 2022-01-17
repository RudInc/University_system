public with sharing class FlowController {
    public FlowController() {

    }
    @AuraEnabled
    public static List<Flow__c> searchFlow(String flowName){
        try {
            return UniversityDAO.searchFlow(flowName);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Specialty__c> getSpecialities(){
        try {
            return UniversityDAO.getSpecialities();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static void createFlowWithStudents(String flow, String students){
        try {

            FlowWrapper wrappedFlow = (FlowWrapper)JSON.deserialize(flow,FlowWrapper.class);
            List<StudentWrapper> wrappedStudents = (List<StudentWrapper>)JSON.deserialize(students, List<StudentWrapper>.class);
            List<StudentDTO> studentsDTO = new List<StudentDTO>();
            //Id specialtyId, Date startDate, String formatOfEd, String flowName
            Id flowId = UniversityServices.createFlow(wrappedFlow.specialty,
                                         wrappedFlow.startDate,
                                         wrappedFlow.formatOfEd,
                                         wrappedFlow.flowName).getID();         
            system.debug(wrappedFlow);
            
            system.debug(wrappedStudents);
            for(StudentWrapper studWrapped :  wrappedStudents){
                studentsDTO.add(new StudentDTO(studWrapped.fullName, 
                                               false,  
                                               studWrapped.email,  
                                               studWrapped.phoneNumber));
            }
            system.debug(UniversityServices.addStudentsToFlow(studentsDTO,flowId));
            return ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Course__c> searchFlowCourses(String flowString){
        try {
            system.debug(flowString);
            Flow__c wrappedFlow = (Flow__c)JSON.deserialize(flowString, Flow__c.class);
            system.debug(wrappedFlow);
            /*
            return UniversityDAO.searchFlowCourses(new Flow__c(Id = wrappedFlow.flowId,
                                                               Name = wrappedFlow.flowName,
                                                               Specialty__c = wrappedFlow.specialty,
                                                               Start_Date__c = wrappedFlow.startDate,
                                                               Format_of_education__c = wrappedFlow.formatOfEd));
            */
            return UniversityDAO.searchFlowCourses(wrappedFlow);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    public class FlowWrapper{
        public Id flowId {get;set;}
        public String flowName {get; set;}
        public Id specialty {get;set;}
        public Date startDate {get;set;}
        public String formatOfEd {get;set;}
        
        public List<Flow__c> unwrapFlow(List<FlowWrapper> wrappedFlowList){
            List<Flow__c> unwrappedFlows = new List<Flow__c>();
            for(FlowWrapper wrappedFlow : wrappedFlowList){
                unwrappedFlows.add(new Flow__c(Specialty__c = wrappedFlow.specialty,
                                               Start_Date__c = wrappedFlow.startDate,
                                               Format_of_education__c = wrappedFlow.formatOfEd,
                                               Name = wrappedFlow.flowName));
            }
            return unwrappedFlows;
        }
    }
    public class StudentWrapper{
        public String fullName {get;set;}
        public String email {get;set;}
        public String phoneNumber {get;set;}
        public boolean grand {get;set;}
    }
}
