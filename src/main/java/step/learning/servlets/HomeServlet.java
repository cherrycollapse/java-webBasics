package step.learning.servlets;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import step.learning.services.DataService;
import step.learning.services.EmailService;
import step.learning.services.hash.MD5HashService;
import step.learning.services.hash.Sha1HashService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


//@WebServlet("/")
@Singleton
public class HomeServlet extends HttpServlet
{

    @Inject
    private EmailService emailService;

    MD5HashService MD5 = new MD5HashService();
    Sha1HashService Sha1 = new Sha1HashService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String HashInput = req.getParameter( "HashInput" ) ;
        System.out.println(req.getParameter( "HashInput" ));
        req.setAttribute("HashInputMD5", MD5.hash(HashInput));
        req.setAttribute("HashInputSha1", Sha1.hash(HashInput));
        req.getRequestDispatcher("WEB-INF/index.jsp").forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req,HttpServletResponse resp ) throws ServletException, IOException {

        //region DataCount
        DataService dataService = (DataService)req.getAttribute("DataService");
        String dbElement;

        try (Statement stat = dataService.getConnection().createStatement();
             ResultSet res = stat.executeQuery("SELECT COUNT(*) FROM randoms2");)
        {
            if(res.next()) {
                dbElement = "Amount of elements " + res.getInt(1);
            }
            else {
                dbElement = "No data";
            }
        }
        catch(SQLException ex) {
            dbElement = "Error " + ex.getMessage();
        }

        List<String> elements = new ArrayList<>();
        try (Statement stat = dataService.getConnection().createStatement();
             ResultSet res = stat.executeQuery("SELECT * FROM randoms2");)
        {
            while(res.next()){
                elements.add("Id: "+res.getString("id") + ".  "
                        + res.getString("numint") + " | "
                        + res.getString("numfloat")+ " | "
                        + res.getString("str") + " | "
                        + res.getString("datatime") + "."
                );
            }
        }
        catch(SQLException ex) {
            dbElement = "Error " + ex.getMessage();
        }

        req.setAttribute("count", dbElement);
        req.setAttribute("elements", elements.toArray(new String[0]));
        //endregion

        req.getRequestDispatcher("WEB-INF/index.jsp").forward(req,resp);
    }




}