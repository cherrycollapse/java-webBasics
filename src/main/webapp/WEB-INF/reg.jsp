<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% String login = (String) request.getAttribute("login");
    String email = (String) request.getAttribute("email");
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Sign Up</title>
</head>

<body>

<button><a href="http://localhost:8080/java_webBasics_war_exploded">Home</a></button>
</br>

<% if( login != null && email != null) { %>
Email : <%=email%> | Login : <%=login%>.
<% } %>

<form method="post" action="">
    <label>Login: </label>
    <input type="text" name="login"/>
    <br/>
    <br/>
    <label>Password: </label>
    <input type="password" name="password"/>
    <br/>
    <br/>
    <label>Repeat password: </label>
    <input type="password"/>
    <br/>
    <br/>
    <label>Email: </label>
    <input type="email" name="email"/>
    <br/>
    <br/>
    <label>First Name: </label>
    <input type="text"/>
    <br/>
    <br/>
    <label>Last Name: </label>
    <input type="text"/>
    <br/>
    <br/>
    <label>Age: </label>
    <input type="number"/>
    <br/>
    <br/>

    <input type="submit" value="Submit"/>
</form>
<%--<button><a href="index.jsp">Submit</a></button>--%>
</body>

<jsp:include page="footer.jsp"></jsp:include>
</html>