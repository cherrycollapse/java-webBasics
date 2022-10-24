package step.learning;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/reg")
public class RegServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();

        String login = (String) session.getAttribute("login");
        String email = (String) session.getAttribute("email");

        req.setAttribute("login", login);
        req.setAttribute("email", email);

        if (login != null || email != null)
        {
            session.removeAttribute("login");
            session.removeAttribute("email");
        }
        req.getRequestDispatcher("WEB-INF/reg.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String login = req.getParameter("login");
        String email = req.getParameter("email");

        HttpSession session = req.getSession();
        session.setAttribute("login", login);
        session.setAttribute("email", email);

        res.sendRedirect(req.getRequestURI());
    }
}