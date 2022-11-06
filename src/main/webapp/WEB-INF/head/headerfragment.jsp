<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User authUser = (User) request.getAttribute("AuthUser");
    String home = request.getContextPath();
%>

<head>
    <meta charset="UTF-8"/>
    <title>JSP basics</title>
    <link rel="stylesheet" href="<%=home%>/css/style.css">

    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</head>


<div>
    <nav>
        <div>
            <a href="<%=home%>" style="margin-left: 10px">Java Server Pages</a>
            <ul class="right hide-on-med-and-down">

                <li>
                    <a href="<%=home%>/profile">
                        <%--Если пользователь авторизован меняем текст логин на профиль--%>
                        <%if (authUser == null) {%>
                        Login
                        <%} else {%>
                        Profile
                        <%}%>

                    </a>
                </li>

                <%--Если пользователь авторизован выключаем регистрацию--%>
                <%if (authUser == null) {%>
                <li>
                    <a href="<%=home%>/registration">
                        Registration
                    </a>
                </li>
                <%}%>
            </ul>
        </div>
    </nav>
</div>