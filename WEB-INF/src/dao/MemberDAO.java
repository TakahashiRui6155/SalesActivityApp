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
    
    public Member findById(int id) throws Exception {

        Member member = null;

        String sql = "SELECT id, name, furigana, employee_no, department, position, role "
                   + "FROM members "
                   + "WHERE id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    member = new Member();

                    member.setId(rs.getInt("id"));
                    member.setName(rs.getString("name"));
                    member.setFurigana(rs.getString("furigana"));
                    member.setEmployeeNo(rs.getInt("employee_no"));
                    member.setDepartment(rs.getString("department"));
                    member.setPosition(rs.getString("position"));
                    member.setRole(rs.getString("role"));
                }
            }
        }

        return member;
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
    
    public int update(Member member) throws Exception {

        String sql = "UPDATE members "
                   + "SET name = ?, "
                   + "furigana = ?, "
                   + "employee_no = ?, "
                   + "department = ?, "
                   + "position = ? "
                   + "WHERE id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, member.getName());
            ps.setString(2, member.getFurigana());
            ps.setInt(3, member.getEmployeeNo());
            ps.setString(4, member.getDepartment());
            ps.setString(5, member.getPosition());
            ps.setInt(6, member.getId());

            return ps.executeUpdate();
        }
    }
    
    public int delete(int id) throws Exception {

        String sql = "DELETE FROM members WHERE id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate();
        }
    }
}