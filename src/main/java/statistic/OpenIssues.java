package statistic;

import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class OpenIssues {
    private static final Logger log = Logger.getLogger(OpenIssues.class);

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public int countAllOpenIssues() throws SQLException {
        int countAllOpenIssues = 0;
        String queryAllOpenIssue = "SELECT count(*) FROM bugs WHERE bugs.id_status = 0";

        connect = new Connect();
        statement = connect.getConnection().createStatement();
        resultSet = statement.executeQuery(queryAllOpenIssue);

        while (resultSet.next()) {
            countAllOpenIssues = resultSet.getInt(1);
        }

        resultSet.close();
        statement.close();
        connect.close();
        return countAllOpenIssues;
    }
}
