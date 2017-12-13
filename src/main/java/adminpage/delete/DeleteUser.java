package adminpage.delete;

import database.Connect;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(urlPatterns = "/deleteuser")
public class DeleteUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        String id = req.getParameter("id");

        try {
            Connect connect = new Connect();
            Statement statement = connect.getConnection().createStatement();
            String queryDeleteUser = "DELETE FROM users WHERE id = " + Integer.parseInt(id);
            String queryDeleteUserFromProject = "DELETE FROM user_project WHERE id_user = " + Integer.parseInt(id);
            String queryDeleteUserFromProjectLeader = "DELETE FROM projects WHERE id_user_lead = " + Integer.parseInt(id);
            String queryDeleteUserBugs = "DELETE FROM bugs WHERE " +
                    "id_user_assignee = " + Integer.parseInt(id) + "" +
                    " OR id_user_reporter = " + Integer.parseInt(id);
            statement.execute(queryDeleteUserBugs);
            statement.execute(queryDeleteUserFromProjectLeader);
            statement.execute(queryDeleteUserFromProject);
            statement.execute(queryDeleteUser);

            resp.sendRedirect("/adminpage.jsp");

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }
}
