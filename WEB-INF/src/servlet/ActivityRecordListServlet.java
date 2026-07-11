package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ActivityRecordDAO;
import model.ActivityRecord;

@WebServlet("/activity-record-list")
public class ActivityRecordListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            ActivityRecordDAO dao = new ActivityRecordDAO();

            List<ActivityRecord> list = dao.findAll();

            request.setAttribute("activityList", list);

            request.getRequestDispatcher("/WEB-INF/jsp/activityRecordList.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}