package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.ActivityRanking;
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
	
	public ActivityRecord findById(int id) throws Exception {

	    String sql =
	            "SELECT a.*, m.name AS member_name "
	          + "FROM activity_records a "
	          + "INNER JOIN members m ON a.member_id = m.id "
	          + "WHERE a.id = ?";

	    try (
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement stmt = conn.prepareStatement(sql)
	    ) {
	        stmt.setInt(1, id);

	        try (ResultSet rs = stmt.executeQuery()) {

	            if (rs.next()) {

	                ActivityRecord activity = new ActivityRecord();

	                activity.setId(rs.getInt("id"));
	                activity.setMemberId(rs.getInt("member_id"));
	                activity.setMemberName(rs.getString("member_name"));
	                activity.setRecordDate(rs.getDate("record_date"));
	                activity.setPeriodStart(rs.getDate("period_start"));
	                activity.setPeriodEnd(rs.getDate("period_end"));
	                activity.setActivityCount(
	                        rs.getInt("activity_count"));
	                activity.setActivityGoal(
	                        rs.getInt("activity_goal"));
	                activity.setVisitConversationCount(
	                        rs.getInt("visit_conversation_count"));
	                activity.setPhoneConversationCount(
	                        rs.getInt("phone_conversation_count"));
	                activity.setEmailResponseCount(
	                        rs.getInt("email_response_count"));
	                activity.setApCount(rs.getInt("ap_count"));
	                activity.setApGoal(rs.getInt("ap_goal"));

	                return activity;
	            }
	        }
	    }

	    return null;
	}
	
	public int update(ActivityRecord activityRecord) throws Exception {

	    String sql =
	            "UPDATE activity_records SET "
	          + "member_id = ?, "
	          + "record_date = ?, "
	          + "period_start = ?, "
	          + "period_end = ?, "
	          + "activity_count = ?, "
	          + "activity_goal = ?, "
	          + "visit_conversation_count = ?, "
	          + "phone_conversation_count = ?, "
	          + "email_response_count = ?, "
	          + "ap_count = ?, "
	          + "ap_goal = ? "
	          + "WHERE id = ?";

	    try (
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql)
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
	        ps.setInt(12, activityRecord.getId());

	        return ps.executeUpdate();
	    }
	}
	
	public boolean delete(int id) {

	    String sql = "DELETE FROM activity_records WHERE id = ?";

	    try (
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql)
	    ) {

	        pstmt.setInt(1, id);

	        int result = pstmt.executeUpdate();

	        return result > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public List<ActivityRanking> findRanking(
	        Date startDate,
	        Date endDate,
	        String rankingType) throws Exception {

	    List<ActivityRanking> rankingList = new ArrayList<>();

	    String orderBy;

	    switch (rankingType) {

	    case "appointmentRate":
	        orderBy = "appointment_rate DESC";
	        break;

	    case "visit":
	        orderBy = "total_visit_count DESC";
	        break;

	    case "phone":
	        orderBy = "total_phone_count DESC";
	        break;

	    case "email":
	        orderBy = "total_email_count DESC";
	        break;

	    case "appointments":
	    default:
	        orderBy = "total_appointments DESC";
	        break;
	    }

	    String sql =
	            "SELECT "
	          + "m.id AS member_id, "
	          + "m.name AS member_name, "
	          + "SUM(ar.activity_count) AS total_activity_count, "
	          + "SUM(ar.ap_count) AS total_appointments, "
	          + "SUM(ar.visit_conversation_count) AS total_visit_count, "
	          + "SUM(ar.phone_conversation_count) AS total_phone_count, "
	          + "SUM(ar.email_response_count) AS total_email_count, "
	          + "CASE "
	          + "WHEN SUM(ar.activity_count) = 0 THEN 0 "
	          + "ELSE SUM(ar.ap_count) * 100.0 "
	          + "/ SUM(ar.activity_count) "
	          + "END AS appointment_rate "
	          + "FROM activity_records ar "
	          + "INNER JOIN members m "
	          + "ON ar.member_id = m.id "
	          + "WHERE ar.record_date BETWEEN ? AND ? "
	          + "GROUP BY m.id, m.name "
	          + "ORDER BY " + orderBy + ", "
	          + "total_activity_count DESC, "
	          + "m.id ASC";

	    try (
	        Connection connection =
	                DBConnection.getConnection();

	        PreparedStatement statement =
	                connection.prepareStatement(sql)
	    ) {

	        statement.setDate(1, startDate);
	        statement.setDate(2, endDate);

	        try (
	            ResultSet resultSet =
	                    statement.executeQuery()
	        ) {

	            while (resultSet.next()) {

	                ActivityRanking ranking =
	                        new ActivityRanking();

	                ranking.setMemberId(
	                        resultSet.getInt("member_id"));

	                ranking.setMemberName(
	                        resultSet.getString("member_name"));

	                ranking.setTotalActivityCount(
	                        resultSet.getInt(
	                                "total_activity_count"));

	                ranking.setTotalAppointments(
	                        resultSet.getInt(
	                                "total_appointments"));

	                ranking.setTotalVisitCount(
	                        resultSet.getInt(
	                                "total_visit_count"));

	                ranking.setTotalPhoneCount(
	                        resultSet.getInt(
	                                "total_phone_count"));

	                ranking.setTotalEmailCount(
	                        resultSet.getInt(
	                                "total_email_count"));

	                ranking.setAppointmentRate(
	                        resultSet.getDouble(
	                                "appointment_rate"));

	                rankingList.add(ranking);
	            }
	        }
	    }

	    return rankingList;
	}

}