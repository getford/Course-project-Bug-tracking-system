package createissue;

import createissue.classes.TypeIssue;
import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectTypeIssue {
    private static final Logger log = Logger.getLogger(SelectTypeIssue.class);
    private ArrayList<TypeIssue> typeIssueArrayList = new ArrayList<TypeIssue>();

    public void selectAllTypeIssue() throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM type";
        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                typeIssueArrayList.add(new TypeIssue(resultSet.getInt(1), resultSet.getString(2)));
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<TypeIssue> getTypeIssueArrayList() {
        return typeIssueArrayList;
    }

    public void setTypeIssueArrayList(ArrayList<TypeIssue> typeIssueArrayList) {
        this.typeIssueArrayList = typeIssueArrayList;
    }
}
