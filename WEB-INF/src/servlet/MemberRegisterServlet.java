package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import dao.UserDAO;
import model.Member;
import model.User;

@WebServlet("/MemberRegisterServlet")
public class MemberRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/jsp/memberRegister.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name =
                request.getParameter("name");

        String furigana =
                request.getParameter("furigana");

        String employeeNoText =
                request.getParameter("employeeNo");

        String department =
                request.getParameter("department");

        String position =
                request.getParameter("position");

        String password =
                request.getParameter("password");

        try {
            int employeeNo =
                    Integer.parseInt(employeeNoText);
            
            MemberDAO memberDAO =
                    new MemberDAO();

            if (memberDAO.existsByEmployeeNo(employeeNo)) {

                request.setAttribute(
                        "error",
                        "その社員番号はすでに登録されています。");

                request.getRequestDispatcher(
                        "/WEB-INF/jsp/memberRegister.jsp")
                       .forward(request, response);

                return;
            }

            Member member = new Member();

            member.setName(name);
            member.setFurigana(furigana);
            member.setEmployeeNo(employeeNo);
            member.setDepartment(department);
            member.setPosition(position);
            member.setRole("USER");


            memberDAO.insert(member);

            User user = new User();

            user.setEmployeeNo(employeeNo);
            user.setPassword(password);
            user.setRole("USER");

            UserDAO userDAO =
                    new UserDAO();

            userDAO.insert(user);

            response.sendRedirect(
                    request.getContextPath()
                    + "/loginPage");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}