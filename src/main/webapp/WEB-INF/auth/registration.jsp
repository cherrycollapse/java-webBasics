<%-- Форма регистрации нового пользователя --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String home = request.getContextPath();
    String regError = (String) request.getAttribute("regError");
    String regOk = (String) request.getAttribute("regOk");

    String savedLogin = (String) request.getAttribute("savedLogin");
    String savedName = (String) request.getAttribute("savedName");
%>

<div class="row">
    <div style="padding: 50px;">
        <h2>Sign Up</h2>

        <% if (regError != null) { %><h3 class="reg-error"><%=regError%>
    </h3><% } %>
        <% if (regOk != null) { %><h3 class="reg-ok"><%=regOk%>
    </h3><% } %>

        <div>
            <form method="POST" action="" enctype="multipart/form-data">
                <div class="form-group">

                    <!-- Login -->
                    <div class="row">
                        <div class="input-field">
                          <label for="login">Enter Login</label>
                          <input name="Login" id="login" type="text" class="validate">
                            <%if(savedLogin!=null){%>
                            value="<%=savedLogin%>"
                            <%}%>
                        </div>
                    </div>

                    <!-- First Name Last Name -->
                    <div class="row">
                        <div class="input-field">
                          <label for="name">Enter First and Last Name</label>
                          <input name="Name" id="name" type="text" class="validate">
                            <%if(savedName!=null){%>
                            value="<%=savedName%>"
                            <%}%>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="row">
                        <div class="input-field">
                          <label for="pass1">Enter Password</label>
                          <input name="Password" id="pass1" type="password" class="validate">
                        </div>
                    </div>

                    <!-- Repeat Password -->
                    <div class="row">
                        <div class="input-field">
                          <label for="pass2">Repeat password</label>
                          <input name="confirmPassword" id="pass2" type="password" class="validate">
                        </div>
                    </div>

                    <!-- Avatar -->
                    <div class="file-field input-field">
                        <div>
                            <span>File</span>
                            <input type="file">
                        </div>
                        <div>
                            <input type="text" name="Avatar">
                        </div>
                    </div>
                </div>
                <br/>
                <div>
                    <a href="<%=home%>" type="submit">Go back</a>
                    <button type="submit">Create Account</button>
                </div>
            </form>
        </div>
    </div>
</div>