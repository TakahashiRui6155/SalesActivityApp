<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="model.ActivityRanking" %>

<%
    List<ActivityRanking> rankingList =
        (List<ActivityRanking>)
        request.getAttribute("rankingList");

    String startDate =
        (String) request.getAttribute("startDate");

    String endDate =
        (String) request.getAttribute("endDate");

    String errorMessage =
        (String) request.getAttribute("errorMessage");
    
    String rankingType =
    	    (String) request.getAttribute("rankingType");

    if (rankingType == null) {
    	rankingType = "appointments";
    }

    if (startDate == null) {
        startDate = "";
    }

    if (endDate == null) {
        endDate = "";
    }
%>

<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">

<title>営業成績ランキング</title>

<style>

body {
    font-family: sans-serif;
    margin: 30px;
    background-color: #f5f5f5;
}

.container {
    max-width: 900px;
    margin: 0 auto;
    padding: 30px;
    background-color: white;
    border-radius: 8px;
}

h1 {
    margin-top: 0;
}

.search-form {
    display: flex;
    align-items: end;
    gap: 15px;
    margin-bottom: 25px;
    padding: 20px;
    background-color: #f0f3f5;
    border-radius: 6px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

input[type="date"] {
    padding: 8px;
    font-size: 16px;
}

select {
    padding: 8px;
    font-size: 16px;
}

button {
    padding: 9px 20px;
    font-size: 15px;
    cursor: pointer;
}

.error-message {
    margin-bottom: 20px;
    padding: 12px;
    color: #b00020;
    background-color: #ffe5e5;
    border: 1px solid #ffaaaa;
    border-radius: 5px;
}

.period {
    margin-bottom: 15px;
    font-weight: bold;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th,
td {
    padding: 12px;
    border: 1px solid #cccccc;
    text-align: center;
}

th {
    background-color: #eeeeee;
}

.first-place {
    font-weight: bold;
    background-color: #fff8d6;
}

.no-data {
    padding: 30px;
    text-align: center;
    color: #666666;
}

.links {
    margin-top: 25px;
}

.links a {
    margin-right: 15px;
}

</style>
</head>

<body>

<div class="container">

    <h1>営業成績ランキング</h1>

    <form
        class="search-form"
        action="<%= request.getContextPath() %>/activity-ranking"
        method="get">

        <div class="form-group">
            <label for="startDate">開始日</label>

            <input
                type="date"
                id="startDate"
                name="startDate"
                value="<%= startDate %>"
                required>
        </div>

        <div class="form-group">
            <label for="endDate">終了日</label>

            <input
                type="date"
                id="endDate"
                name="endDate"
                value="<%= endDate %>"
                required>
        </div>
        
        <div class="form-group">
            <label for="rankingType">
                ランキング種別
            </label>

            <select
                id="rankingType"
                name="rankingType">

                <option value="appointments"
                    <%= "appointments".equals(rankingType)
                    ? "selected"
                    : "" %>>
            アポ件数ランキング
        </option>

        <option value="appointmentRate"
            <%= "appointmentRate".equals(rankingType)
                    ? "selected"
                    : "" %>>
            アポ率ランキング
        </option>

        <option value="visit"
            <%= "visit".equals(rankingType)
                    ? "selected"
                    : "" %>>
            訪問件数ランキング
        </option>

        <option value="phone"
            <%= "phone".equals(rankingType)
                    ? "selected"
                    : "" %>>
            電話件数ランキング
        </option>

        <option value="email"
            <%= "email".equals(rankingType)
                    ? "selected"
                    : "" %>>
            メール件数ランキング
        </option>

    </select>
</div>

        <button type="submit">
            ランキングを表示
        </button>

    </form>

    <% if (errorMessage != null) { %>

        <div class="error-message">
            <%= errorMessage %>
        </div>

    <% } %>

    <% if (!startDate.isEmpty() && !endDate.isEmpty()) { %>

        <div class="period">
            集計期間：
            <%= startDate %>
            ～
            <%= endDate %>
        </div>

    <% } %>

    <% if (rankingList != null
            && !rankingList.isEmpty()) { %>
    
    <%
    String rankingTitle;
    String valueLabel;

    switch (rankingType) {

    case "appointmentRate":
        rankingTitle = "アポ率ランキング";
        valueLabel = "アポ率";
        break;

    case "visit":
        rankingTitle = "訪問件数ランキング";
        valueLabel = "訪問件数合計";
        break;

    case "phone":
        rankingTitle = "電話件数ランキング";
        valueLabel = "電話件数合計";
        break;

    case "email":
        rankingTitle = "メール件数ランキング";
        valueLabel = "メール件数合計";
        break;

    case "appointments":
    default:
        rankingTitle = "アポ件数ランキング";
        valueLabel = "アポ件数合計";
        break;
    }
    %>

        <table>

            <thead>
                <tr>
                    <th>順位</th>
                    <th>担当者</th>
                    <th>活動件数合計</th>
                    <th><%= valueLabel %></th>
                </tr>
            </thead>

            <tbody>

            <%
                int rank = 1;

                for (ActivityRanking ranking
                        : rankingList) {
            %>

                <tr>

                    <td class="<%= rank == 1 ? "first-place" : "" %>">
                        <%= rank %>
                    </td>

                    <td class="<%= rank == 1 ? "first-place" : "" %>">
                        <%= ranking.getMemberName() %>
                    </td>

                    <td>
                        <%= ranking.getTotalActivityCount() %>
                    </td>

                    <td class="<%= rank == 1 ? "first-place" : "" %>">

                        <% if ("appointmentRate".equals(rankingType)) { %>

                            <%= String.format("%.1f", ranking.getAppointmentRate()) %>%

                        <% } else if ("visit".equals(rankingType)) { %>

                            <%= ranking.getTotalVisitCount() %>

                        <% } else if ("phone".equals(rankingType)) { %>

                            <%= ranking.getTotalPhoneCount() %>

                        <% } else if ("email".equals(rankingType)) { %>

                            <%= ranking.getTotalEmailCount() %>

                        <% } else { %>

                            <%= ranking.getTotalAppointments() %>

                        <% } %>

                    </td>

               </tr>

            <%
                    rank++;
                }
            %>

            </tbody>

        </table>

    <% } else if (rankingList != null) { %>

        <div class="no-data">
            指定された期間には営業成績がありません。
        </div>

    <% } %>

    <div class="links">

        <a href="<%= request.getContextPath() %>/activity-record-list">
            営業成績一覧へ戻る
        </a>

        <a href="<%= request.getContextPath() %>/memberList">
            会員一覧へ戻る
        </a>

    </div>

</div>

</body>
</html>