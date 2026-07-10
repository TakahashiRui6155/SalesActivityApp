package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;

@WebServlet("/MemberRegisterServlet")
public class MemberRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/jsp/memberRegister.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String furigana = request.getParameter("furigana");
        String employeeNoText = request.getParameter("employeeNo");
        String department = request.getParameter("department");
        String position = request.getParameter("position");

        try {
            int employeeNo = Integer.parseInt(employeeNoText);

            Member member = new Member();
            member.setName(name);
            member.setFurigana(furigana);
            member.setEmployeeNo(employeeNo);
            member.setDepartment(department);
            member.setPosition(position);
            member.setRole("USER");

            MemberDAO memberDAO = new MemberDAO();
            memberDAO.insert(member);

            response.sendRedirect(
                    request.getContextPath() + "/MemberListServlet");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
