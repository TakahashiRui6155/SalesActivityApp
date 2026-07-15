<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会員登録</title>

<style>
body{
    font-family: Arial, sans-serif;
    background-color:#f5f5f5;
}

.container{
    width:400px;
    margin:80px auto;
    padding:30px;
    background:#ffffff;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    margin-bottom:20px;
}

input[type=text],
input[type=password]{
    width:100%;
    padding:8px;
    box-sizing:border-box;
    margin-top:5px;
}

input[type=submit]{
    width:100%;
    padding:10px;
    background:#007bff;
    color:white;
    border:none;
    border-radius:5px;
    cursor:pointer;
    font-size:15px;
}

input[type=submit]:hover{
    background:#0056b3;
}

.error-message{
    color:red;
    font-weight:bold;
    text-align:center;
    margin-bottom:20px;
}
</style>

</head>
<body>

<div class="container">

<h2>会員登録</h2>

<%
String error = (String)request.getAttribute("error");
if(error != null){
%>

<p class="error-message"><%= error %></p>

<%
}
%>

<form action="${pageContext.request.contextPath}/MemberRegisterServlet" method="post">

氏名<br>
<input type="text" name="name"><br><br>

フリガナ<br>
<input type="text" name="furigana"><br><br>

社員番号<br>
<input type="text" name="employeeNo"><br><br>

パスワード<br>
<input type="password" name="password"><br><br>

部署<br>
<input type="text" name="department"><br><br>

役職<br>
<input type="text" name="position"><br><br>

<input type="submit" value="登録">

</form>

</div>

</body>
</html>