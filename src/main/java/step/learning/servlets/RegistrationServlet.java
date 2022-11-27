package step.learning.servlets;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import step.learning.dao.UserDAO;
import step.learning.entities.User;
import step.learning.services.MimeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.UUID;

@WebServlet("/register/")   // servlet-api
@MultipartConfig            // прием multipart - данных
@Singleton
public class RegistrationServlet extends HttpServlet {
    @Inject
    private UserDAO userDAO;
    @Inject
    private MimeService mimeService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Проверяем, есть ли сохраненные в сессии данные от предыдущей обработки
        HttpSession session = req.getSession();
        String regError = (String) session.getAttribute("regError");
        String regOk = (String) session.getAttribute("regOk");

        if (regError != null) {  // сообщение об ошибке
            req.setAttribute("regError", regError);
            session.removeAttribute("regError");  // удаляем сообщение из сессии
        }

        if (regOk != null) {  // сообщение об успешной регистрации
            req.setAttribute("regOk", regOk);
            session.removeAttribute("regOk");  // удаляем сообщение из сессии
        }

        System.out.println(req.getContextPath());
        req.setAttribute("pageBody", "auth/registration.jsp");
        req.getRequestDispatcher("/WEB-INF/_layout.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // Прием данных от формы регистрации
        String userLogin = req.getParameter("Login");
        String userPassword = req.getParameter("Password");
        String confirmPassword = req.getParameter("confirmPassword");
        String userName = req.getParameter("Name");
        String userEmail = req.getParameter("Email");
        Part userAvatar = req.getPart("Avatar");  // часть, отвечающая за файл (имя - как у input)

        // Валидация данных
        String errorMessage = null;
        try {
            // Login
            if (userLogin == null || userLogin.isEmpty()) {
                throw new Exception("Login could not be empty");
            }
            if (!userLogin.equals(userLogin.trim())) {
                throw new Exception("Login could not contain trailing spaces");
            }
            if (userDAO.isLoginUsed(userLogin)) {
                throw new Exception("Login is already in use");
            }

            // Email можно использовать один и тот же email
            if (userEmail == null || userEmail.isEmpty()) {
                throw new Exception("Email could not be empty");
            }
            if (!userEmail.equals(userEmail.trim())) {
                throw new Exception("Email could not contain trailing spaces");
            }

            // Password
            if (userPassword == null || userPassword.isEmpty()) {
                throw new Exception("Password could not be empty");
            }
            if (!userPassword.equals(confirmPassword)) {
                throw new Exception("Passwords mismatch");
            }

            // Name
            if (userName == null || userName.isEmpty()) {
                throw new Exception("Name could not be empty");
            }
            if (!userName.equals(userName.trim())) {
                throw new Exception("Name could not contain trailing spaces");
            }

            // Avatar
            if (userAvatar == null) {  // такое возможно если на форме нет <input type="file" name="userAvatar"
                throw new Exception("Form integrity violation");
            }

            long size = userAvatar.getSize();
            String savedName = null;
            if (size > 0) {  // если на форме есть input, то узнать приложен ли файл можно по его размеру
                // файл приложен - обрабатываем его
                String userFilename = userAvatar.getSubmittedFileName();  // имя приложенного файла
                // отделяем расширение, проверяем на разрешенные, имя заменяем на UUID
                int dotPosition = userFilename.lastIndexOf('.');
                if (dotPosition == -1) {
                    throw new Exception("File extension required");
                }
                String extension = userFilename.substring(dotPosition);
                if (!mimeService.isImage(extension)) {
                    throw new Exception("File type unsupported");
                }
                savedName = UUID.randomUUID() + extension;


                String path = req.getServletContext().getRealPath("/");
                File file = new File(path + "img\\" + savedName);
                Files.copy(userAvatar.getInputStream(), file.toPath());
                System.out.println(userAvatar.getInputStream());
                System.out.println(file.toPath());
            }

            User user = new User();
            user.setName(userName);
            user.setLogin(userLogin);
            user.setPass(userPassword);
            user.setAvatar(savedName);
            user.setEmail(userEmail);

            if (userDAO.add(user) == null) {
                throw new Exception("User is not added. Server error, try later");
            }
        } catch (Exception ex) {
            errorMessage = ex.getMessage();
        }

        // Проверяем успешность валидации
        if (errorMessage != null) {
            // Возвращаем данные если он не прошли валидацию
            session.setAttribute("savedLogin", req.getParameter("Login"));    // Логин
            session.setAttribute("savedName", req.getParameter("Name"));    // Имя
            session.setAttribute("savedEmail", req.getParameter("Email"));  // Почта

            session.setAttribute("regError", errorMessage);
        } else {  // нет ошибок
            session.setAttribute("regOk", "Registration successful");
        }
        resp.sendRedirect(req.getRequestURI());
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//        Д.З. Обеспечить передачу изменного имени пользователя в БД,
//             со стороны HTML вывести сообщение об ошибке, если ответ от сервера будет отрицательным
//
        User changes = new User();
        User authUser = (User) req.getAttribute("AuthUser");

//        Д.З. Реализовать загрузку файла-аватарки, заменить у пользователя данные
//             ! не забыть удалить старый файл
        Part userAvatar = null;
        try {
            userAvatar = req.getPart("userAvatar");
        } catch (Exception ignored) {
        }

        String savedName = null;
        if (userAvatar != null) {
            long size = userAvatar.getSize();

            if (size > 0) {
                String userFilename = userAvatar.getSubmittedFileName();
                int dotPosition = userFilename.lastIndexOf(".");
                if (dotPosition == -1) {
                    res.getWriter().print("File extension needed");
                }

                String extension = userFilename.substring(dotPosition);
                if (!mimeService.isImage(extension)) {
                    res.getWriter().print("Invalid file extension");
                }

                savedName = UUID.randomUUID() + extension;
                String path = req.getServletContext().getRealPath("/");
                File file = new File(path + "img\\" + savedName);
                Files.copy(userAvatar.getInputStream(), file.toPath());

                // ! не забыть удалить старый файл
                File oldFile = new File(path + "img\\" + authUser.getAvatar());
                if (oldFile.delete()) {
                    System.out.println("Old avatar file has been deleted");
                }
            }
        }


        String reply;
        String login = req.getParameter("login");
        if (login != null) {
            if (userDAO.isLoginUsed(login)) {
                res.getWriter().print("Login '" + login + "' is in use");
                return;
            }
            changes.setLogin(login);
        }

        changes.setId(authUser.getId());
        changes.setName(req.getParameter("name"));
        changes.setEmail(req.getParameter("email"));

        changes.setPass(req.getParameter("password"));
        changes.setAvatar(savedName);

        reply = userDAO.updateUser(changes) ? "Update successful" : "Update error";
        res.getWriter().print(reply);
    }

}