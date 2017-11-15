package bugs;

import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect {
    private static final Logger log = Logger.getLogger(Connect.class);
    private Connection connection;

    private static final String url = "jdbc:postgresql://localhost:5432/bts";
    private static final String login = "postgres";
    private static final String password = "root";

    Connect() throws SQLException, ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
        setConnection((Connection) DriverManager.getConnection(url, login, password));
        if (connection != null) {
            log.info("Access granted.");
        } else {
            log.error("Access denied.");
        }
    }

    public void close() throws SQLException {
        getConnection().close();
    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }
}
