package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ActivityRecordDAO;
import model.ActivityRecord;

@WebServlet("/activity-record-edit")
public class ActivityRecordEditServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));

            ActivityRecordDAO dao = new ActivityRecordDAO();
            ActivityRecord activity = dao.findById(id);

            request.setAttribute("activity", activity);

            request.getRequestDispatcher("/WEB-INF/jsp/activityRecordEdit.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}