package adminpage;

import adminpage.classes.UserPosition;
import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectPosition {
    private static final Logger log = Logger.getLogger(SelectPosition.class);
    private ArrayList<UserPosition> userPositionsArraylist = new ArrayList<UserPosition>();

    public SelectPosition() {
        String query = "SELECT * FROM position";

        try {
            Connect connect = new Connect();
            Statement statement = connect.getConnection().createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                userPositionsArraylist.add(new UserPosition(resultSet.getInt(1), resultSet.getString(2)));
            }
            log.debug(query);
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
            log.debug(e);
        }
    }

    public ArrayList<UserPosition> getUserPositionsArraylist() {
        return userPositionsArraylist;
    }
}
