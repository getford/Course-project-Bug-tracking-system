package adminpage.add;

import database.Connect;
import mail.SendMail;
import org.apache.log4j.Logger;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(urlPatterns = "/addproject")
public class AddProject extends HttpServlet {
    private static final Logger log = Logger.getLogger(AddProject.class);

    private SendMail sendMail = new SendMail();

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            addProject(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void addProject(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        try {

            int idLead = selectIdUser(request);
            String nameProject = request.getParameter("nameProject");
            String keyProject = request.getParameter("keyProject").toUpperCase();

            String queryInsertProject = "INSERT INTO projects (id_user_lead , name, key_name)" +
                    "VALUES (" + idLead + ",'" + nameProject + "','" + keyProject + "')";
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            statement.executeUpdate(queryInsertProject);

            int idNewProject = 0;
            String queryIdNewProject = "SELECT id FROM projects WHERE key_name = '" + keyProject + "'";
            resultSet = statement.executeQuery(queryIdNewProject);
            while (resultSet.next())
                idNewProject = resultSet.getInt(1);
            resultSet.close();

            String queryInserUserProject = "INSERT INTO user_project (id_user, id_project) " +
                    "VALUES (" + idLead + ", " + idNewProject + ")";

            statement.executeUpdate(queryInserUserProject);

            String emailLeader = null;
            String queryMailLeader = "SELECT email FROM users WHERE id = " + idLead;
            resultSet = statement.executeQuery(queryMailLeader);
            while (resultSet.next())
                emailLeader = resultSet.getString(1);

            sendMail.sendMailLeaderProject(emailLeader, nameProject, request);
            log.debug("Query: " + queryInsertProject);
            log.info("Project: " + nameProject + ", key: " + " add successfully");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        response.sendRedirect("/adminpage.jsp");
    }

    private int selectIdUser(HttpServletRequest request)
            throws SQLException, ClassNotFoundException {
        int id = 0;
        String email = request.getParameter("leader");
        String query = "SELECT id FROM users WHERE email = '" + email + "'";

        connect = new Connect();
        statement = connect.getConnection().createStatement();
        resultSet = statement.executeQuery(query);
        while (resultSet.next())
            id = resultSet.getInt(1);

        resultSet.close();
        statement.close();
        connect.close();

        return id;
    }
}