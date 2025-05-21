package test;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class MailTest {
    public static void main(String[] args) {
        final String username = "vaductai2905@gmail.com";
        final String password = "uyqj kbje roel rqoq"; // Dùng App Password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("de180369vanductai@gmail.com"));
            message.setSubject("Test Email");
            message.setText("Hello, this is a test email!");

            Transport.send(message);
            System.out.println("Email sent successfully!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
