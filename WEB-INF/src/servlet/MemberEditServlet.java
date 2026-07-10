package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;

@WebServlet("/memberEdit")
public class MemberEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idParam = request.getParameter("id");
            int id = Integer.parseInt(idParam);

            MemberDAO memberDAO = new MemberDAO();
            Member member = memberDAO.findById(id);

            if (member == null) {
                response.sendRedirect(
                        request.getContextPath() + "/memberList");
                return;
            }

            request.setAttribute("member", member);

            request.getRequestDispatcher("/WEB-INF/jsp/memberEdit.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}