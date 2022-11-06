package step.learning.filters;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import step.learning.services.DataService;
import step.learning.services.MysqlDataService;

import javax.servlet.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@Singleton
public class DataFilter implements Filter {

    //private FilterConfig filterConfig;
    private final DataService dataService ;
    private FilterConfig filterConfig ;
    @Inject
    public DataFilter( DataService dataService ) {
        this.dataService = dataService ;
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    @Override
    public void doFilter(ServletRequest servletRequest,ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        DataService dataService = new MysqlDataService();

        // Реализовать фильтр подключения к БД
        // Обеспечить переход на статическую страницу если нет подключения
        // На стартовой странице вывести данные о кол-ве записей в БД
        //  (любая таблица для примера). * - вывести данные из таблицы.

        // пытаемся получить подключение
        if(dataService.getConnection() == null){
            servletRequest.getRequestDispatcher( "WEB-INF/static.jsp" ).forward( servletRequest, servletResponse );
        }
        else {
            Connection connection = dataService.getConnection();

            ResultSet res;
            String queryRes;

            try (Statement statement = connection.createStatement()) {
                 res = statement.executeQuery("SELECT COUNT(*) FROM randoms2");

                if(res.next()) {
                    queryRes = "Entries in DB = " + res.getInt(1);
                }
                else {
                    queryRes = "No entries";
                }
            }
            catch(SQLException ex) {
                queryRes = ex.getMessage();
            }

            servletRequest.setAttribute("count", queryRes);

            servletRequest.setAttribute( "DataService", dataService ) ;
            filterChain.doFilter( servletRequest, servletResponse ) ;

        }
    }

    @Override
    public void destroy() {
        this.filterConfig = null;
    }
}