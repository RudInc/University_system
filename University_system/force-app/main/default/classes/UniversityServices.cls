public with sharing class UniversityServices {
    //create flow
    public static Database.SaveResult createFlow(Id specialtyId, Date startDate, String formatOfEd, String flowName){
        return Database.insert(
            new Flow__c(
                Name = flowName,
                Specialty__c = specialtyId,
                Start_Date__c = startDate,
                Format_of_education__c = formatOfEd  
            ));
    }
    //create student and bind to flow
    public static List<Database.SaveResult> addStudentsToFlow(List<StudentDTO> studsDTO, Id flowId){
        Flow__c flow = [SELECT Specialty__c FROM Flow__c WHERE Id =:flowId];
        List<Student__c> students = new List<Student__c>();
        for(StudentDTO stud : studsDTO){
            students.add(new Student__c(Flow__c = flowId, 
                                        Full_Name__c = stud.fullName, 
                                        Contact_Phone_Number__c = stud.phoneNumber,
                                        Email__c = stud.email,
                                        Grand__c = stud.grand,
                                        Specialty__c = flow.Specialty__c));
        }
        return Database.insert(students, false);
    }
    //bind existed students to flow
    @future
    public static void bindStudentsToFlowAsync(Id flowId, Set<Id> studentsId){
        List<Student__c> studentsToBind = [SELECT Flow__c, Specialty__c FROM Student__c WHERE Id in: studentsId];
        Flow__c flowToBind = [SELECT Specialty__c FROM Flow__c WHERE Id=:flowId LIMIT 1];
        for(Student__c stud : studentsToBind){
            stud.Flow__c = flowId;
            stud.Specialty__c = flowToBind.Specialty__c;
        }

        update studentsToBind;
        return;
    }
    //bind Teacher to flow student_courses
    public static List<Database.SaveResult> bindTeacherToFlowCourses(Id teacherId, Id flowId, Id courseId){
        Set<Id> studentsIdSet = (new Map<Id,Student__c>([SELECT Id FROM Student__c WHERE Flow__c =:flowId])).keySet();
        List<Course_Student__c> coursesToBind = new List<Course_Student__c>([SELECT Id, Teacher__c 
                                                                            FROM Course_Student__c 
                                                                            WHERE Student__c in: studentsIdSet AND Course__c =: courseId]);
        for(Course_Student__c courseToBind: coursesToBind){
            courseToBind.Teacher__c = teacherId;
        }
        return Database.update(coursesToBind, false);
    } 
    //bind teacher to course
    public static Database.UpsertResult bindTeacherToCourse(Id teacherId, Id courseId){
        return Database.upsert(new Course_Teacher__c(Course__c = courseId, Teacher__c = teacherId));
    }   
}
