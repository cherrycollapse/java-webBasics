<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User authUser = (User) request.getAttribute("AuthUser");
    String home = request.getContextPath();
%>

<div class="row">
    <div>
        <div>
            <div>
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
                    <h5>
                        Name : <%= authUser.getName() %>
                    </h5>
                    <h5>
                       Login:<%= authUser.getLogin() %>
                    </h5>

                    <p class="profile-fieldset-avatar">
                    <form action="#">
                        <div>
                            <div>
                              Upload Avatar :
                              <input type="file" id="avatar-input" alt="avatar-input"/>
                            </div>

                            <div>
                                <input id="avatar-save-button" alt="avatar-input" type="text"
                                       placeholder="Upload files">
                            </div>
                        </div>
                    </form>
                    </p>
                </div>
            </div>

<%--          Д.З. Реализовать работу "кнопки" Log out - выход из авторизованного режима--%>
            <div class="row">
                <div class="col s6">
                    <a href="<%=home%>" type="submit">Home Page</a>
                </div>
                <div class="col s6">
                    <a href="?logout=true">Log out</a>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    document.addEventListener("DOMContentLoaded", () => {
        const avatarSaveButton = document.querySelector("#avatar-save-button");
        if (!avatarSaveButton) throw "'#avatar-save-button' not found";
        avatarSaveButton.addEventListener('click', avatarSaveClick);
        for (let nameElement of document.querySelectorAll(".profile-name b")) {
            nameElement.addEventListener("click", nameClick);
            nameElement.addEventListener("blur", nameBlur);
            nameElement.addEventListener("keydown", nameKeydown);
        }
    });

    function avatarSaveClick() {
        const avatarInput = document.querySelector("#avatar-input");
        if (!avatarInput) throw "'#avatar-input' not found";
        if (avatarInput.files.length === 0) {
            alert("select a file");
            return;
        }
        let formData = new FormData();
        formData.append("userAvatar", avatarInput.files[0]);
        fetch("/WebBasics/registration/", {
            method: "PUT",
            headers: {},
            body: formData
        }).then(r => r.text())
            .then(t => {
                console.log(t);
            });
    }

    function nameKeydown(e) {
        if (e.keyCode === 13) {
            e.preventDefault();
            e.target.blur();
            return false;
        }
    }

    function nameClick(e) {
        e.target.setAttribute("contenteditable", "true");
        e.target.focus();
        e.target.savedText = e.target.innerText;
    }

    function nameBlur(e) {
        e.target.removeAttribute("contenteditable");
        if (e.target.savedText !== e.target.innerText) {
            if (confirm("Сохранить изменения?")) {
                const fieldName = e.target.getAttribute("data-field-name");
                const url = "/WebBasics/registration/?" + fieldName + "=" + e.target.innerText;
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
