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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            createIssue(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void createIssue(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int idProject = selectIdProject(req, resp);
        int idType = selectIdTypeIssue(req, resp);
        int idStatus = 0;
        int idPriority = selectIdPriority(req, resp);
        int idUserAssignee = selectIdUserAssignee(req, resp);
        int idUserReporter = 2;
        String dateCreate = req.getParameter("date_issue");
        String title = req.getParameter("title_issue");
        String description = req.getParameter("description_issue");
        String environment = req.getParameter("environment_issue");

        final String queryInsert = "INSERT INTO bugs (id_project, id_type, id_status, id_priority, id_user_assignee, " +
                "id_user_reporter, date_create, title, description, environment)" +
                "VALUES (" + idProject + "," + idType + "," + idStatus + "," + idPriority + ","
                + idUserAssignee + "," + idUserReporter + ",'" + dateCreate + "','" + title + "','"
                + description + "','" + environment + "')";
        try {
            Connect connect = new Connect();
            Statement statement = connect.getConnection().createStatement();
            statement.executeUpdate(queryInsert);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private int selectIdProject(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int tmpId = 0;
        String nameProject = req.getParameter("nameProject");
        String query = "SELECT id FROM projects WHERE name = '" + nameProject + "'";

        Connect connect = new Connect();
        Statement statement = connect.getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        while (resultSet.next())
            tmpId = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();

        return tmpId;
    }

    private int selectIdTypeIssue(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int tmpIdTypeIssue = 0;
        String nameTypeIssue = req.getParameter("nameTypeIssue");
        String query = "SELECT id FROM type WHERE name = '" + nameTypeIssue + "'";

        Connect connect = new Connect();
        Statement statement = connect.getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        while (resultSet.next())
            tmpIdTypeIssue = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();

        return tmpIdTypeIssue;
    }

    private int selectIdPriority(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int tmpIdPriority = 0;
        String name = req.getParameter("namePriority");
        String query = "SELECT id FROM priority WHERE name = '" + name + "'";

        Connect connect = new Connect();
        Statement statement = connect.getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        while (resultSet.next())
            tmpIdPriority = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();
        return tmpIdPriority;
    }

    private int selectIdUserAssignee(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int tmpIdUserAssignee = 0;

        String email = req.getParameter("userAssignee");
        String query = "SELECT id FROM users WHERE email = '" + email + "'";

        Connect connect = new Connect();
        Statement statement = connect.getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        while (resultSet.next())
            tmpIdUserAssignee = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();

        return tmpIdUserAssignee;
    }
}