<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String pageBody = "/WEB-INF/" + request.getAttribute("pageBody");
    String home = request.getContextPath();
%>
<!doctype html >
<html>
<head>
    <meta charset="UTF-8"/>
    <!-- https://materializecss.com/ -->
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    <title>JSP</title>
</head>
<body>

<div>
    <jsp:include page="<%=pageBody%>"/>
</div>

<div>
    <jsp:include page="footer/footer.jsp"/>
</div>

</body>
</html>