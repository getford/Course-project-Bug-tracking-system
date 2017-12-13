package database;

import com.google.gson.Gson;
import database.classes.ParamConnect;
import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class Connect {
    private static final Logger log = Logger.getLogger(Connect.class);
    private Map<String, String> paramConnectMap = new HashMap<>();
    private Connection connection;

    private void readParamConnectJSON() {
        try {
            String path = getClass().getResource("/param_database.json").getPath();
            BufferedReader bufferedReader = new BufferedReader(new FileReader(path));
            ParamConnect paramConnectObject = new Gson().fromJson(bufferedReader, ParamConnect.class);

            paramConnectMap.put("url", paramConnectObject.getUrl());
            paramConnectMap.put("login", paramConnectObject.getLogin());
            paramConnectMap.put("password", paramConnectObject.getPassword());
            paramConnectMap.put("driver", paramConnectObject.getDriver());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            log.error(e);
        }
    }

    public Connect() {
        readParamConnectJSON();
        try {
            Class.forName(paramConnectMap.get("driver"));
            setConnection((Connection) DriverManager.getConnection(paramConnectMap.get("url"), paramConnectMap.get("login"), paramConnectMap.get("password")));
            if (connection == null) {
                log.error("Access denied.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            log.error(e);
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
