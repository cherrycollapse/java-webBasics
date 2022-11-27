<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User authUser = (User) request.getAttribute("AuthUser");
    String home = request.getContextPath();
%>

<div class="row">
    <div>
        <div style="text-align: center">
            <h5>Кабинет пользователя</h5>
        </div>

        <div class="row">
            <div class="col s5">
                <img class="profile-avatar"
                        <%if (authUser.getAvatar() != null) {%>
                     src="<%=home%>/img/<%=authUser.getAvatar()%>"
                        <%} else {%>
                     src="<%=home%>/img/user.png"
                        <%}%>
                     alt="<%=authUser.getLogin()%>"/>
            </div>


            <div class="col s7">
                <h5 class="profile-name">
                    Name : <%= authUser.getName() %>
                </h5>
                <h5>
                    Login:<%= authUser.getLogin() %>
                </h5>

                <%--                Д.З. Стилизовать элемент с почтой пользователя в личном кабинете.--%>
                <%--                Использовать разные стили для случаев когда почта подтверждена и когда нет.--%>
                <%--                Дополнить элемент ссылкой на подтверждение (если требуется)--%>
                <%--                ** вместо ссылки реализовать элемент ввода кода подтверждения почты без перехода на новую страницу--%>
                <h5 class="profile-name">
                    <span>E-mail: </span>
                    <b data-field-name="email" id="emailName"
                            <% if (authUser.getEmailCodeAttempts() > 3) { %>
                       class="email-banned"
                            <%} else if (authUser.getEmailCode() != null) { %>
                       class="email-check"
                            <%} else { %>
                       class="email-ok"
                            <%}%>
                    >
                        <%= authUser.getEmail()%>
                    </b>
                    <p hidden id="emailBanned">Your email is banned</p>

                </h5>


                <p class="profile-fieldset-avatar">
                <div class="file-field input-field">
                    <div class="btn">
                        <span>Avatar:</span>
                        <input type="file" id="avatar-input" alt="avatar-input"/>
                    </div>
                    <div class="file-path-wrapper">
                        <label for="avatar-save-button"></label>
                        <input class="file-path validate" id="avatar-save-button" alt="avatar-input" type="text"
                               placeholder="Upload files">
                    </div>
                </div>
                </p>

                <div class="profile-pass">
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

                    <button type="submit" class="btn" id="change-pass-button">Change Password</button>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col s12">
                <a href="<%=home%>" type="submit" class="btn">Go back</a>

                <a href="?logout=true" class="btn" style="float: right;">Log out</a>
            </div>
        </div>
    </div>


    <script>
        document.addEventListener("DOMContentLoaded", () => {
            // Показываем ссылку на подтверждение почты
            const nameEmail = document.getElementById("emailName")
            if (nameEmail.className === "email-banned") {
                document.getElementById("emailBanned").hidden = false;
            } else if (nameEmail.className === "email-check") {
                document.getElementById("emailConfirm").hidden = false;
            }
            const changePassButton = document.querySelector("#change-pass-button");
            if (!changePassButton) throw "'#change-pass-button' not found";
            changePassButton.addEventListener('click', changePassClick)
            const avatarSaveButton = document.querySelector("#avatar-save-button");
            if (!avatarSaveButton) throw "'#avatar-save-button' not found";
            avatarSaveButton.addEventListener('click', avatarSaveClick);
            for (let nameElement of document.querySelectorAll(".profile-name b")) {
                nameElement.addEventListener("click", nameClick);
                nameElement.addEventListener("blur", nameBlur);
                nameElement.addEventListener("keydown", nameKeydown);
            }
        });


        // Д.З. Изменение пароля: обработать ответ сервера, вывести сообщение
        // об успешном (или неуспешном) обновлении пароля.
        //     Ограничение попыток кода почты: в личном кабинете добавить к почте
        // пометку "заблокирована из-за превышения лимита ввода кода" если это так
        // (можно вместо сообщения о небходимости подтверждения).
        function changePassClick(e) {
            let passwords = e.target.parentNode.querySelectorAll('input[type="password"]');
            if (passwords[0].value !== passwords[1].value) {
                alert("Пароли не совпадают");
                passwords[0].value = passwords[1].value = '';
                return;
            }
            if (passwords[0].value.length < 3) {
                alert("Пароль слишком короткий");
                passwords[0].value = passwords[1].value = '';
                return;
            }

            fetch("/java_webBasics_war_exploded/register/?password=" + passwords[0].value, {
                method: "PUT",
                headers: {},
                body: ""
            }).then(r => r.text())
                .then(t => {
                    alert(t + " (password)"); // сообщени об успешном (или неуспешном) обновлении
                    passwords[0].value = passwords[1].value = '';
                });
        }


        function avatarSaveClick() {
            const avatarInput = document.querySelector("#avatar-input");
            if (!avatarInput) throw "'#avatar-input' not found";
            if (avatarInput.files.length === 0) {
                alert("select a file");
                return;
            }
            let formData = new FormData();
            formData.append("userAvatar", avatarInput.files[0]);
            fetch("/Java_WebBasics_war_exploded/register/", {
                method: "PUT",
                headers: {},
                body: formData  // наличие файла в formData автоматически сформирует multipart запрос
            }).then(r => r.text())
                .then(t => {
                    alert(t);
                });
        }


        function nameKeydown(e) {
            if (e.keyCode === 13) {
                e.preventDefault();
                e.target.blur();  // снять фокус ввода с элемента
                return false;
            }
        }


        function nameClick(e) {
            e.target.setAttribute("contenteditable", "true");
            e.target.focus();  // установить фокус ввода на элемент
            e.target.savedText = e.target.innerText;
        }

        function nameBlur(e) {
            e.target.removeAttribute("contenteditable");
            if (e.target.savedText !== e.target.innerText) {
                if (confirm("Сохранить изменения?")) {
                    const fieldName = e.target.getAttribute("data-field-name");
                    const url = "/Java_WebBasics_war_exploded/register/?" + fieldName + "=" + e.target.innerText;
                    // console.log( url ) ; return ;
                    fetch(url, {
                        method: "PUT",
                        headers: {},
                        body: ""
                    }).then(r => r.text())
                        .then(t => {
                            // OK / error
                            console.log(t)
                            if (t === "OK") {
                                location = location;
                            } else {
                                alert(t);
                                e.target.innerText = e.target.savedText;
                            }
                        });
                } else {
                    e.target.innerText = e.target.savedText;
                }
            }
        }
    </script>
</div>