public with sharing class StudentDTO {
    public String fullName;
    public boolean grand;
    public String email;
    public String phoneNumber;

    public StudentDTO(String fullName, boolean grand, String email, String phoneNumber) {
        this.fullName = fullName;
        this.grand = grand;
        this.email = email;
        this.phoneNumber = phoneNumber;
    }

}
