package createissue;

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

@WebServlet(urlPatterns = "/createissue")
public class CreateIssue extends HttpServlet {
    private static final Logger log = Logger.getLogger(CreateIssue.class);

    private SendMail sendMail = new SendMail();

    private String EmailUserAssignee = null;

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            createIssue(req, resp);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void createIssue(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        ParseCookie parseCookie = new ParseCookie(req);
        SelectUserInfo selectUserInfo = new SelectUserInfo();
        try {
            int idProject = selectIdProject(req, resp);
            int idType = selectIdTypeIssue(req, resp);
            int idStatus = 0;
            int idPriority = selectIdPriority(req, resp);
            int idUserAssignee = selectIdUserAssignee(req, resp);
            int idUserReporter = parseCookie.getUserIdFromToken();
            String dateCreate = req.getParameter("date_issue");
            String title = req.getParameter("title_issue");
            String description = req.getParameter("description");
            String environment = req.getParameter("environment");

            final String queryInsert = "INSERT INTO bugs (id_project, id_type, id_status, id_priority, id_user_assignee, " +
                    "id_user_reporter, date_create, title, description, environment)" +
                    "VALUES (" + idProject + "," + idType + "," + idStatus + "," + idPriority + ","
                    + idUserAssignee + "," + idUserReporter + ",'" + dateCreate + "','" + title + "','"
                    + description + "','" + environment + "')";

            connect = new Connect();
            statement = connect.getConnection().createStatement();
            statement.executeUpdate(queryInsert);

            int maxId = 0;
            String queryMaxIdBug = "SELECT MAX(id) FROM bugs";
            resultSet = statement.executeQuery(queryMaxIdBug);
            while (resultSet.next())
                maxId = resultSet.getInt(1);

            String idBug = selectKeyNameProject(req, resp) + "-" + maxId;
            String urlBug = "http://localhost:8080/viewbug.jsp?idbug=" + idBug;


            sendMail.sendMailAssignee(getEmailUserAssignee(),
                    selectUserInfo.selectUserNameFromToken(parseCookie.getUserIdFromToken()),
                    selectUserInfo.selectUserEmailFromToken(parseCookie.getUserIdFromToken()),
                    urlBug, idBug);
            log.info("Query: " + queryInsert);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }

        resp.sendRedirect("/userpage.jsp");
    }

    private int selectIdProject(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ClassNotFoundException {
        int tmpId = 0;
        String nameProject = req.getParameter("nameProject");
        String query = "SELECT id FROM projects WHERE name = '" + nameProject + "'";

        connect = new Connect();
        statement = connect.getConnection().createStatement();
        resultSet = statement.executeQuery(query);
        while (resultSet.next())
            tmpId = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();

        return tmpId;
    }

    private String selectKeyNameProject(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        String keyName = null;
        String nameProject = req.getParameter("nameProject");
        String query = "SELECT key_name FROM projects WHERE name = '" + nameProject + "'";

        connect = new Connect();
        statement = connect.getConnection().createStatement();
        resultSet = statement.executeQuery(query);
        while (resultSet.next())
            keyName = resultSet.getString(1);

        resultSet.close();
        statement.close();
        connect.close();

        return keyName;
    }

    public int selectIdTypeIssue(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int tmpIdTypeIssue = 0;
        String nameTypeIssue = req.getParameter("nameTypeIssue");
        String query = "SELECT id FROM type WHERE name = '" + nameTypeIssue + "'";

        connect = new Connect();
        statement = connect.getConnection().createStatement();
        resultSet = statement.executeQuery(query);
        while (resultSet.next())
            tmpIdTypeIssue = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();

        return tmpIdTypeIssue;
    }

    public int selectIdPriority(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int tmpIdPriority = 0;
        String name = req.getParameter("namePriority");
        String query = "SELECT id FROM priority WHERE name = '" + name + "'";

        connect = new Connect();
        statement = connect.getConnection().createStatement();
        resultSet = statement.executeQuery(query);

        while (resultSet.next())
            tmpIdPriority = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();
        return tmpIdPriority;
    }

    public int selectIdUserAssignee(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int tmpIdUserAssignee = 0;

        setEmailUserAssignee(req.getParameter("userAssignee"));

        String query = "SELECT id FROM users WHERE email = '" + getEmailUserAssignee() + "'";

        connect = new Connect();
        statement = connect.getConnection().createStatement();
        resultSet = statement.executeQuery(query);

        while (resultSet.next())
            tmpIdUserAssignee = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();

        return tmpIdUserAssignee;
    }

    public int selectIdStatus(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int idStatus = 0;

        String nameStatus = req.getParameter("statusName");

        String query = "SELECT id FROM status WHERE name = '" + nameStatus + "'";

        connect = new Connect();
        statement = connect.getConnection().createStatement();
        resultSet = statement.executeQuery(query);

        while (resultSet.next())
            idStatus = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();

        return idStatus;
    }

    public String getEmailUserAssignee() {
        return EmailUserAssignee;
    }

    public void setEmailUserAssignee(String emailUserAssignee) {
        EmailUserAssignee = emailUserAssignee;
    }
}