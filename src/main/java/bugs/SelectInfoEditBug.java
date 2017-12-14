package bugs;

import bugs.classes.Bug;
import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectInfoEditBug {
    private static final Logger log = Logger.getLogger(SelectInfoEditBug.class);
    private ArrayList<Bug> bugInfoArrayList = new ArrayList<Bug>();

    public SelectInfoEditBug(int idBug) throws SQLException {
        try {
            Connect connect = new Connect();
            Statement statement = connect.getConnection().createStatement();


            String querySelectBugs = "SELECT " +
                    "bugs.id," +
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
                    "WHERE bugs.id = " + idBug;
            ResultSet resultSet = statement.executeQuery(querySelectBugs);
            log.info("Query: " + querySelectBugs);
            while (resultSet.next()) {
                String firstLastNameAssignee = resultSet.getString(5) + " " + resultSet.getString(6);
                String firstLastNameReporter = resultSet.getString(7) + " " + resultSet.getString(8);
                String dateDayCreateBug = resultSet.getString(9).substring(0, 10);
                bugInfoArrayList.add(new Bug(
                        String.valueOf(idBug), // id
                        resultSet.getString(2), // type
                        resultSet.getString(3), // status
                        resultSet.getString(4), // priority
                        firstLastNameAssignee,
                        firstLastNameReporter,
                        dateDayCreateBug,
                        resultSet.getString(10), // title
                        resultSet.getString(11), // description
                        resultSet.getString(12) // environment
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Bug> getBugInfoArrayList() {
        return bugInfoArrayList;
    }

    public void setBugInfoArrayList(ArrayList<Bug> bugInfoArrayList) {
        this.bugInfoArrayList = bugInfoArrayList;
    }
}
