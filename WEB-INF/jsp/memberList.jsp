<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Member" %>

<%
    List<Member> memberList =
        (List<Member>) request.getAttribute("memberList");
%>

<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>会員一覧</title>

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

    .dashboard-button {
        background-color: #0f9fb5;
        color: #ffffff;
    }

    .register-button {
        background-color: #2563eb;
        color: #ffffff;
    }

    .logout-button {
        background-color: #6b7280;
        color: #ffffff;
    }

    .table-card {
        padding: 20px;
        background-color: #ffffff;
        border-radius: 14px;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
    }

    .record-count {
        margin-bottom: 14px;
        color: #6b7280;
        font-size: 14px;
    }

    .mobile-note {
        display: none;
        margin: 0 0 12px;
        color: #6b7280;
        font-size: 13px;
    }

    /*
     * 会員数が増えた場合は表の中だけ縦スクロールします。
     * 画面幅が狭い場合は横方向にもスクロールします。
     */
    .table-scroll {
        width: 100%;
        max-height: 520px;
        overflow-x: auto;
        overflow-y: auto;
        border: 1px solid #e5e7eb;
        border-radius: 10px;
    }

    .member-table {
        width: 100%;
        min-width: 1050px;
        border-collapse: collapse;
        background-color: #ffffff;
    }

    .member-table th,
    .member-table td {
        padding: 14px 12px;
        border-bottom: 1px solid #e5e7eb;
        text-align: center;
        white-space: nowrap;
        font-size: 14px;
    }

    .member-table th {
        position: sticky;
        top: 0;
        z-index: 2;
        background-color: #1f4e78;
        color: #ffffff;
        font-weight: bold;
    }

    .member-table tbody tr:nth-child(even) {
        background-color: #f8fafc;
    }

    .member-table tbody tr:hover {
        background-color: #eef6ff;
    }

    .id-cell {
        color: #6b7280;
        font-variant-numeric: tabular-nums;
    }

    .name-cell {
        color: #1f4e78;
        font-weight: bold;
    }

    .employee-cell {
        font-variant-numeric: tabular-nums;
    }

    .role-badge {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        min-width: 76px;
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: bold;
    }

    .admin-role {
        background-color: #ede9fe;
        color: #6d28d9;
    }

    .user-role {
        background-color: #e0f2fe;
        color: #0369a1;
    }

    .operation-area {
        display: flex;
        justify-content: center;
        gap: 8px;
    }

    .operation-area form {
        margin: 0;
    }

    .edit-button,
    .delete-button {
        min-width: 58px;
        padding: 8px 14px;
    }

    .edit-button {
        background-color: #16a34a;
        color: #ffffff;
    }

    .delete-button {
        background-color: #dc2626;
        color: #ffffff;
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
            display: grid;
            grid-template-columns: 1fr;
            width: 100%;
        }

        .header-buttons form,
        .header-buttons button {
            width: 100%;
        }

        .table-card {
            padding: 12px;
            border-radius: 10px;
        }

        .mobile-note {
            display: block;
        }

        .table-scroll {
            max-height: 450px;
        }

        .member-table th,
        .member-table td {
            padding: 12px 10px;
            font-size: 13px;
        }

        .operation-area {
            flex-direction: column;
        }

        .operation-area button {
            width: 100%;
        }
    }
</style>

</head>

<body>

<div class="page-container">

    <div class="page-header">

        <div class="title-area">
            <h1>会員一覧</h1>
            <p>登録されている会員情報を確認・編集できます。</p>
        </div>

        <div class="header-buttons">

            <form action="<%= request.getContextPath() %>/dashboard"
                  method="get">

                <button type="submit"
                        class="dashboard-button">
                    ダッシュボード
                </button>

            </form>

            <form action="<%= request.getContextPath() %>/MemberRegisterServlet"
                  method="get">

                <button type="submit"
                        class="register-button">
                    ＋ 新規会員登録
                </button>

            </form>

            <form action="<%= request.getContextPath() %>/logout"
                  method="get">

                <button type="submit"
                        class="logout-button">
                    ログアウト
                </button>

            </form>

        </div>

    </div>

    <p class="mobile-note">
        表が画面に収まらない場合は、左右にスクロールできます。
    </p>

    <div class="table-card">

        <div class="record-count">
            登録件数：
            <strong>
                <%= memberList != null ? memberList.size() : 0 %>
            </strong>
            件
        </div>

        <% if (memberList != null && !memberList.isEmpty()) { %>

            <div class="table-scroll">

                <table class="member-table">

                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>氏名</th>
                            <th>フリガナ</th>
                            <th>社員番号</th>
                            <th>部署</th>
                            <th>役職</th>
                            <th>権限</th>
                            <th>操作</th>
                        </tr>
                    </thead>

                    <tbody>

                    <% for (Member member : memberList) { %>

                        <%
                            String memberRole = member.getRole();

                            String roleClass =
                                "ADMIN".equalsIgnoreCase(memberRole)
                                    ? "admin-role"
                                    : "user-role";
                        %>

                        <tr>

                            <td class="id-cell">
                                <%= member.getId() %>
                            </td>

                            <td class="name-cell">
                                <%= member.getName() %>
                            </td>

                            <td>
                                <%= member.getFurigana() %>
                            </td>

                            <td class="employee-cell">
                                <%= member.getEmployeeNo() %>
                            </td>

                            <td>
                                <%= member.getDepartment() %>
                            </td>

                            <td>
                                <%= member.getPosition() %>
                            </td>

                            <td>
                                <span class="role-badge <%= roleClass %>">
                                    <%= memberRole %>
                                </span>
                            </td>

                            <td>

                                <div class="operation-area">

                                    <form action="<%= request.getContextPath() %>/memberEdit"
                                          method="get">

                                        <input type="hidden"
                                               name="id"
                                               value="<%= member.getId() %>">

                                        <button type="submit"
                                                class="edit-button">
                                            編集
                                        </button>

                                    </form>

                                    <form action="<%= request.getContextPath() %>/memberDelete"
                                          method="get"
                                          onsubmit="return confirm('この会員を削除してもよろしいですか？');">

                                        <input type="hidden"
                                               name="id"
                                               value="<%= member.getId() %>">

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
                登録されている会員はいません。
            </div>

        <% } %>

    </div>

</div>

</body>
</html>