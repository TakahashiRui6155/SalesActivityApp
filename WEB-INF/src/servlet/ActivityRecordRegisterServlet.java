package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ActivityRecordDAO;
import model.ActivityRecord;

@WebServlet("/activity-record-register")
public class ActivityRecordRegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(
			HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		int memberId = Integer.parseInt(request.getParameter("memberId"));
		System.out.println("登録するmemberId = " + memberId);

		java.sql.Date recordDate =
		        java.sql.Date.valueOf(request.getParameter("recordDate"));

		java.sql.Date periodStart =
		        java.sql.Date.valueOf(request.getParameter("periodStart"));

		java.sql.Date periodEnd =
		        java.sql.Date.valueOf(request.getParameter("periodEnd"));

		int activityCount =
		        Integer.parseInt(request.getParameter("activityCount"));

		int activityGoal =
		        Integer.parseInt(request.getParameter("activityGoal"));

		int visitConversationCount =
		        Integer.parseInt(request.getParameter("visitConversationCount"));

		int phoneConversationCount =
		        Integer.parseInt(request.getParameter("phoneConversationCount"));

		int emailResponseCount =
		        Integer.parseInt(request.getParameter("emailResponseCount"));

		int apCount =
		        Integer.parseInt(request.getParameter("apCount"));

		int apGoal =
		        Integer.parseInt(request.getParameter("apGoal"));
		
		ActivityRecord activityRecord = new ActivityRecord();

		activityRecord.setMemberId(memberId);
		activityRecord.setRecordDate(recordDate);
		activityRecord.setPeriodStart(periodStart);
		activityRecord.setPeriodEnd(periodEnd);
		activityRecord.setActivityCount(activityCount);
		activityRecord.setActivityGoal(activityGoal);
		activityRecord.setVisitConversationCount(visitConversationCount);
		activityRecord.setPhoneConversationCount(phoneConversationCount);
		activityRecord.setEmailResponseCount(emailResponseCount);
		activityRecord.setApCount(apCount);
		activityRecord.setApGoal(apGoal);

		ActivityRecordDAO dao = new ActivityRecordDAO();
		
		try {
			dao.insert(activityRecord);
		} catch (Exception e) {
			throw new ServletException(e);
		}

		response.sendRedirect(
			    request.getContextPath() + "/activity-record-list"
	    );

	}
}