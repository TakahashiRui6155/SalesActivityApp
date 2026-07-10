package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;

@WebServlet("/MemberUpdateServlet")
public class MemberUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String furigana = request.getParameter("furigana");
            int employeeNo =
                    Integer.parseInt(request.getParameter("employeeNo"));
            String department = request.getParameter("department");
            String position = request.getParameter("position");

            Member member = new Member();
            member.setId(id);
            member.setName(name);
            member.setFurigana(furigana);
            member.setEmployeeNo(employeeNo);
            member.setDepartment(department);
            member.setPosition(position);

            MemberDAO memberDAO = new MemberDAO();
            memberDAO.update(member);

            response.sendRedirect(
                    request.getContextPath() + "/memberList");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}