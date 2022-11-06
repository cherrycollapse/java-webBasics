package step.learning.servlets;

import com.google.inject.Singleton;
import step.learning.services.hash.MD5HashService;
import step.learning.services.hash.Sha1HashService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/")
@Singleton
public class HomeServlet extends HttpServlet {
    MD5HashService MD5 = new MD5HashService();
    Sha1HashService Sha1 = new Sha1HashService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String HashInput = req.getParameter("HashInput");

        req.setAttribute("HashInputMD5", MD5.hash(HashInput));
        req.setAttribute("HashInputSha1", Sha1.hash(HashInput));

        req.getRequestDispatcher("WEB-INF/index.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/index.jsp").forward(req, resp);
    }

}