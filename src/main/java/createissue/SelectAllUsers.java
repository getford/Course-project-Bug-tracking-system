package createissue;

import createissue.classes.User;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectAllUsers {
    private static final Logger log = Logger.getLogger(SelectAllUsers.class);
    private ArrayList<User> userArrayList = new ArrayList<User>();

    public void selectAll() throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM users";
        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                userArrayList.add(new User(resultSet.getInt(1), resultSet.getInt(2),
                        resultSet.getString(3), resultSet.getString(4),
                        resultSet.getString(5), resultSet.getString(6),
                        resultSet.getString(7)));
            }
            log.info("Array users successfully received");
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }

    }

    public ArrayList<User> getUserArrayList() {
        return userArrayList;
    }

    public void setUserArrayList(ArrayList<User> userArrayList) {
        this.userArrayList = userArrayList;
    }
}
