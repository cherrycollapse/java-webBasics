package step.learning.filters;

import com.google.inject.Singleton;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

// привязка фильтра через аннотацию, (аннотациями порядок фильтров не гарантируется, через xml порядок гарантирован)
// /* - подключение ко всем видам запросов
//@WebFilter( "/*" )

@Singleton
public class DemoFilter implements Filter {

    private FilterConfig filterConfig;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    @Override
    public void doFilter(                       // основной метод фильтра
            ServletRequest servletRequest,      // запрос (не http)
            ServletResponse servletResponse,    // ответ (не http)
            FilterChain filterChain)            // ссылка на "следующий" фильтр
            throws IOException, ServletException {

        System.out.println( "Filter starts" );
        // аттрибуты запросов
        servletRequest.setAttribute("DemoFilter","Filter!!!");
        filterChain.doFilter( servletRequest,servletResponse );
        System.out.println( "Filter ends" );

    }

    @Override
    public void destroy() {
        this.filterConfig = null;
    }
}