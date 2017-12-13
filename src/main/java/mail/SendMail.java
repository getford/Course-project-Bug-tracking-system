package mail;

import com.google.gson.Gson;
import mail.classes.ParamMail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class SendMail {
    private Map<String, String> paramMailMap = new HashMap<>();
    URL url = null;

    private final static String to = "xtudocr4.uz5@20mm.eu";

    public SendMail() {
        readParamMailJSON();
    }

    private void readParamMailJSON() {
        try {
            String path = getClass().getResource("/param_mail.json").getPath();
            BufferedReader bufferedReader = new BufferedReader(new FileReader(path));
            ParamMail paramMailObject = new Gson().fromJson(bufferedReader, ParamMail.class);

            paramMailMap.put("host", paramMailObject.getHost());
            paramMailMap.put("port", paramMailObject.getPort());
            paramMailMap.put("from", paramMailObject.getFrom());
            paramMailMap.put("password", paramMailObject.getPassword());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void paramMessage(String email, String subject, String mailBody) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", paramMailMap.get("host"));
            props.put("mail.smtp.port", paramMailMap.get("port"));
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Authenticator auth = new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(paramMailMap.get("from"), paramMailMap.get("password"));
                }
            };
            Session session = Session.getInstance(props, auth);

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(paramMailMap.get("from")));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(subject);
            message.setContent(mailBody, "text/html; charset=utf-8");
            Transport.send(message);
            System.out.println("Sent message to [" + email + "] successfully.");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public void sendMailRegistration(String email, String login, String password_, HttpServletRequest request) {
        try {
            url = new URL(request.getRequestURL().toString());
            String subject = "Successfully registration";
            String mailBody = "<p>Hello,</p>" +
                    "<p>You will be successfully registered in Bug Tracking System</p>" +
                    "<p>" +
                    "<b>Your login: </b>" + login + "" +
                    "<br/><b>Your password: </b>" + password_ + "" +
                    "</p>" +
                    "<p>You profile: <a href=\"" + url.getProtocol() + "://" + url.getHost() + ":" + url.getPort() + "/profile.jsp?login=" + login + "\">" +
                    "" + url.getProtocol() + "://" + url.getHost() + ":" + url.getPort() + "/profile.jsp?login=" + login + "</a></p>";

            paramMessage(email, subject, mailBody);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
    }

    public void sendMailAssignee(String emailAssignee, String userReporter, String emailReporter, String urlBug, String idBug) {

        String subject = "You have new assignee to bug [" + idBug + "]";
        String mailBody = "<p>Hello,</p>" +
                "You was assignee by <b>" + userReporter + "</b> [" + emailReporter + "]. <br/>" +
                "<p>Check the link, to see bug:" +
                "<a href=\"" + urlBug + "\">" + urlBug + "</a></p>";

        paramMessage(emailAssignee, subject, mailBody);
    }

    public void sendMailLeaderProject(String email, String nameProject, HttpServletRequest request) {
        try {
            url = new URL(request.getRequestURL().toString());
            String subject = "Project leader";
            String mailBody = "<p>Hello,</p>" +
                    "<p>You will be successfully add as project leader</p>" +
                    "<p>Project: <a href=\"" + url.getProtocol() + "://" + url.getHost() + ":" + url.getPort() + "/projectpage.jsp?nameproject=" + nameProject + "\">" +
                    "" + url.getProtocol() + "://" + url.getHost() + ":" + url.getPort() + "/projectpage.jsp?nameproject=" + nameProject + "</a></p>";

            paramMessage(email, subject, mailBody);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
    }

    public void sendMailEditBug(String emailAssignee, String emailEditor, String idBug, HttpServletRequest request) {
        try {
            url = new URL(request.getRequestURL().toString());
            String subject = "Edit bug";
            String body = "<p>Hello,</p>" +
                    "<p>The bug you were assigned to was changed</p>" +
                    "<p>The bug has been changed:" + emailEditor + "</p>" +
                    "<p>Check the link to see bug: <a href=\"" + url.getProtocol() + "://" + url.getHost() + ":" + url.getPort() + "/viewbug.jsp?idbug=" + idBug + "\">" +
                    "" + url.getProtocol() + "://" + url.getHost() + ":" + url.getPort() + "/viewbug.jsp?idbug=" + idBug + "</a></p>";

            paramMessage(emailAssignee, subject, body);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
    }

    public void sendMailCloseBug(String emailWhoCloseBug, String emailReporter, String idBug, HttpServletRequest request){
        try {
            url = new URL(request.getRequestURL().toString());
            String subject = "Close your bug";
            String body = "<p>Hello,</p>" +
                    "<p>The bug was you create, has been closed by"+emailWhoCloseBug+"</p>" +
                    "<p>Check the link to see bug: <a href=\"" + url.getProtocol() + "://" + url.getHost() + ":" + url.getPort() + "/viewbug.jsp?idbug=" + idBug + "\">" +
                    "" + url.getProtocol() + "://" + url.getHost() + ":" + url.getPort() + "/viewbug.jsp?idbug=" + idBug + "</a></p>";

            paramMessage(emailReporter, subject, body);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
    }
}
