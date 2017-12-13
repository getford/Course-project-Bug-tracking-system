package bugs;

import bugs.classes.BugStat;
import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class StatisticsBug {
    private static final Logger log = Logger.getLogger(StatisticsBug.class);
    private ArrayList<BugStat> bugStatTypeArrayList = new ArrayList<BugStat>();
    private ArrayList<BugStat> bugStatStatusArrayList = new ArrayList<BugStat>();
    private ArrayList<BugStat> bugStatPriorityArrayList = new ArrayList<BugStat>();

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public StatisticsBug(int idProject) throws SQLException {
        String queryPriorityStatistics =
                "SELECT" +
                        "  name, " +
                        "  count(name) " +
                        "FROM priority " +
                        "  INNER JOIN bugs ON priority.id = bugs.id_priority " +
                        "WHERE bugs.id_project = " + idProject +
                        " GROUP BY name;";

        String queryTypeStatistics =
                "SELECT" +
                        "  name, " +
                        "  count(name) " +
                        "FROM type " +
                        "  INNER JOIN bugs ON type.id = bugs.id_type " +
                        "WHERE bugs.id_project = " + idProject +
                        " GROUP BY name;";

        String queryStatusStatistics =
                "SELECT" +
                        "  name, " +
                        "  count(name) " +
                        "FROM status " +
                        "  INNER JOIN bugs ON status.id = bugs.id_status " +
                        "WHERE bugs.id_project = " + idProject +
                        " GROUP BY name;";

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();

            resultSet = statement.executeQuery(queryPriorityStatistics);
            while (resultSet.next()) {
                bugStatPriorityArrayList.add(new BugStat(resultSet.getString(1), resultSet.getInt(2)));
            }

            resultSet = statement.executeQuery(queryTypeStatistics);
            while (resultSet.next()) {
                bugStatTypeArrayList.add(new BugStat(resultSet.getString(1), resultSet.getInt(2)));
            }

            resultSet = statement.executeQuery(queryStatusStatistics);
            while (resultSet.next()) {
                bugStatStatusArrayList.add(new BugStat(resultSet.getString(1), resultSet.getInt(2)));
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<BugStat> getBugStatTypeArrayList() {
        return bugStatTypeArrayList;
    }

    public ArrayList<BugStat> getBugStatStatusArrayList() {
        return bugStatStatusArrayList;
    }

    public ArrayList<BugStat> getBugStatPriorityArrayList() {
        return bugStatPriorityArrayList;
    }
}
