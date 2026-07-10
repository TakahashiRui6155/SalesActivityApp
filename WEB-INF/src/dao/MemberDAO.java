package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Member;

public class MemberDAO {

    public List<Member> findAll() throws Exception {

        List<Member> memberList = new ArrayList<>();

        String sql = "SELECT id, name, furigana, employee_no, department, position, role FROM members";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Member member = new Member();

                member.setId(rs.getInt("id"));
                member.setName(rs.getString("name"));
                member.setFurigana(rs.getString("furigana"));
                member.setEmployeeNo(rs.getInt("employee_no"));
                member.setDepartment(rs.getString("department"));
                member.setPosition(rs.getString("position"));
                member.setRole(rs.getString("role"));

                memberList.add(member);
            }
        }

        return memberList;
    }
    public int insert(Member member) throws Exception {

        String sql = "INSERT INTO members "
                + "(name, furigana, employee_no, department, position, role) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, member.getName());
            ps.setString(2, member.getFurigana());
            ps.setInt(3, member.getEmployeeNo());
            ps.setString(4, member.getDepartment());
            ps.setString(5, member.getPosition());
            ps.setString(6, member.getRole());

            return ps.executeUpdate();
        }
    }
}