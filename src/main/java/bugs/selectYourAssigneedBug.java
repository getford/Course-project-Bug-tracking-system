package bugs;

import bugs.classes.AssigneedBug;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class selectYourAssigneedBug {
    private ArrayList<AssigneedBug> assigneedBugArrayList = new ArrayList<AssigneedBug>();

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public selectYourAssigneedBug(int idUserAssigneed, String keyProjects) throws SQLException, ClassNotFoundException {
        String querySelectAssigneedBugs = "SELECT" +
                "  bugs.id," +
                "  projects.key_name, " +
                "  type.name," +
                "  status.name," +
                "  priority.name," +
                "  bugs.title " +
                "FROM bugs" +
                "  INNER JOIN priority ON bugs.id_priority = priority.id" +
                "  INNER JOIN status ON bugs.id_status = status.id" +
                "  INNER JOIN type ON bugs.id_type = type.id " +
                "  INNER JOIN projects ON bugs.id_project = projects.id" +
                " where bugs.id_user_assignee = " + idUserAssigneed + " AND bugs.id_status = 0;";
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();

            resultSet = statement.executeQuery(querySelectAssigneedBugs);
            while (resultSet.next()) {
               // assigneedBugArrayList.add(new AssigneedBug());
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }
}
