<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="model.ActivityRanking" %>

<%
    List<ActivityRanking> rankingList =
        (List<ActivityRanking>) request.getAttribute("rankingList");

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

<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>営業成績ランキング</title>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        min-height: 100vh;
        background-color: #f4f6f9;
        color: #333333;
        font-family:
            -apple-system,
            BlinkMacSystemFont,
            "Segoe UI",
            "Hiragino Kaku Gothic ProN",
            "Yu Gothic",
            Meiryo,
            sans-serif;
    }

    .page-container {
        width: 100%;
        max-width: 1100px;
        margin: 0 auto;
        padding: 32px;
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
        margin-bottom: 24px;
    }

    .title-area h1 {
        margin: 0 0 8px;
        color: #1f2937;
        font-size: 28px;
    }

    .title-area p {
        margin: 0;
        color: #6b7280;
        font-size: 14px;
    }

    .header-buttons {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }

    .header-buttons form {
        margin: 0;
    }

    button {
        border: none;
        border-radius: 8px;
        padding: 11px 18px;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
        transition:
            opacity 0.2s,
            transform 0.2s;
    }

    button:hover {
        opacity: 0.85;
        transform: translateY(-1px);
    }

    .list-button {
        background-color: #2563eb;
        color: #ffffff;
    }

    .member-button {
        background-color: #ffffff;
        color: #374151;
        border: 1px solid #d1d5db;
    }

    .search-card {
        margin-bottom: 24px;
        padding: 24px;
        background-color: #ffffff;
        border-radius: 14px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
    }

    .search-title {
        margin: 0 0 18px;
        padding-bottom: 10px;
        color: #1f4e78;
        font-size: 18px;
        border-bottom: 2px solid #dbeafe;
    }

    .search-form {
        display: grid;
        grid-template-columns:
            minmax(160px, 1fr)
            minmax(160px, 1fr)
            minmax(220px, 1.4fr)
            auto;
        align-items: end;
        gap: 16px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    label {
        color: #374151;
        font-size: 14px;
        font-weight: bold;
    }

    input[type="date"],
    select {
        width: 100%;
        min-height: 46px;
        padding: 10px 12px;
        background-color: #ffffff;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        color: #111827;
        font-size: 16px;
        outline: none;
        transition:
            border-color 0.2s,
            box-shadow 0.2s;
    }

    input[type="date"]:focus,
    select:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
    }

    .search-button {
        min-height: 46px;
        background-color: #2563eb;
        color: #ffffff;
        white-space: nowrap;
    }

    .error-message {
        margin-bottom: 24px;
        padding: 14px 16px;
        color: #991b1b;
        background-color: #fef2f2;
        border: 1px solid #fecaca;
        border-radius: 10px;
        font-size: 14px;
    }

    .ranking-card {
        padding: 20px;
        background-color: #ffffff;
        border-radius: 14px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
    }

    .ranking-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 16px;
        margin-bottom: 16px;
    }

    .ranking-header h2 {
        margin: 0;
        color: #1f2937;
        font-size: 21px;
    }

    .period {
        padding: 7px 12px;
        background-color: #eff6ff;
        border-radius: 20px;
        color: #1d4ed8;
        font-size: 13px;
        font-weight: bold;
        white-space: nowrap;
    }

    /*
     * ランキング人数が増えた場合は、
     * 表の中だけ縦方向にスクロールします。
     *
     * スマートフォンでは横方向にもスクロールできます。
     */
    .table-scroll {
        width: 100%;
        max-height: 520px;
        overflow-x: auto;
        overflow-y: auto;
        border: 1px solid #e5e7eb;
        border-radius: 10px;
    }

    table {
        width: 100%;
        min-width: 650px;
        border-collapse: collapse;
        background-color: #ffffff;
    }

    th,
    td {
        padding: 15px 14px;
        border-bottom: 1px solid #e5e7eb;
        text-align: center;
        white-space: nowrap;
        font-size: 14px;
    }

    th {
        position: sticky;
        top: 0;
        z-index: 2;
        background-color: #1f4e78;
        color: #ffffff;
        font-weight: bold;
    }

    tbody tr:nth-child(even) {
        background-color: #f8fafc;
    }

    tbody tr:hover {
        background-color: #eef6ff;
    }

    .rank-cell {
        width: 90px;
        font-size: 17px;
        font-weight: bold;
    }

    .member-cell {
        color: #1f4e78;
        font-weight: bold;
    }

    .number-cell {
        font-variant-numeric: tabular-nums;
    }

    .value-cell {
        color: #2563eb;
        font-size: 16px;
        font-weight: bold;
    }

    .first-place {
        background-color: #fff7d6;
    }

    .second-place {
        background-color: #f1f5f9;
    }

    .third-place {
        background-color: #fff1e6;
    }

    .rank-badge {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        min-width: 44px;
        height: 34px;
        padding: 0 10px;
        border-radius: 18px;
        font-weight: bold;
    }

    .rank-1 {
        background-color: #facc15;
        color: #713f12;
    }

    .rank-2 {
        background-color: #d1d5db;
        color: #374151;
    }

    .rank-3 {
        background-color: #fdba74;
        color: #7c2d12;
    }

    .rank-normal {
        background-color: #eef2f7;
        color: #4b5563;
    }

    .no-data {
        padding: 55px 20px;
        color: #6b7280;
        text-align: center;
        font-size: 15px;
    }

    .initial-message {
        padding: 55px 20px;
        color: #6b7280;
        text-align: center;
        font-size: 15px;
    }

    @media screen and (max-width: 900px) {
        .search-form {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }

        .search-button {
            width: 100%;
        }
    }

    @media screen and (max-width: 768px) {
        .page-container {
            padding: 16px;
        }

        .page-header {
            align-items: flex-start;
            flex-direction: column;
        }

        .title-area h1 {
            font-size: 23px;
        }

        .header-buttons {
            display: grid;
            grid-template-columns: 1fr;
            width: 100%;
        }

        .header-buttons form,
        .header-buttons button {
            width: 100%;
        }

        .search-card,
        .ranking-card {
            padding: 16px 12px;
            border-radius: 10px;
        }

        .search-form {
            grid-template-columns: 1fr;
        }

        .ranking-header {
            align-items: flex-start;
            flex-direction: column;
        }

        .period {
            white-space: normal;
        }

        .table-scroll {
            max-height: 450px;
        }

        th,
        td {
            padding: 13px 10px;
            font-size: 13px;
        }
    }
