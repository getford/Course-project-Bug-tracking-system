package userpage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect {
    private Connection connection;

    private static final String url = "jdbc:mysql://localhost:3306/BugTrackingSystem";
    private static final String login = "root";
    private static final String password = "";

    Connect() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        setConnection((Connection) DriverManager.getConnection(url, login, password));
        if (connection != null) {
            System.out.println("Access granted.");
        } else {
            System.out.println("Access denied.");
        }
    }

    void close() throws SQLException {
        getConnection().close();

    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }
}
