<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User authUser = (User) request.getAttribute("AuthUser");
    String home = request.getContextPath();
    String confirmOk = (String) request.getAttribute("confirm");
    String confirmError = (String) request.getAttribute("confirmError");
%>

<div style="text-align: center">
    <%if (confirmOk != null) {%>
    <div class="reg-ok"><h1><%=confirmOk%>
    </h1></div>
    <%} else {%>

    <% if (authUser == null) { /*Пользователь не авторизован*/ %>
    <h2>Авторизуйтесь (логин и пароль в верхней панеле)</h2>
    <% } else if (authUser.getEmailCode() == null) { /*подтвержднеие не требуется */ %>
    <h2>Почта подтверждна, действие не требуется</h2>
    <h3>Если вы хотите изменить почту, перейдите в <a href="<%=home%>/profile">личный кабинет</a></h3>
    <% } else if (authUser.getEmailCodeAttempts() > 3) { %>
    <h2>Превышено кол-во попыток.</h2>
    <img src="<%=home%>/img/block.jpg" alt=""/>
    <% } else {  /*подтвержднеие требуется */%>
    <h1>Подтверждаем почту</h1>
    <form>
        <!-- Email code -->
        <div class="row">
            <div class="input-field" style="width: 30%; margin: 20px auto">
                <input name="confirm" id="conf" type="text" class="validate">
                <label for="conf"> Введите код из сообщения в электронной почте</label>
                <button>Confirm</button>
            </div>
        </div>
    </form>
    <% }%>
    <%if (confirmError != null) {%>
    <div class="reg-error"><b><%=confirmError%>
    </b></div>
    <%}%>
    <%}%>
</div>