</style>
</head>

<body>

<div class="page-container">

    <div class="page-header">

        <div class="title-area">
            <h1>営業成績ランキング</h1>
            <p>集計期間と評価項目を選択し、営業成績を比較できます。</p>
        </div>

        <div class="header-buttons">

            <form action="<%= request.getContextPath() %>/activity-record-list"
                  method="get">

                <button type="submit"
                        class="list-button">
                    営業成績一覧へ戻る
                </button>

            </form>

            <form action="<%= request.getContextPath() %>/dashboard"
                  method="get">

                <button type="submit"
                         class="list-button">
                   ダッシュボードへ戻る
                </button>

            </form>

        </div>

    </div>

    <div class="search-card">

        <h2 class="search-title">ランキング条件</h2>

        <form class="search-form"
              action="<%= request.getContextPath() %>/activity-ranking"
              method="get">

            <div class="form-group">

                <label for="startDate">
                    開始日
                </label>

                <input type="date"
                       id="startDate"
                       name="startDate"
                       value="<%= startDate %>"
                       required>

            </div>

            <div class="form-group">

                <label for="endDate">
                    終了日
                </label>

                <input type="date"
                       id="endDate"
                       name="endDate"
                       value="<%= endDate %>"
                       required>

            </div>

            <div class="form-group">

                <label for="rankingType">
                    ランキング種別
                </label>

                <select id="rankingType"
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

            <button type="submit"
                    class="search-button">
                ランキングを表示
            </button>

        </form>

    </div>

    <% if (errorMessage != null
            && !errorMessage.isEmpty()) { %>

        <div class="error-message">
            <%= errorMessage %>
        </div>

    <% } %>

    <div class="ranking-card">

        <div class="ranking-header">

            <h2>
                <%= rankingTitle %>
            </h2>

            <% if (!startDate.isEmpty()
                    && !endDate.isEmpty()) { %>

                <div class="period">
                    集計期間：
                    <%= startDate %>
                    ～
                    <%= endDate %>
                </div>

            <% } %>

        </div>

        <% if (rankingList != null
                && !rankingList.isEmpty()) { %>

            <div class="table-scroll">

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

                            String rowClass = "";

                            if (rank == 1) {
                                rowClass = "first-place";
                            } else if (rank == 2) {
                                rowClass = "second-place";
                            } else if (rank == 3) {
                                rowClass = "third-place";
                            }

                            String badgeClass = "rank-normal";

                            if (rank == 1) {
                                badgeClass = "rank-1";
                            } else if (rank == 2) {
                                badgeClass = "rank-2";
                            } else if (rank == 3) {
                                badgeClass = "rank-3";
                            }
                    %>

                        <tr class="<%= rowClass %>">

                            <td class="rank-cell">

                                <span class="rank-badge <%= badgeClass %>">
                                    <%= rank %>位
                                </span>

                            </td>

                            <td class="member-cell">
                                <%= ranking.getMemberName() %>
                            </td>

                            <td class="number-cell">
                                <%= ranking.getTotalActivityCount() %>
                            </td>

                            <td class="value-cell">

                                <% if ("appointmentRate".equals(rankingType)) { %>

                                    <%= String.format(
                                            "%.1f",
                                            ranking.getAppointmentRate()) %>%

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

            </div>

        <% } else if (rankingList != null) { %>

            <div class="no-data">
                指定された期間には営業成績がありません。
            </div>

        <% } else { %>

            <div class="initial-message">
                開始日・終了日・ランキング種別を選択して、
                ランキングを表示してください。
            </div>

        <% } %>

    </div>

</div>

<script>
    const startDateInput =
        document.getElementById("startDate");

    const endDateInput =
        document.getElementById("endDate");

    function updateEndDateMinimum() {

        if (!startDateInput || !endDateInput) {
            return;
        }

        endDateInput.min = startDateInput.value;

        if (endDateInput.value &&
            endDateInput.value < startDateInput.value) {

            endDateInput.value = "";
        }
    }

    if (startDateInput && endDateInput) {

        updateEndDateMinimum();

        startDateInput.addEventListener(
            "change",
            updateEndDateMinimum
        );
    }
</script>

</body>
</html>