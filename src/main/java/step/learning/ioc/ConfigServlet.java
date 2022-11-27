package step.learning.ioc;

import com.google.inject.servlet.ServletModule;
import step.learning.servlets.*;
import step.learning.filters.*;

public class ConfigServlet extends ServletModule {
    @Override
    protected void configureServlets() {
        // Программная замена web-old.xml - конфигурация фильтров ...
        filter("/*").through(CharsetFilter.class);
        filter("/*").through(DataFilter.class);
        filter("/*").through(AuthFilter.class);
        filter("/*").through(DemoFilter.class);


        // ...  и сервлетов
        serve("/filters").with(FiltersServlet.class);
        serve("/servlet").with(ViewServlet.class);
        serve("/registration/").with(RegistrationServlet.class);
        serve("/image/*").with(DownloadServlet.class);
        serve("/profile").with(ProfileServlet.class);
        serve("/checkmail/").with(CheckMailServlet.class);
        serve("/").with(HomeServlet.class);

    }
}