public with sharing class FlowController {
    public FlowController() {

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


    public class FlowWrapper{
        public String flowName {get; set;}
        public Id specialty {get;set;}
        public Date startDate {get;set;}
        public String formatOfEd {get;set;}
    }
    public class StudentWrapper{
        public String fullName {get;set;}
        public String email {get;set;}
        public String phoneNumber {get;set;}
        public boolean grand {get;set;}
    }
}
