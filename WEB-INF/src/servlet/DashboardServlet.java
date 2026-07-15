package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ActivityRecordDAO;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * ブラウザにダッシュボード画面を保存させない設定。
         * ログアウト後に戻るボタンを押したとき、
         * 古いダッシュボード画面が表示されるのを防ぐ。
         */
        response.setHeader(
                "Cache-Control",
                "no-cache, no-store, must-revalidate");

        response.setHeader(
                "Pragma",
                "no-cache");

        response.setDateHeader(
                "Expires",
                0);

        /*
         * 現在のセッションを取得する。
         * falseを指定することで、
         * セッションが存在しない場合に新しく作成しない。
         */
        HttpSession session =
                request.getSession(false);

        /*
         * セッションが存在しない、またはログイン情報がない場合は、
         * ログイン画面へ戻す。
         */
        if (session == null
                || session.getAttribute("loginUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/loginPage");

            return;
        }

        try {
            ActivityRecordDAO dao =
                    new ActivityRecordDAO();

            int[] summary =
                    dao.getDashboardSummary();

            int totalActivityCount =
                    summary[0];

            int totalActivityGoal =
                    summary[1];

            int totalApCount =
                    summary[2];

            int totalApGoal =
                    summary[3];

            double appointmentRate = 0.0;

            if (totalActivityCount > 0) {

                appointmentRate =
                        (double) totalApCount
                        / totalActivityCount
                        * 100;

                appointmentRate =
                        Math.round(
                                appointmentRate * 100.0)
                        / 100.0;
            }

            request.setAttribute(
                    "totalActivityCount",
                    totalActivityCount);

            request.setAttribute(
                    "totalActivityGoal",
                    totalActivityGoal);

            request.setAttribute(
                    "totalApCount",
                    totalApCount);

            request.setAttribute(
                    "totalApGoal",
                    totalApGoal);

            request.setAttribute(
                    "appointmentRate",
                    appointmentRate);

            RequestDispatcher dispatcher =
                    request.getRequestDispatcher(
                            "/WEB-INF/jsp/dashboard.jsp");

            dispatcher.forward(
                    request,
                    response);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(e);
        }
    }
}