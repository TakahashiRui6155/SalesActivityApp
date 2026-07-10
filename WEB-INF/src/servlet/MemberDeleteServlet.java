package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;

@WebServlet("/memberDelete")
public class MemberDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        MemberDAO memberDAO = new MemberDAO();

        try {
            memberDAO.delete(id);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect(
                request.getContextPath() + "/memberList");
    }
}
