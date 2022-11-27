<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String authError = (String) request.getAttribute("AuthError");
    User authUser = (User) request.getAttribute("AuthUser");
    String home = request.getContextPath();
%>

<div class="row">
    <div style="padding: 50px;">
        <h2>Authorization</h2>

        <div class="auth-fragment">
            <% if (authUser == null) { %>
            <form method="POST" action="">

                <div>
                    <!-- Login -->
                    <div class="row">
                        <div class="input-field">
                            <input name="Login" id="log" type="text" class="validate">
                            <label for="log">Login</label>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="row">
                        <div class="input-field">
                            <input name="Password" id="pass1" type="text" class="validate">
                            <label for="pass1">Password</label>
                        </div>
                    </div>
                </div>

                <!-- Button -->
                <div class="row">
                    <a href="<%=home%>" type="submit">Cancel</a>
                    <input type="hidden" name="form-id" value="auth-form"/>
                    <button>Log In</button>
                </div>
            </form>


            <% if( authError != null ) { %>
            <span class="auth-error"><%= authError %></span>
            <% } } else { %>
            <span>Hello, </span>
            <b><%= authUser.getName() %></b>
            <a href="<%=home%>/profile" class="auth-profile-a">
                <img class="auth-fragment-avatar"
                     src="<%=home%>/image/<%=authUser.getAvatar()%>"
                     alt="<%=authUser.getLogin()%>" />
            </a>

            <!-- если почта требует подтверждения, то выводим ссылку -->
            <% if( authUser.getEmailCode() != null ) { %>
            <a href="<%=home%>/checkmail/"
               title="Почта не подтверждена, перейти на страницу подтверждения">&#x1F4E7;</a>
            <% } %>

            <a href="?logout=true">Log out</a>
            <% } %>
        </div>
    </div>
</div>