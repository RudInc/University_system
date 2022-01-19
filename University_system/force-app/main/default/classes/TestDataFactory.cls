public abstract class TestDataFactory {

    public static List<StudentDTO> generateStudentDTO(Integer quantity){
        List<StudentDTO> students = new List<StudentDTO>();
        for(Integer i = 0; i<quantity; i++){
            students.add(new StudentDTO(
                'Test'+ i,
                false,
                'test' + i+'@test.com',
                '12345678'+i
            ));
        }
        return students;
    }
    public static List<Student__c> generateStudents(Id flowId, Id specialtyId, Integer num){
        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i<num; i++){
            students.add(new Student__c(
                Full_Name__c = 'Test'+i,
                Flow__c = flowId,
                Specialty__c = specialtyId,
                Contact_Phone_Number__c = '68686868',
                Grand__c = false,
                Email__c = i+'test@email.te'

            ));
        }
        return students;
    }
    public static List<Course__c> generateCourse(Id specialtyId, Integer num){
        List<Course__c> courses = new List<Course__c>();
        for(Integer i = 0 ; i<num; i++){
            courses.add(new Course__c(
                Name='Test'+i,
                Specialty__c = specialtyId,
                Code__c = 'TE',
                Hours__c = 90
            ));
        }
        return courses;
    }
}
