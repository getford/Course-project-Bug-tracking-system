package createissue;

import createissue.classes.User;
import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectAllUsers {
    private static final Logger log = Logger.getLogger(SelectAllUsers.class);
    private ArrayList<User> userArrayList = new ArrayList<User>();
    private ArrayList<User> userInfoArrayList = new ArrayList<User>();

    public SelectAllUsers() throws SQLException, ClassNotFoundException {
        String query = "SELECT " +
                "  users.id, " +
                "  position.name, " +
                "  users.login, " +
                "  users.password, " +
                "  users.email, " +
                "  users.firstname, " +
                "  users.lastname " +
                "FROM users " +
                "  INNER JOIN position ON users.id_position = position.id";

        Connect connect = new Connect();
        Statement statement = connect.getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        while (resultSet.next()) {
            userArrayList.add(new User(resultSet.getString(1), resultSet.getString(2),
                    resultSet.getString(3), resultSet.getString(4),
                    resultSet.getString(5), resultSet.getString(6),
                    resultSet.getString(7)));
        }
        log.info("Array users successfully received");
    }

    public SelectAllUsers(int id) throws SQLException, ClassNotFoundException {
        String query = "SELECT " +
                "  users.id, " +
                "  position.name, " +
                "  users.login, " +
                "  users.password, " +
                "  users.email, " +
                "  users.firstname, " +
                "  users.lastname " +
                "FROM users " +
                "  INNER JOIN position ON users.id_position = position.id " +
                "WHERE users.id = " + id;

        Connect connect = new Connect();
        Statement statement = connect.getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        while (resultSet.next()) {
            userInfoArrayList.add(new User(resultSet.getString(1), resultSet.getString(2),
                    resultSet.getString(3), resultSet.getString(4),
                    resultSet.getString(5), resultSet.getString(6),
                    resultSet.getString(7)));
        }
        log.info("Array users successfully received");
    }

    public ArrayList<User> getUserArrayList() {
        return userArrayList;
    }

    public void setUserArrayList(ArrayList<User> userArrayList) {
        this.userArrayList = userArrayList;
    }

    public ArrayList<User> getUserInfoArrayList() {
        return userInfoArrayList;
    }

    public void setUserInfoArrayList(ArrayList<User> userInfoArrayList) {
        this.userInfoArrayList = userInfoArrayList;
    }
}
