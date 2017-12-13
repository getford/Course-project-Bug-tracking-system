package userpage;

import createissue.classes.User;
import database.Connect;

import javax.servlet.http.HttpServletRequest;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectUniqueUserInfo {
    private ArrayList<User> userInfoByLoginArrayList = new ArrayList<>();

    public SelectUniqueUserInfo(HttpServletRequest req) {
        String userLogin = req.getParameter("login");

        String query = "SELECT " +
                "  users.id, " +
                "  position.name, " +
                "  users.login, " +
                "  users.email, " +
                "  users.firstname, " +
                "  users.lastname " +
                "FROM users " +
                "  INNER JOIN position ON users.id_position = position.id " +
                "WHERE users.login = '" + userLogin + "'";

        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                userInfoByLoginArrayList.add(new User(resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getString(6)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                assert connect != null;
                assert resultSet != null;
                resultSet.close();
                statement.close();
                connect.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }

    }

    public ArrayList<User> getUserInfoByLoginArrayList() {
        return userInfoByLoginArrayList;
    }

    public void setUserInfoByLoginArrayList(ArrayList<User> userInfoByLoginArrayList) {
        this.userInfoByLoginArrayList = userInfoByLoginArrayList;
    }
}
