public abstract class TestDataFactory {
    public static List<StudentDTO> generateStudentDTO(Integer quantity){
        List<StudentDTO> students = new List<StudentDTO>();
        for(Integer i = 0; quantity<i; i++){
            students.add(
                'Test'+ i,
                false,
                'test' + i+'@test.com',
                '12345678'+i
            );
        }
        return students;
    }
}
