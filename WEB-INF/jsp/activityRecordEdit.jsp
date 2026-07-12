<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.ActivityRecord" %>

<%
ActivityRecord activity = (ActivityRecord) request.getAttribute("activity");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>営業成績編集</title>
</head>
<body>

<h2>営業成績編集</h2>

<form action="<%=request.getContextPath()%>/activity-record-update" method="post">

    <input type="hidden" name="id" value="<%=activity.getId()%>">

    <table border="1">

        <tr>
            <th>会員ID</th>
            <td>
                <input type="number" name="memberId"
                    value="<%=activity.getMemberId()%>" required>
            </td>
        </tr>

        <tr>
            <th>記録日</th>
            <td>
                <input type="date" name="recordDate"
                    value="<%=activity.getRecordDate()%>" required>
            </td>
        </tr>

        <tr>
            <th>開始日</th>
            <td>
                <input type="date" name="periodStart"
                    value="<%=activity.getPeriodStart()%>" required>
            </td>
        </tr>

        <tr>
            <th>終了日</th>
            <td>
                <input type="date" name="periodEnd"
                    value="<%=activity.getPeriodEnd()%>" required>
            </td>
        </tr>

        <tr>
            <th>活動数</th>
            <td>
                <input type="number" name="activityCount"
                    value="<%=activity.getActivityCount()%>" required>
            </td>
        </tr>

        <tr>
            <th>活動目標</th>
            <td>
                <input type="number" name="activityGoal"
                    value="<%=activity.getActivityGoal()%>" required>
            </td>
        </tr>

        <tr>
            <th>訪問商談数</th>
            <td>
                <input type="number" name="visitConversationCount"
                    value="<%=activity.getVisitConversationCount()%>" required>
            </td>
        </tr>

        <tr>
            <th>電話商談数</th>
            <td>
                <input type="number" name="phoneConversationCount"
                    value="<%=activity.getPhoneConversationCount()%>" required>
            </td>
        </tr>

        <tr>
            <th>メール返信数</th>
            <td>
                <input type="number" name="emailResponseCount"
                    value="<%=activity.getEmailResponseCount()%>" required>
            </td>
        </tr>

        <tr>
            <th>AP数</th>
            <td>
                <input type="number" name="apCount"
                    value="<%=activity.getApCount()%>" required>
            </td>
        </tr>

        <tr>
            <th>AP目標</th>
            <td>
                <input type="number" name="apGoal"
                    value="<%=activity.getApGoal()%>" required>
            </td>
        </tr>

    </table>

    <br>

    <input type="submit" value="更新">
    <input type="button" value="戻る"
        onclick="location.href='<%=request.getContextPath()%>/activity-record-list'">

</form>

</body>
</html>