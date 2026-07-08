package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;

public class UserDAO {

    public User findByEmployeeNoAndPassword(int employeeNo, String password) throws Exception {

        String sql = "SELECT id, employee_no, password, role FROM users WHERE employee_no = ? AND password = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
        ) {
            ps.setInt(1, employeeNo);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    User user = new User();

                    user.setId(rs.getInt("id"));
                    user.setEmployeeNo(rs.getInt("employee_no"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));

                    return user;
                }
            }
        }

        return null;
    }
}
