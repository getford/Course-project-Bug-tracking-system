package createissue;

import createissue.classes.StatusIssue;
import database.Connect;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectStatusIssue {
    ArrayList<StatusIssue> statusIssueArrayList = new ArrayList<>();

    public SelectStatusIssue() throws SQLException {
        String query = "SELECT * FROM status";
        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                statusIssueArrayList.add(new StatusIssue(resultSet.getInt(1), resultSet.getString(2)));
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<StatusIssue> getStatusIssueArrayList() {
        return statusIssueArrayList;
    }

    public void setStatusIssueArrayList(ArrayList<StatusIssue> statusIssueArrayList) {
        this.statusIssueArrayList = statusIssueArrayList;
    }
}
