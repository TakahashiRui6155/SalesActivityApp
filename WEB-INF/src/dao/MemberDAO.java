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
}