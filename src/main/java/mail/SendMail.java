package mail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendMail {

    private final static String to = "zeie2ozw.iyg@20email.eu";

    /*    JsonParser jsonParser = new JsonParser();
    JsonElement jsonElement = jsonParser.parse();*/

    public void sendMailRegistration(String email, String login, String password_) {
        final String host = "smtp.gmail.com";
        final String port = "587";

        final String from = "java.lab.test.mail@gmail.com";
        final String password = "123456qwe";

        String subject = "Successfully registration";
        String mailBody = "<p>Hello,</p>" +
                "<p>You will be successfully registered in Bug Tracking System</p>" +
                "<p>" +
                "<b>Your login: </b>" + login + "" +
                "<b>Your password: </b>" + password_ + "" +
                "</p>" +
                "<p>You profile: <a href=\"http://localhost:8080/profile.jsp\">http://localhost:8080/profile.jsp</a></p>";

        System.out.println("TLSEmail Start");
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };
        Session session = Session.getInstance(props, auth);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(mailBody, "text/html; charset=utf-8");
            Transport.send(message);
            System.out.println("Sent message to [" + to + "] successfully.");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public void sendMailAssignee(String emailAssignee, String userReporter, String emailReporter, String urlBug, String idBug) {
        final String host = "smtp.gmail.com";
        final String port = "587";

        final String from = "java.lab.test.mail@gmail.com";
        final String password = "123456qwe";

        String subject = "You have new assignee to bug [" + idBug + "]";
        String mailBody = "<p>Hello,</p>" +
                "You was assignee by <b>" + userReporter + "</b> [" + emailReporter + "]. <br/>" +
                "<p>Check the link, to see bug:" +
                "<a href=\"" + urlBug + "\">" + urlBug + "</a></p>";


        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };
        Session session = Session.getInstance(props, auth);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(mailBody, "text/html; charset=utf-8");
            Transport.send(message);
            System.out.println("Sent message to [" + to + "] successfully.");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
