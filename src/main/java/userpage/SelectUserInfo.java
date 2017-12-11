package userpage;

import createissue.classes.User;
import database.Connect;

import javax.servlet.http.HttpServletRequest;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectUserInfo {
    private ArrayList<User> userInfoByLoginArrayList = new ArrayList<>();

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public SelectUserInfo(HttpServletRequest req) {
        try {
            selectInfoUserByLogin(req);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void selectInfoUserByLogin(HttpServletRequest req)
            throws SQLException, ClassNotFoundException {
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

        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public String selectUserNameFromToken(int id) {
        String nameSurname = null;
        String query = "SELECT firstname, lastname FROM users WHERE id = " + id;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                nameSurname = resultSet.getString(1) + " " + resultSet.getString(2);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return nameSurname;
    }

    public String selectUserPositionNameFromToken(int id) {
        String namePosition = null;
        String query = "SELECT position.name " +
                "FROM users" +
                "  INNER JOIN position ON users.id_position = position.id " +
                "WHERE users.id =" + id;
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                namePosition = resultSet.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return namePosition;
    }

    public String selectUserEmailFromToken(int id) {
        String email = null;
        String query = "SELECT email from users WHERE id = " + id;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                email = resultSet.getString(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return email;
    }

    public int selectCountAllYourBugs(int id) {
        int count = 0;
        String queryAll = "SELECT count(*) FROM bugs WHERE bugs.id_user_assignee = " + id;
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(queryAll);
            while (resultSet.next()) {
                count = resultSet.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return count;
    }

    public int selectCountOpenYourBugs(int id) {
        int countOpen = 0;
        String query = "SELECT count(*) FROM bugs WHERE bugs.id_user_assignee = " + id + " AND bugs.id_status = 0";
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                countOpen = resultSet.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return countOpen;
    }

    public int selectCountCloseYourBugs(int id) {
        int countClose = 0;
        String query = "SELECT count(*) FROM bugs WHERE bugs.id_user_assignee = " + id + " AND bugs.id_status = 1";
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                countClose = resultSet.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return countClose;
    }

    public ArrayList<User> getUserInfoByLoginArrayList() {
        return userInfoByLoginArrayList;
    }

    public void setUserInfoByLoginArrayList(ArrayList<User> userInfoByLoginArrayList) {
        this.userInfoByLoginArrayList = userInfoByLoginArrayList;
    }
}