package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ActivityRecordDAO;
import model.ActivityRecord;

@WebServlet("/activity-record-update")
public class ActivityRecordUpdateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int memberId =
                    Integer.parseInt(request.getParameter("memberId"));

            Date recordDate =
                    Date.valueOf(request.getParameter("recordDate"));
            Date periodStart =
                    Date.valueOf(request.getParameter("periodStart"));
            Date periodEnd =
                    Date.valueOf(request.getParameter("periodEnd"));

            int activityCount =
                    Integer.parseInt(request.getParameter("activityCount"));
            int activityGoal =
                    Integer.parseInt(request.getParameter("activityGoal"));

            int visitConversationCount =
                    Integer.parseInt(
                            request.getParameter("visitConversationCount"));

            int phoneConversationCount =
                    Integer.parseInt(
                            request.getParameter("phoneConversationCount"));

            int emailResponseCount =
                    Integer.parseInt(
                            request.getParameter("emailResponseCount"));

            int apCount =
                    Integer.parseInt(request.getParameter("apCount"));
            int apGoal =
                    Integer.parseInt(request.getParameter("apGoal"));

            ActivityRecord activityRecord = new ActivityRecord();

            activityRecord.setId(id);
            activityRecord.setMemberId(memberId);
            activityRecord.setRecordDate(recordDate);
            activityRecord.setPeriodStart(periodStart);
            activityRecord.setPeriodEnd(periodEnd);
            activityRecord.setActivityCount(activityCount);
            activityRecord.setActivityGoal(activityGoal);
            activityRecord.setVisitConversationCount(
                    visitConversationCount);
            activityRecord.setPhoneConversationCount(
                    phoneConversationCount);
            activityRecord.setEmailResponseCount(
                    emailResponseCount);
            activityRecord.setApCount(apCount);
            activityRecord.setApGoal(apGoal);

            ActivityRecordDAO dao = new ActivityRecordDAO();
            dao.update(activityRecord);

            response.sendRedirect(
                    request.getContextPath() + "/activity-record-list");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}