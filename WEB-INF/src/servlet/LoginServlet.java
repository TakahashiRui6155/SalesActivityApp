package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp")
               .forward(request, response);
    }
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String employeeNoStr = request.getParameter("employeeNo");
        String password = request.getParameter("password");

        try {
            int employeeNo = Integer.parseInt(employeeNoStr);

            UserDAO userDAO = new UserDAO();
            User user = userDAO.findByEmployeeNoAndPassword(employeeNo, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loginUser", user);

                response.sendRedirect(request.getContextPath() + "/dashboard");

            } else {
                request.setAttribute("error", "社員番号またはパスワードが違います。");
                request.getRequestDispatcher("/WEB-INF/jsp/login.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "ログイン処理中にエラーが発生しました。");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp")
                   .forward(request, response);
        }
    }
}