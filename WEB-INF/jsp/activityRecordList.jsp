<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ActivityRecord" %>

<%
    List<ActivityRecord> activityList =
        (List<ActivityRecord>) request.getAttribute("activityList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>営業成績一覧</title>
</head>
<body>

<h2>営業成績一覧</h2>

<table border="1">
    <tr>
        <th>記録日</th>
        <th>担当者</th>
        <th>活動件数</th>
        <th>活動目標</th>
        <th>訪問商談</th>
        <th>電話商談</th>
        <th>メール返信</th>
        <th>アポ件数</th>
        <th>操作</th>
    </tr>

    <% if (activityList != null) { %>

        <% for (ActivityRecord activity : activityList) { %>

            <tr>
                <td><%= activity.getRecordDate() %></td>
                <td><%= activity.getMemberName() %></td>
                <td><%= activity.getActivityCount() %></td>
                <td><%= activity.getActivityGoal() %></td>
                <td><%= activity.getVisitConversationCount() %></td>
                <td><%= activity.getPhoneConversationCount() %></td>
                <td><%= activity.getEmailResponseCount() %></td>
                <td><%= activity.getApCount() %></td>
                <td>
                   <form action="<%= request.getContextPath() %>/activity-record-edit"
                         method="get"
                         style="display:inline;">

                        <input type="hidden"
                                name="id"
                                value="<%= activity.getId() %>">

                        <button type="submit">編集</button>
                   </form>

                   <form action="<%= request.getContextPath() %>/activity-record-delete"
                         method="get"
                         style="display:inline;"
                         onsubmit="return confirm('この営業成績を削除しますか？');">

                        <input type="hidden"
                               name="id"
                               value="<%= activity.getId() %>">

                        <button type="submit">削除</button>
                   </form>
                </td>
            </tr>

        <% } %>

    <% } %>
</table>

<br><br>

<form action="<%= request.getContextPath() %>/activity-record"
      method="get"
      style="display:inline;">

    <button type="submit">
        営業成績登録
    </button>

</form>

<form action="<%= request.getContextPath() %>/activity-ranking"
      method="get"
      style="display:inline;">

    <button type="submit">
        営業成績ランキング
    </button>

</form>

<form action="<%= request.getContextPath() %>/memberList"
      method="get"
      style="display:inline;">

    <button type="submit">
        会員一覧へ戻る
    </button>

</form>


</body>
</html>