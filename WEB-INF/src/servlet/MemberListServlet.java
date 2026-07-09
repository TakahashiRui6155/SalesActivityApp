package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import model.Member;

@WebServlet("/memberList")
public class MemberListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	    
    	HttpSession session = request.getSession(false);

    	if (session == null || session.getAttribute("loginUser") == null) {
    	    response.sendRedirect(request.getContextPath() + "/loginPage");
    	    return;
    	}
        
    	try {
            MemberDAO memberDAO = new MemberDAO();

            List<Member> memberList = memberDAO.findAll();

            request.setAttribute("memberList", memberList);

            request.getRequestDispatcher("/WEB-INF/jsp/memberList.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("会員一覧の取得に失敗しました。<br>");
            response.getWriter().println(e.getMessage());
        }
    }
}
