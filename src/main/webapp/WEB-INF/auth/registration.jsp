<%-- Форма регистрации нового пользователя --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String regError = (String) request.getAttribute("regError");
    String regOk = (String) request.getAttribute("regOk");

    String savedName = (String) request.getAttribute("savedName");
    String savedLogin = (String) request.getAttribute("savedLogin");
    String savedEmail = (String) request.getAttribute("savedEmail");

    String home = request.getContextPath();
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
                            <%if (savedLogin != null) {%>
                            value="<%=savedLogin%>"
                            <%}%>
                        </div>
                    </div>

                    <!-- First Name Last Name -->
                    <div class="row">
                        <div class="input-field">
                            <label for="name">Enter First and Last Name</label>
                            <input name="Name" id="name" type="text" class="validate">
                            <%if (savedName != null) {%>
                            value="<%=savedName%>"
                            <%}%>>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="row">
                        <div class="input-field">
                            <label for="email">Enter Email</label>
                            <input name="Email" id="email" type="text" class="validate"
                                <%if(savedEmail != null){%>
                                   value="<%=savedEmail%>"
                                <%}%>>
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
                        <div class="btn">
                            <span>File</span>
                            <input name="Avatar" type="file">
                        </div>
                        <div class="file-path-wrapper">
                            <label>
                                <input class="file-path validate" type="text">
                            </label>
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