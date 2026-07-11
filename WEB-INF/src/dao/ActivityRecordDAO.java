package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import model.ActivityRecord;

public class ActivityRecordDAO {
	
	public int insert(ActivityRecord activityRecord) throws Exception {

	    String sql = "INSERT INTO activity_records "
	            + "(member_id, record_date, period_start, period_end, "
	            + "activity_count, activity_goal, visit_conversation_count, "
	            + "phone_conversation_count, email_response_count, ap_count, ap_goal) "
	            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try (
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql)
	    ) {

	        ps.setInt(1, activityRecord.getMemberId());
	        ps.setDate(2, activityRecord.getRecordDate());
	        ps.setDate(3, activityRecord.getPeriodStart());
	        ps.setDate(4, activityRecord.getPeriodEnd());
	        ps.setInt(5, activityRecord.getActivityCount());
	        ps.setInt(6, activityRecord.getActivityGoal());
	        ps.setInt(7, activityRecord.getVisitConversationCount());
	        ps.setInt(8, activityRecord.getPhoneConversationCount());
	        ps.setInt(9, activityRecord.getEmailResponseCount());
	        ps.setInt(10, activityRecord.getApCount());
	        ps.setInt(11, activityRecord.getApGoal());

	        return ps.executeUpdate();
	    }
	}

}