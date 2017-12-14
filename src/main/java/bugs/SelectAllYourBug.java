package bugs;

import bugs.classes.YourBug;
import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectAllYourBug {
    private static final Logger log = Logger.getLogger(SelectAllYourBug.class);
    private ArrayList<YourBug> yourBugArrayList = new ArrayList<YourBug>();

    public SelectAllYourBug(int id) throws SQLException {


        Connect connect = new Connect();
        Statement statement = connect.getConnection().createStatement();

        String querySelectBugs = "SELECT" +
                " bugs.id," +
                " projects.key_name, " +
                " bugs.title " +
                "FROM bugs " +
                " INNER JOIN projects ON bugs.id_project = projects.id " +
                "WHERE bugs.id_user_reporter = " + id;
        ResultSet resultSet = statement.executeQuery(querySelectBugs);
        log.info("Query: " + querySelectBugs);
        while (resultSet.next()) {
            String keyName = resultSet.getString(2) + "-" + resultSet.getString(1);
            yourBugArrayList.add(new YourBug(keyName, resultSet.getString(3)));
        }
    }

    public ArrayList<YourBug> getYourBugArrayList() {
        return yourBugArrayList;
    }

    public void setYourBugArrayList(ArrayList<YourBug> yourBugArrayList) {
        this.yourBugArrayList = yourBugArrayList;
    }
}
