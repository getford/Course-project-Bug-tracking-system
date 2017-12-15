package userpage;

import database.Connect;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SelectUserInfo {

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    private String paramQuery(String namePosition, String query) {
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                namePosition = resultSet.getString(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return namePosition;
    }

    public int selectUserIdFromLogin(String login) {
        int id = 0;
        String query = "SELECT id FROM users WHERE login = '" + login + "'";

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                id = resultSet.getInt(1);
            }
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
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
            connect.close();
        } catch (SQLException e) {
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
        namePosition = paramQuery(namePosition, query);

        return namePosition;
    }

    public String selectUserEmailFromToken(int id) {
        String email = null;
        String query = "SELECT email from users WHERE id = " + id;

        email = paramQuery(email, query);
        return email;
    }

    public int selectCountAllYourBugs(int id) {
        int count = 0;
        String queryAll = "SELECT count(*) FROM bugs WHERE bugs.id_user_reporter = " + id;
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(queryAll);
            while (resultSet.next()) {
                count = resultSet.getInt(1);
            }
            connect.close();
        } catch (SQLException e) {
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
            connect.close();
        } catch (SQLException e) {
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
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return countClose;
    }
}