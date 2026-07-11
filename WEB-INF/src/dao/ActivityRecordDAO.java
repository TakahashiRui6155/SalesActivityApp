package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.ActivityRecord;

public class ActivityRecordDAO {
	
	public int insert(ActivityRecord activityRecord) throws Exception {

		String sql =
		        "INSERT INTO activity_records "
		      + "(member_id, record_date, period_start, period_end, "
		      + "activity_count, activity_goal, visit_conversation_count, "
		      + "phone_conversation_count, email_response_count, ap_count, ap_goal) "
		      + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    try (
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql)
	    ) {
	    	System.out.println(
	    		    "DAOで受け取ったmemberId = " + activityRecord.getMemberId()
	    		);
	    	
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
	
	public List<ActivityRecord> findAll() throws Exception{

	    List<ActivityRecord> list = new ArrayList<>();

	    String sql = 
	            "SELECT a.*, m.name AS member_name "
	          + "FROM activity_records a "
	          + "INNER JOIN members m ON a.member_id = m.id "
	          + "ORDER BY a.record_date DESC";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {

	            ActivityRecord activity = new ActivityRecord();

	            activity.setId(rs.getInt("id"));
	            activity.setMemberId(rs.getInt("member_id"));
	            activity.setMemberName(rs.getString("member_name"));
	            activity.setRecordDate(rs.getDate("record_date"));
	            activity.setPeriodStart(rs.getDate("period_start"));
	            activity.setPeriodEnd(rs.getDate("period_end"));
	            activity.setActivityCount(rs.getInt("activity_count"));
	            activity.setActivityGoal(rs.getInt("activity_goal"));
	            activity.setVisitConversationCount(
	                    rs.getInt("visit_conversation_count"));
	            activity.setPhoneConversationCount(
	                    rs.getInt("phone_conversation_count"));
	            activity.setEmailResponseCount(
	                    rs.getInt("email_response_count"));
	            activity.setApCount(rs.getInt("ap_count"));
	            activity.setApGoal(rs.getInt("ap_goal"));

	            list.add(activity);
	        }

	    }catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

}