package step.learning.servlets;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import step.learning.services.MimeService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.file.Files;

@Singleton
public class DownloadServlet extends HttpServlet {
    @Inject
    private MimeService mimeService ;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestedFilename = req.getPathInfo() ;

        int dotPosition = requestedFilename.lastIndexOf( '.' ) ;
        if( dotPosition == -1 ) {
            resp.setStatus( 400 ) ;
            resp.getWriter().print( requestedFilename + ": File extension required" ) ;
            return ;
        }
        String extension = requestedFilename.substring( dotPosition ) ;
        String mimeType = mimeService.getMimeByExtension( extension ) ;
        if( mimeType == null ) {
            resp.setStatus( 400 ) ;
            resp.getWriter().print( requestedFilename + ": File extension unsupported" ) ;
            return ;
        }


        String path = req.getServletContext().getRealPath( "/" ) ;  // ....\target\WebBasics\
        File file = new File( path + "../upload" + requestedFilename ) ;
        if( file.isFile() ) {
            resp.setContentType( mimeType ) ;
            resp.setContentLengthLong( file.length() ) ;


            try( InputStream reader = Files.newInputStream( file.toPath() ) ) {
                byte[] buf = new byte[1024] ;
                int n ;
                OutputStream writer = resp.getOutputStream() ;
                while( ( n = reader.read( buf ) ) > 0 ) {
                    writer.write( buf, 0, n ) ;
                }
            }
            catch( IOException ex ) {
                System.out.println( "DownloadServlet::doGet " + requestedFilename +
                        "\n" + ex.getMessage()
                );
                resp.setStatus( 500 ) ;
                resp.getWriter().print( "Server error" ) ;
                return ;
            }
        }
        else {
            resp.setStatus( 404 ) ;
            resp.getWriter().print( requestedFilename + " not found" ) ;
        }
    }
}