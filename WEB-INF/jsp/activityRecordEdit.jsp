<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.ActivityRecord" %>

<%
    ActivityRecord activity =
        (ActivityRecord) request.getAttribute("activity");
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>営業成績編集</title>

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
        max-width: 1000px;
        margin: 0 auto;
        padding: 32px;
    }

    .page-header {
        margin-bottom: 24px;
    }

    .page-header h1 {
        margin: 0 0 8px;
        color: #1f2937;
        font-size: 28px;
    }

    .page-header p {
        margin: 0;
        color: #6b7280;
        font-size: 14px;
    }

    .form-card {
        padding: 28px;
        background-color: #ffffff;
        border-radius: 14px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
    }

    .form-section {
        margin-bottom: 32px;
    }

    .form-section:last-of-type {
        margin-bottom: 24px;
    }

    .section-title {
        margin: 0 0 18px;
        padding-bottom: 10px;
        color: #1f4e78;
        font-size: 18px;
        border-bottom: 2px solid #dbeafe;
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 20px;
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

    .required {
        margin-left: 5px;
        color: #dc2626;
        font-size: 12px;
    }

    input[type="number"],
    input[type="date"] {
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

    input[type="number"]:focus,
    input[type="date"]:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
    }

    input[type="number"]:hover,
    input[type="date"]:hover {
        border-color: #9ca3af;
    }

    .input-note {
        margin: 0;
        color: #6b7280;
        font-size: 12px;
    }

    .button-area {
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        padding-top: 24px;
        border-top: 1px solid #e5e7eb;
    }

    button {
        min-width: 140px;
        padding: 12px 20px;
        border: none;
        border-radius: 8px;
        font-size: 15px;
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

    .update-button {
        background-color: #2563eb;
        color: #ffffff;
    }

    .back-button {
        background-color: #ffffff;
        color: #374151;
        border: 1px solid #d1d5db;
    }

    @media screen and (max-width: 768px) {
        .page-container {
            padding: 16px;
        }

        .page-header h1 {
            font-size: 23px;
        }

        .form-card {
            padding: 20px 16px;
            border-radius: 10px;
        }

        .form-grid {
            grid-template-columns: 1fr;
            gap: 16px;
        }

        .button-area {
            flex-direction: column-reverse;
        }

        .button-area button {
            width: 100%;
        }
    }
</style>
</head>

<body>

<div class="page-container">

    <div class="page-header">
        <h1>営業成績編集</h1>
        <p>登録済みの営業活動データを修正してください。</p>
    </div>

    <% if (activity != null) { %>

        <form action="<%= request.getContextPath() %>/activity-record-update"
              method="post">

            <input type="hidden"
                   name="id"
                   value="<%= activity.getId() %>">

            <div class="form-card">

                <div class="form-section">

                    <h2 class="section-title">基本情報</h2>

                    <div class="form-grid">

                        <div class="form-group">
                            <label for="memberId">
                                会員ID
                                <span class="required">必須</span>
                            </label>

                            <input type="number"
                                   id="memberId"
                                   name="memberId"
                                   min="1"
                                   value="<%= activity.getMemberId() %>"
                                   required>

                            <p class="input-note">
                                営業成績を登録した担当者の会員IDです。
                            </p>
                        </div>

                        <div class="form-group">
                            <label for="recordDate">
                                記録日
                                <span class="required">必須</span>
                            </label>

                            <input type="date"
                                   id="recordDate"
                                   name="recordDate"
                                   value="<%= activity.getRecordDate() %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="periodStart">
                                集計期間開始日
                                <span class="required">必須</span>
                            </label>

                            <input type="date"
                                   id="periodStart"
                                   name="periodStart"
                                   value="<%= activity.getPeriodStart() %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="periodEnd">
                                集計期間終了日
                                <span class="required">必須</span>
                            </label>

                            <input type="date"
                                   id="periodEnd"
                                   name="periodEnd"
                                   value="<%= activity.getPeriodEnd() %>"
                                   required>
                        </div>

                    </div>

                </div>

                <div class="form-section">

                    <h2 class="section-title">活動実績</h2>

                    <div class="form-grid">

                        <div class="form-group">
                            <label for="activityCount">
                                活動件数
                                <span class="required">必須</span>
                            </label>

                            <input type="number"
                                   id="activityCount"
                                   name="activityCount"
                                   min="0"
                                   value="<%= activity.getActivityCount() %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="activityGoal">
                                活動目標
                                <span class="required">必須</span>
                            </label>

                            <input type="number"
                                   id="activityGoal"
                                   name="activityGoal"
                                   min="0"
                                   value="<%= activity.getActivityGoal() %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="visitConversationCount">
                                訪問商談件数
                                <span class="required">必須</span>
                            </label>

                            <input type="number"
                                   id="visitConversationCount"
                                   name="visitConversationCount"
                                   min="0"
                                   value="<%= activity.getVisitConversationCount() %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="phoneConversationCount">
                                電話商談件数
                                <span class="required">必須</span>
                            </label>

                            <input type="number"
                                   id="phoneConversationCount"
                                   name="phoneConversationCount"
                                   min="0"
                                   value="<%= activity.getPhoneConversationCount() %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="emailResponseCount">
                                メール返信件数
                                <span class="required">必須</span>
                            </label>

                            <input type="number"
                                   id="emailResponseCount"
                                   name="emailResponseCount"
                                   min="0"
                                   value="<%= activity.getEmailResponseCount() %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="apCount">
                                アポイント件数
                                <span class="required">必須</span>
                            </label>

                            <input type="number"
                                   id="apCount"
                                   name="apCount"
                                   min="0"
                                   value="<%= activity.getApCount() %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="apGoal">
                                アポイント目標
                                <span class="required">必須</span>
                            </label>

                            <input type="number"
                                   id="apGoal"
                                   name="apGoal"
                                   min="0"
                                   value="<%= activity.getApGoal() %>"
                                   required>
                        </div>

                    </div>

                </div>

                <div class="button-area">

                    <button type="button"
                             class="back-button"
                             onclick="location.href='<%= request.getContextPath() %>/dashboard'">
                        ダッシュボードへ戻る
                    </button>

                    <button type="submit"
                            class="update-button">
                        変更内容を更新
                    </button>

                </div>

            </div>

        </form>

    <% } else { %>

        <div class="form-card">

            <p>編集する営業成績データを取得できませんでした。</p>

            <div class="button-area">

                <button type="button"
                         class="back-button"
                         onclick="location.href='<%= request.getContextPath() %>/dashboard'">
                    ダッシュボードへ戻る
                </button>

            </div>

        </div>

    <% } %>

</div>

<script>
    const periodStart = document.getElementById("periodStart");
    const periodEnd = document.getElementById("periodEnd");

    if (periodStart && periodEnd) {

        periodEnd.min = periodStart.value;

        periodStart.addEventListener("change", function() {

            periodEnd.min = periodStart.value;

            if (periodEnd.value &&
                periodEnd.value < periodStart.value) {

                periodEnd.value = "";
            }
        });
    }
</script>

</body>
</html>