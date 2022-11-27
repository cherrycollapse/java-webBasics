package step.learning.services;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class GmailService implements EmailService {
    @Override
    public boolean send(String to, String subject, String text) {
        Properties gmailProperties = new Properties();
        gmailProperties.put("mail.smtp.aut", "true");
        gmailProperties.put("mail.smtp.starttls.enable", "true");
        gmailProperties.put("mail.smtp.port", "587");
        gmailProperties.put("mail.smtp.ssl.protocols", "TLSv1.2");
        gmailProperties.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session mailSession = Session.getInstance(gmailProperties);
        mailSession.setDebug(true); // вывод в консоль

        try {
            Transport mailTransport = mailSession.getTransport("smtp");
            mailTransport.connect(
                    "smtp.gmail.com",
                    "java.web.chernycollapse@gmail.com",
                    "mooncat1"
            );


            MimeMessage message = new MimeMessage(mailSession);

            message.setFrom(new InternetAddress("java.web.chernycollapse@gmail.com"));

            message.setSubject(subject);

            message.setContent(text, "text/html; charset=utf-8");

            mailTransport.sendMessage(message, InternetAddress.parse(to));
            mailTransport.close();


        } catch (MessagingException ex) {
            return false;
        }

        return true;
    }
}