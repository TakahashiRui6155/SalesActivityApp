package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ActivityRecordDAO;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ActivityRecordDAO dao = new ActivityRecordDAO();

            int[] summary = dao.getDashboardSummary();

            int totalActivityCount = summary[0];
            int totalActivityGoal = summary[1];
            int totalApCount = summary[2];
            int totalApGoal = summary[3];

            double appointmentRate = 0.0;

            if (totalActivityCount > 0) {
                appointmentRate =
                        (double) totalApCount
                        / totalActivityCount
                        * 100;
                
                appointmentRate = Math.round(appointmentRate * 100.0) / 100.0;
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

            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}