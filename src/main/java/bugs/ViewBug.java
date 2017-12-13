package bugs;

import bugs.classes.Bug;
import database.Connect;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ViewBug {
    private ArrayList<Bug> bugArrayList = new ArrayList<Bug>();

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public ViewBug(String idKey) throws SQLException {
        String id = idKey.substring(4);

        String querySelectInfoBug =
                "SELECT" +
                        "  type.name," +
                        "  status.name," +
                        "  priority.name," +
                        "  users.firstname," +
                        "  users.lastname," +
                        "  (SELECT firstname FROM users WHERE users.id = bugs.id_user_reporter)," +
                        "  (SELECT lastname FROM users WHERE users.id = bugs.id_user_reporter)," +
                        "  date_create," +
                        "  title," +
                        "  description," +
                        "  environment " +
                        "FROM bugs" +
                        "  INNER JOIN type ON bugs.id_type = type.id" +
                        "  INNER JOIN status ON bugs.id_status = status.id" +
                        "  INNER JOIN priority ON bugs.id_priority = priority.id" +
                        "  INNER JOIN users ON bugs.id_user_assignee = users.id " +
                        "WHERE bugs.id = " + id;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(querySelectInfoBug);

            while (resultSet.next()) {
                String firstLastNameAssignee = resultSet.getString(4) + " " + resultSet.getString(5);
                String firstLastNameReporter = resultSet.getString(6) + " " + resultSet.getString(7);
                String dateDayCreateBug = resultSet.getString(8).substring(0, 10);
                bugArrayList.add(new Bug(
                        idKey,
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        firstLastNameAssignee,
                        firstLastNameReporter,
                        dateDayCreateBug,
                        resultSet.getString(9),
                        resultSet.getString(10),
                        resultSet.getString(11)
                ));
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<Bug> getBugArrayList() {
        return bugArrayList;
    }

    public void setBugArrayList(ArrayList<Bug> bugArrayList) {
        this.bugArrayList = bugArrayList;
    }
}
