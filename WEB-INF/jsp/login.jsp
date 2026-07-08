<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Activity App ログイン</title>
<style>
body{
    font-family: Arial, sans-serif;
    background-color:#f5f5f5;
}

.container{
    width:350px;
    margin:100px auto;
    padding:30px;
    background:#ffffff;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    margin-bottom:30px;
}

table{
    width:100%;
}

td{
    padding:8px;
}

input[type=text],
input[type=password]{
    width:100%;
    padding:8px;
    box-sizing:border-box;
}

button{
    width:100%;
    padding:10px;
    background:#007bff;
    color:white;
    border:none;
    border-radius:5px;
    cursor:pointer;
}

button:hover{
    background:#0056b3;
}

.error{
    color:red;
    text-align:center;
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
<td><input type="text" name="employeeNo"></td>
</tr>

<tr>
<td>パスワード</td>
<td><input type="password" name="password"></td>
</tr>

<tr>
<td colspan="2">
<button type="submit">ログイン</button>
</td>
</tr>

</table>

</form>

</div>

</body>
</html>