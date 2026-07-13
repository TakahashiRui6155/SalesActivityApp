package model;

public class ActivityRanking {

    private int memberId;
    private String memberName;
    private int totalActivityCount;
    private int totalAppointments;
    private int totalVisitCount;
    private int totalPhoneCount;
    private int totalEmailCount;
    private double appointmentRate;

    public ActivityRanking() {
    }

    public ActivityRanking(
            int memberId,
            String memberName,
            int totalActivityCount,
            int totalAppointments) {

        this.memberId = memberId;
        this.memberName = memberName;
        this.totalActivityCount = totalActivityCount;
        this.totalAppointments = totalAppointments;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public int getTotalActivityCount() {
        return totalActivityCount;
    }

    public void setTotalActivityCount(int totalActivityCount) {
        this.totalActivityCount = totalActivityCount;
    }

    public int getTotalAppointments() {
        return totalAppointments;
    }

    public void setTotalAppointments(int totalAppointments) {
        this.totalAppointments = totalAppointments;
    }
    
    public int getTotalVisitCount() {
        return totalVisitCount;
    }

    public void setTotalVisitCount(int totalVisitCount) {
        this.totalVisitCount = totalVisitCount;
    }

    public int getTotalPhoneCount() {
        return totalPhoneCount;
    }

    public void setTotalPhoneCount(int totalPhoneCount) {
        this.totalPhoneCount = totalPhoneCount;
    }

    public int getTotalEmailCount() {
        return totalEmailCount;
    }

    public void setTotalEmailCount(int totalEmailCount) {
        this.totalEmailCount = totalEmailCount;
    }

    public double getAppointmentRate() {
        return appointmentRate;
    }

    public void setAppointmentRate(double appointmentRate) {
        this.appointmentRate = appointmentRate;
    }
}