<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Activity App ログイン</title>

<style>

body{
    font-family: Arial, "メイリオ", sans-serif;
    background-color:#f4f6f9;
}

.container{
    width:420px;
    margin:80px auto;
    padding:40px;
    background:#ffffff;
    border-radius:12px;
    box-shadow:0 2px 10px rgba(0,0,0,0.15);
}

h2{
    text-align:center;
    margin-bottom:35px;
    font-size:32px;
}

table{
    width:100%;
}

td{
    padding:10px;
}

input[type=text],
input[type=password]{
    width:100%;
    height:42px;
    padding:8px;
    font-size:15px;
    box-sizing:border-box;
}

button{
    width:100%;
    height:45px;
    background:#007bff;
    color:white;
    border:none;
    border-radius:6px;
    font-size:16px;
    font-weight:bold;
    cursor:pointer;
}

button:hover{
    background:#0056b3;
}

.register-button{
    display:block;
    width:100%;
    margin-top:15px;
    padding:12px;

    background:#28a745;
    color:#ffffff;

    text-align:center;
    text-decoration:none;

    border-radius:6px;

    font-size:16px;
    font-weight:bold;

    box-sizing:border-box;
}

.register-button:hover{
    background:#218838;
}

.error{
    color:red;
    text-align:center;
    margin-bottom:15px;
    font-weight:bold;
}

</style>

</head>

<body>

<div class="container">

<h2>ログイン</h2>

<%
String error = (String)request.getAttribute("error");
if(error != null){
%>

<p class="error"><%= error %></p>

<%
}
%>

<form action="<%=request.getContextPath()%>/login" method="post">

<table>

<tr>
    <td>社員番号</td>
    <td>
        <input type="text" name="employeeNo">
    </td>
</tr>

<tr>
    <td>パスワード</td>
    <td>
        <input type="password" name="password">
    </td>
</tr>

<tr>
    <td colspan="2">
        <button type="submit">ログイン</button>
    </td>
</tr>

</table>

</form>

<a class="register-button"
   href="<%=request.getContextPath()%>/MemberRegisterServlet">
    会員登録
</a>

</div>

</body>
</html>