<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Member" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会員一覧</title>
</head>
<body>

<h1>会員一覧</h1>

<a href="<%= request.getContextPath() %>/logout">ログアウト</a>
&nbsp;&nbsp;
<a href="<%= request.getContextPath() %>/MemberRegisterServlet">新規会員登録</a>

<br><br>

<table border="1">
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

<%
    List<Member> memberList = (List<Member>) request.getAttribute("memberList");

    for (Member member : memberList) {
%>
    <tr>
        <td><%= member.getId() %></td>
        <td><%= member.getName() %></td>
        <td><%= member.getFurigana() %></td>
        <td><%= member.getEmployeeNo() %></td>
        <td><%= member.getDepartment() %></td>
        <td><%= member.getPosition() %></td>
        <td><%= member.getRole() %></td>
        <td>
        <a href="<%= request.getContextPath() %>/memberEdit?id=<%= member.getId() %>">
            編集
        </a>

        &nbsp;

        <a href="<%= request.getContextPath() %>/memberDelete?id=<%= member.getId() %>"
           onclick="return confirm('この会員を削除してもよろしいですか？');">
            削除
        </a>
    </td>
    </tr>
<%
    }
%>

</table>

</body>
</html>