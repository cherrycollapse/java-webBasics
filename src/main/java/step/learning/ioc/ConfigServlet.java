package step.learning.ioc;

import com.google.inject.servlet.ServletModule;
import step.learning.FiltersServlet;
import step.learning.HomeServlet;
import step.learning.RegServlet;
import step.learning.ViewServlet;
import step.learning.filters.*;

public class ConfigServlet extends ServletModule {
    @Override
    protected void configureServlets() {
        // Программная замена web-old.xml - конфигурация фильтров ...
        filter( "/*" ).through( CharsetFilter.class ) ;
        filter( "/*" ).through( DataFilter.class ) ;
        filter( "/*" ).through( DemoFilter.class ) ;

        // ...  и сервлетов

        serve( "/filters" ).with( FiltersServlet.class ) ;
        serve( "/servlet" ).with( ViewServlet.class ) ;
        serve( "/registration" ).with( RegServlet.class ) ;
        serve( "/" ).with( HomeServlet.class ) ;

    }
}