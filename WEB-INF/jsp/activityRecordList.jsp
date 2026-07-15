<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ActivityRecord" %>

<%
    List<ActivityRecord> activityList =
        (List<ActivityRecord>) request.getAttribute("activityList");
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>営業成績一覧</title>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
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
        max-width: 1500px;
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
        margin: 0 0 6px;
        font-size: 28px;
        color: #1f2937;
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

    .header-buttons form,
    .action-buttons form {
        margin: 0;
    }

    button {
        border: none;
        border-radius: 8px;
        padding: 10px 16px;
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

    .register-button {
        background-color: #2563eb;
        color: #ffffff;
    }

    .ranking-button {
        background-color: #7c3aed;
        color: #ffffff;
    }

    .back-button {
        background-color: #ffffff;
        color: #374151;
        border: 1px solid #d1d5db;
    }

    .table-card {
        background-color: #ffffff;
        border-radius: 14px;
        padding: 20px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
    }

    .record-count {
        margin-bottom: 14px;
        color: #6b7280;
        font-size: 14px;
    }

    /*
     * 営業成績が増えた場合は、この部分だけ縦にスクロールします。
     * 横幅が足りないスマホでは、横方向にもスクロールできます。
     */
    .table-scroll {
        width: 100%;
        max-height: 600px;
        overflow: auto;
        border: 1px solid #e5e7eb;
        border-radius: 10px;
    }

    table {
        width: 100%;
        min-width: 1050px;
        border-collapse: collapse;
        background-color: #ffffff;
    }

    th,
    td {
        padding: 14px 12px;
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

    .date-cell {
        font-weight: bold;
        color: #374151;
    }

    .member-cell {
        font-weight: bold;
        color: #1f4e78;
    }

    .number-cell {
        font-variant-numeric: tabular-nums;
    }

    .action-buttons {
        display: flex;
        justify-content: center;
        gap: 8px;
    }

    .edit-button {
        background-color: #f59e0b;
        color: #ffffff;
        padding: 8px 14px;
    }

    .delete-button {
        background-color: #dc2626;
        color: #ffffff;
        padding: 8px 14px;
    }

    .empty-message {
        padding: 50px 20px;
        color: #6b7280;
        text-align: center;
        font-size: 15px;
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
            width: 100%;
            display: grid;
            grid-template-columns: 1fr;
        }

        .header-buttons form {
            width: 100%;
        }

        .header-buttons button {
            width: 100%;
        }

        .table-card {
            padding: 12px;
            border-radius: 10px;
        }

        .table-scroll {
            max-height: 520px;
        }

        th,
        td {
            padding: 12px 10px;
            font-size: 13px;
        }

        .action-buttons {
            flex-direction: column;
        }

        .action-buttons button {
            width: 100%;
        }
    }
</style>
</head>

<body>

<div class="page-container">

    <div class="page-header">

        <div class="title-area">
            <h1>営業成績一覧</h1>
            <p>登録された営業活動の実績を確認できます。</p>
        </div>

        <div class="header-buttons">

            <form action="<%= request.getContextPath() %>/activity-record"
                  method="get">
                <button type="submit" class="register-button">
                    ＋ 営業成績登録
                </button>
            </form>

            <form action="<%= request.getContextPath() %>/activity-ranking"
                  method="get">
                <button type="submit" class="ranking-button">
                    営業成績ランキング
                </button>
            </form>

            <form action="<%= request.getContextPath() %>/dashboard"
                  method="get">

                <button type="submit" class="back-button">
                    ダッシュボードへ戻る
                </button>

            </form>

        </div>

    </div>

    <div class="table-card">

        <div class="record-count">
            登録件数：
            <strong>
                <%= activityList != null ? activityList.size() : 0 %>
            </strong>
            件
        </div>

        <% if (activityList != null && !activityList.isEmpty()) { %>

            <div class="table-scroll">

                <table>

                    <thead>
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
                    </thead>

                    <tbody>

                        <% for (ActivityRecord activity : activityList) { %>

                            <tr>

                                <td class="date-cell">
                                    <%= activity.getRecordDate() %>
                                </td>

                                <td class="member-cell">
                                    <%= activity.getMemberName() %>
                                </td>

                                <td class="number-cell">
                                    <%= activity.getActivityCount() %>
                                </td>

                                <td class="number-cell">
                                    <%= activity.getActivityGoal() %>
                                </td>

                                <td class="number-cell">
                                    <%= activity.getVisitConversationCount() %>
                                </td>

                                <td class="number-cell">
                                    <%= activity.getPhoneConversationCount() %>
                                </td>

                                <td class="number-cell">
                                    <%= activity.getEmailResponseCount() %>
                                </td>

                                <td class="number-cell">
                                    <%= activity.getApCount() %>
                                </td>

                                <td>
                                    <div class="action-buttons">

                                        <form action="<%= request.getContextPath() %>/activity-record-edit"
                                              method="get">

                                            <input type="hidden"
                                                   name="id"
                                                   value="<%= activity.getId() %>">

                                            <button type="submit"
                                                    class="edit-button">
                                                編集
                                            </button>

                                        </form>

                                        <form action="<%= request.getContextPath() %>/activity-record-delete"
                                              method="get"
                                              onsubmit="return confirm('この営業成績を削除しますか？');">

                                            <input type="hidden"
                                                   name="id"
                                                   value="<%= activity.getId() %>">

                                            <button type="submit"
                                                    class="delete-button">
                                                削除
                                            </button>

                                        </form>

                                    </div>
                                </td>

                            </tr>

                        <% } %>

                    </tbody>

                </table>

            </div>

        <% } else { %>

            <div class="empty-message">
                営業成績はまだ登録されていません。
            </div>

        <% } %>

    </div>

</div>

</body>
</html>