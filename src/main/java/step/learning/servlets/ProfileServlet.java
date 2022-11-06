package step.learning.servlets;

import com.google.inject.Singleton;
import step.learning.entities.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Singleton
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User authUser = (User) req.getAttribute("AuthUser");
        if (authUser == null) {
            // resp.sendRedirect( req.getContextPath() + "/register/" ) ;
            // req.setAttribute( "pageBody", "profile-unauth.jsp" ) ;

            req.setAttribute("pageBody", "auth/authfragment.jsp");
        } else {
            // req.setAttribute("pageBody", "profile.jsp");
            req.setAttribute("pageBody", "auth/profile.jsp");

        }
        req.getRequestDispatcher("/WEB-INF/_layout.jsp").forward(req, resp);
    }
}