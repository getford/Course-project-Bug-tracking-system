package adminpage;

import org.apache.log4j.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
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
            int idLead = 0; /*selectIdUser(request, response);*/
            String nameProject = request.getParameter("nameProject");
            String keyProject = request.getParameter("keyProject");

            final String queryInsertProject = "INSERT INTO projects (id_user_lead,name,key_name)" +
                    "VALUES (" + idLead + "," + nameProject + "," + keyProject + ")";

            connect = new Connect();
            statement = connect.getConnection().createStatement();
            statement.executeUpdate(queryInsertProject);
            log.info("Query: " + queryInsertProject);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
        response.sendRedirect("/adminpage.jsp");
    }

    private int selectIdUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int tmpId = 0;
        String nameUser = request.getParameter("leadProject");
        String query = "SELECT id FROM users WHERE name = '" + nameUser + "'";

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
}