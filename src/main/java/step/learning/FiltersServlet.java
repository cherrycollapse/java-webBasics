package step.learning;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/filters")
public class FiltersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println( "Servlet - before forward");
        req.getRequestDispatcher("WEB-INF/filters.jsp").forward(req,resp);
        System.out.println( "Servlet - after forward");
    }
}
