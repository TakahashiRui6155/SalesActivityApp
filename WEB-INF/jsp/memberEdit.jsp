<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Member" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会員編集</title>
</head>
<body>
<%
    Member member = (Member) request.getAttribute("member");
%>

<h2>会員編集</h2>

<form action="<%= request.getContextPath() %>/MemberUpdateServlet" method="post">
<input type="hidden" name="id" value="<%= member.getId() %>">

氏名<br>
<input type="text" name="name"
       value="<%= member.getName() %>">
<br><br>

フリガナ<br>
<input type="text" name="furigana"
       value="<%= member.getFurigana() %>">
<br><br>

社員番号<br>
<input type="text" name="employeeNo"
       value="<%= member.getEmployeeNo() %>">
<br><br>

部署<br>
<input type="text" name="department"
       value="<%= member.getDepartment() %>">
<br><br>

役職<br>
<input type="text" name="position"
       value="<%= member.getPosition() %>">
<br><br>

<input type="submit" value="更新">


</form>

</body>
</html>