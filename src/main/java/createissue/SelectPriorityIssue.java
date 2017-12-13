package createissue;

import createissue.classes.PriorityIssue;
import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectPriorityIssue {
    private static final Logger log = Logger.getLogger(SelectPriorityIssue.class);
    private ArrayList<PriorityIssue> priorityIssueArrayList = new ArrayList<PriorityIssue>();

    public void selectAllPriorityIssue() throws SQLException {
        String query = "SELECT * FROM priority";
        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                priorityIssueArrayList.add(new PriorityIssue(resultSet.getInt(1), resultSet.getString(2)));
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<PriorityIssue> getPriorityIssueArrayList() {
        return priorityIssueArrayList;
    }

    public void setPriorityIssueArrayList(ArrayList<PriorityIssue> priorityIssueArrayList) {
        this.priorityIssueArrayList = priorityIssueArrayList;
    }
}
