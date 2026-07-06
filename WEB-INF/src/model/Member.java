package model;

public class Member {

    private int id;
    private String name;
    private String furigana;
    private int employeeNo;
    private String department;
    private String position;
    private String role;

    public Member() {
    }

    public Member(int id, String name, String furigana,
                  int employeeNo, String department,
                  String position, String role) {
        this.id = id;
        this.name = name;
        this.furigana = furigana;
        this.employeeNo = employeeNo;
        this.department = department;
        this.position = position;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFurigana() {
        return furigana;
    }

    public void setFurigana(String furigana) {
        this.furigana = furigana;
    }

    public int getEmployeeNo() {
        return employeeNo;
    }

    public void setEmployeeNo(int employeeNo) {
        this.employeeNo = employeeNo;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}