<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <title>Login page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
<%
if(session.getAttribute("UserName")!=null){
	session.removeAttribute("UserName");
}
%>
<header>
<nav class="menu">
<table><tr>
  <td><a href="index.jsp" class="menu-index"><h1>Video Detection</h1> </a></td>
  </tr>
</table>
</nav>
</header>
    <form action="LoginPage" method="post">
   <div class="container">
    <label for="txtUserName"><b>Username</b></label>
    <input type="text" placeholder="Enter Username" name="txtUserName" value="${username}"  required>

    <label for="txtPassword"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="txtPassword" required>
        
    <button type="submit">Login</button>
    
<%
if(request.getAttribute("username")!=null){ 
%>
	 <span style="color:red">you entered wrong password for username:${username}</span>
<%
}
%>
  </div> 
</form>
<form action="createuser.jsp">
</form>
</body>
</html>