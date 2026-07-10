<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会員登録</title>
</head>
<body>

<h2>会員登録</h2>

<form action="${pageContext.request.contextPath}/MemberRegisterServlet" method="post">

氏名<br>
<input type="text" name="name"><br><br>

フリガナ<br>
<input type="text" name="furigana"><br><br>

社員番号<br>
<input type="text" name="employeeNo"><br><br>

部署<br>
<input type="text" name="department"><br><br>

役職<br>
<input type="text" name="position"><br><br>

<input type="submit" value="登録">

</form>

</body>
</html>