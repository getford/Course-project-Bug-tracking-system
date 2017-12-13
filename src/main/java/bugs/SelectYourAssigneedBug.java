package bugs;

import bugs.classes.AssigneedBug;
import database.Connect;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectYourAssigneedBug {
    private ArrayList<AssigneedBug> assigneedBugArrayList = new ArrayList<AssigneedBug>();

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public SelectYourAssigneedBug(int idUserAssigneed) throws SQLException, ClassNotFoundException {
        String querySelectAssigneedBugs = "SELECT" +
                "  bugs.id," +
                "  projects.key_name, " +
                "  type.name," +
                "  priority.name," +
                "  bugs.date_create," +
                "  bugs.title " +
                "FROM bugs" +
                "  INNER JOIN priority ON bugs.id_priority = priority.id" +
                "  INNER JOIN type ON bugs.id_type = type.id " +
                "  INNER JOIN projects ON bugs.id_project = projects.id" +
                " where bugs.id_user_assignee = " + idUserAssigneed + " AND bugs.id_status = 0;";
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();

            resultSet = statement.executeQuery(querySelectAssigneedBugs);
            while (resultSet.next()) {
                String idKeyProject = resultSet.getString(2) + "-" + resultSet.getInt(1);
                String dateDayCreateBug = resultSet.getString(5).substring(0, 10);
                assigneedBugArrayList.add(new AssigneedBug(
                        idKeyProject,
                        resultSet.getString(3),
                        resultSet.getString(4),
                        dateDayCreateBug,
                        resultSet.getString(6)));
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<AssigneedBug> getAssigneedBugArrayList() {
        return assigneedBugArrayList;
    }

    public void setAssigneedBugArrayList(ArrayList<AssigneedBug> assigneedBugArrayList) {
        this.assigneedBugArrayList = assigneedBugArrayList;
    }
}
