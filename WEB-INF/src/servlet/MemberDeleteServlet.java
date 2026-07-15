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

@WebServlet("/memberDelete")
public class MemberDeleteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id =
                    Integer.parseInt(
                            request.getParameter("id"));

            MemberDAO memberDAO =
                    new MemberDAO();

            /*
             * 削除対象の会員を取得し、
             * 社員番号を確認する。
             */
            Member member =
                    memberDAO.findById(id);

            if (member != null) {

                UserDAO userDAO =
                        new UserDAO();

                /*
                 * usersテーブルを先に削除する。
                 */
                userDAO.deleteByEmployeeNo(
                        member.getEmployeeNo());

                /*
                 * users削除後にmembersを削除する。
                 */
                memberDAO.delete(id);
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/memberList");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}