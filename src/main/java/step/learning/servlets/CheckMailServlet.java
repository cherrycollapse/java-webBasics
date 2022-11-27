package step.learning.servlets;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import step.learning.dao.UserDAO;
import step.learning.entities.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Singleton
public class CheckMailServlet extends HttpServlet {

    @Inject
    private UserDAO userDAO;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

//         Д.З. Стилизовать элемент с почтой пользователя в личном кабинете.
//              Использовать разные стили для случаев когда почта подтверждена и когда нет.
//              Дополнить элемент ссылкой на подтверждение (если требуется)
//       **  вместо ссылки реализовать элемент ввода кода подтверждения почты без перехода на новую страницу

        String confirm = req.getParameter("confirm");
        String userId = req.getParameter("userid");

        if (confirm != null) {
            try {
                User user = userId == null ? (User) req.getAttribute("AuthUser") : userDAO.getUserById(userId);

                if (user == null)
                    throw new Exception("Invalid user id");
                req.setAttribute("AuthUser", user);

                if (user.getEmailCode() == null)
                    throw new Exception("Email already confirmed");

                if (!confirm.equals(user.getEmailCode())) { // код не подтвержден

                    userDAO.incEmailCodeAttempts(user);
                    throw new Exception("Invalid " + user.getEmailCodeAttempts() + " attempts code");
                }
                if (!userDAO.confirmEmail(user))
                    throw new Exception("DB error");


                req.setAttribute("confirm", "OK");  // код подтвержден
            } catch (Exception ex) {
                req.setAttribute("confirmError", ex.getMessage());
            }

        }

        req.setAttribute("pageBody", "auth/checkmail.jsp");
        req.getRequestDispatcher("/WEB-INF/_layout.jsp").forward(req, resp);
    }
}