package adminpage;

import adminpage.classes.UserPosition;
import bugs.SelectAllBugsProject;
import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectPosition {
    private static final Logger log = Logger.getLogger(SelectAllBugsProject.class);
    private ArrayList<UserPosition> userPositionsArraylist = new ArrayList<UserPosition>();


    public void selectPisition () throws SQLException, ClassNotFoundException{
        String query = "SELECT * FROM position";
        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try{
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                userPositionsArraylist.add(new UserPosition(resultSet.getInt(1),resultSet.getString(2)));
            }
        }catch (SQLException e)
        {
            e.printStackTrace();
        }
        catch (ClassNotFoundException e){
            e.printStackTrace();
        }
        finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<UserPosition> getUserPositionsArraylist() {
        return userPositionsArraylist;
    }
}
