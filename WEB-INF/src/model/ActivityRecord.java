package model;

import java.sql.Date;

public class ActivityRecord {

	private int id;
	private int memberId;
	private Date recordDate;
	private Date periodStart;
	private Date periodEnd;
	private int activityCount;
	private int activityGoal;
	private int visitConversationCount;
	private int phoneConversationCount;
	private int emailResponseCount;
	private int apCount;
	private int apGoal;
	private String memberName;

	public ActivityRecord() {
	}

	public ActivityRecord(
			int id,
			int memberId,
			Date recordDate,
			Date periodStart,
			Date periodEnd,
			int activityCount,
			int activityGoal,
			int visitConversationCount,
			int phoneConversationCount,
			int emailResponseCount,
			int apCount,
			int apGoal,
			String memberName) {

		this.id = id;
		this.memberId = memberId;
		this.recordDate = recordDate;
		this.periodStart = periodStart;
		this.periodEnd = periodEnd;
		this.activityCount = activityCount;
		this.activityGoal = activityGoal;
		this.visitConversationCount = visitConversationCount;
		this.phoneConversationCount = phoneConversationCount;
		this.emailResponseCount = emailResponseCount;
		this.apCount = apCount;
		this.apGoal = apGoal;
		this.memberName = memberName;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public Date getRecordDate() {
		return recordDate;
	}

	public void setRecordDate(Date recordDate) {
		this.recordDate = recordDate;
	}

	public Date getPeriodStart() {
		return periodStart;
	}

	public void setPeriodStart(Date periodStart) {
		this.periodStart = periodStart;
	}

	public Date getPeriodEnd() {
		return periodEnd;
	}

	public void setPeriodEnd(Date periodEnd) {
		this.periodEnd = periodEnd;
	}

	public int getActivityCount() {
		return activityCount;
	}

	public void setActivityCount(int activityCount) {
		this.activityCount = activityCount;
	}

	public int getActivityGoal() {
		return activityGoal;
	}

	public void setActivityGoal(int activityGoal) {
		this.activityGoal = activityGoal;
	}

	public int getVisitConversationCount() {
		return visitConversationCount;
	}

	public void setVisitConversationCount(int visitConversationCount) {
		this.visitConversationCount = visitConversationCount;
	}

	public int getPhoneConversationCount() {
		return phoneConversationCount;
	}

	public void setPhoneConversationCount(int phoneConversationCount) {
		this.phoneConversationCount = phoneConversationCount;
	}

	public int getEmailResponseCount() {
		return emailResponseCount;
	}

	public void setEmailResponseCount(int emailResponseCount) {
		this.emailResponseCount = emailResponseCount;
	}

	public int getApCount() {
		return apCount;
	}

	public void setApCount(int apCount) {
		this.apCount = apCount;
	}

	public int getApGoal() {
		return apGoal;
	}

	public void setApGoal(int apGoal) {
		this.apGoal = apGoal;
	}
	
	public String getMemberName() {
	    return memberName;
	}

	public void setMemberName(String memberName) {
	    this.memberName = memberName;
	}
}