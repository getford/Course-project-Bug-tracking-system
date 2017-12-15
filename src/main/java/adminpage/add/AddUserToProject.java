package adminpage.add;

import cookie.CheckCookie;
import cookie.ParseCookie;
import database.Connect;
import mail.SendMail;
import org.apache.log4j.Logger;
import userpage.SelectUserInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(urlPatterns = "/addusertoproject")
public class AddUserToProject extends HttpServlet {
    private static final Logger log = Logger.getLogger(AddUserToProject.class);

    private CheckCookie checkCookie = new CheckCookie();
    private SelectUserInfo selectUserInfo = new SelectUserInfo();
    private SendMail sendMail = new SendMail();

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ParseCookie parseCookie = new ParseCookie(req);

        String idUser = req.getParameter("useras");
        String idProject = req.getParameter("projectas").substring(4);

        String queryInserUserProject = "INSERT INTO user_project (id_user, id_project) " +
                "VALUES (" + idUser + ", " + idProject + ")";
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            statement.executeUpdate(queryInserUserProject);

            String addUserEmail = null;
            String queryMail = "SELECT email FROM users WHERE id = " + idUser;
            resultSet = statement.executeQuery(queryMail);
            while (resultSet.next())
                addUserEmail = resultSet.getString(1);
            resultSet.close();

            String projectName = null;
            String queryProjectName = "SELECT name FROM projects WHERE id = " + idProject;
            resultSet = statement.executeQuery(queryProjectName);
            while (resultSet.next())
                projectName = resultSet.getString(1);
            resultSet.close();

            sendMail.sendMailAddUserToProject(addUserEmail,
                    selectUserInfo.selectUserEmailFromToken(parseCookie.getUserIdFromToken()),
                    projectName,
                    selectUserInfo.selectUserNameFromToken(parseCookie.getUserIdFromToken()),
                    req
            );
            log.info("Query: " + queryInserUserProject);
            resp.sendRedirect("/adminpage.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
