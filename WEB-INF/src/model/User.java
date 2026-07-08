package model;

public class User {

    private int id;
    private int employeeNo;
    private String password;
    private String role;

    public User() {
    }

    public User(int id, int employeeNo, String password, String role) {
        this.id = id;
        this.employeeNo = employeeNo;
        this.password = password;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public int getEmployeeNo() {
        return employeeNo;
    }

    public void setEmployeeNo(int employeeNo) {
        this.employeeNo = employeeNo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
