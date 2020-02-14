<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link rel="stylesheet" href="css/app.css">
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setHeader("Expires","0");
if(session.getAttribute("UserName")==null){
	response.sendRedirect("index.jsp");
}
%>
<header>
<nav class="menu">
<table style="width:100%;">
<tr>
 <td> <a href="home.jsp" class="menu-index"><h1>Video Detection</h1> </a></td>
   <td align="right"> <div class="links" >
  	<a  class="menu-about" ><%=session.getAttribute("UserName") %></a>
  </div></td></tr>
  </table>
</nav></header>
<form name="myForm" action="record.jsp"  class="form-group" onsubmit="return validateForm()">
    <table style="width:100%;">
        <tr>
        	<th>Record video :</th>
        	<td>
             <td><button type="submit">record</button> </td> 
        </tr>
    </table>
</form>  
<footer>
<div>
   <table style="width:100%;">
   <tr>
   <td><form action="index.jsp"><button type="submit">Logout</button></form></td>
	</tr></table>
</div></footer>
</body>
<script>
function validateForm() {
	  //var x = document.forms["myForm"]["txtTickets"].value;
	}
</script>
</html>