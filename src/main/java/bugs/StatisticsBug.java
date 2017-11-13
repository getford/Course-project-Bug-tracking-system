package bugs;

import bugs.classes.BugType;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class StatisticsBug {
    private static final Logger log = Logger.getLogger(StatisticsBug.class);
    private ArrayList<BugType> statisticsBugTypeArrayList = new ArrayList<BugType>();

    private int idProject;

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;


    public void showStatisticsBugs() {
        try {
            showStatisticsType();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void showStatisticsStatus() {

    }

    private void showStatisticsType() throws SQLException, ClassNotFoundException {
        int idProject = 1;
        ArrayList<Integer> idTypeArrayList = new ArrayList<Integer>();
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();

            String queryCountBugs = "SELECT id FROM type";
            resultSet = statement.executeQuery(queryCountBugs);
            while (resultSet.next()) {
                idTypeArrayList.add(resultSet.getInt(1));
            }
            resultSet.close();

            for (int i = 0; i < idTypeArrayList.size(); i++) {
                String querySelectCountTypeBugs = "SELECT" +
                        "  type.name," +
                        "  count(type.name)" +
                        "FROM bugs" +
                        "  INNER JOIN type ON bugs.id_type = type.id " +
                        "WHERE id_project = " + idProject + " AND type.id = " + idTypeArrayList.get(i);
                resultSet = statement.executeQuery(querySelectCountTypeBugs);
                log.info("Query: " + querySelectCountTypeBugs);
                while (resultSet.next()) {
                    statisticsBugTypeArrayList.add(new BugType(resultSet.getString(1), resultSet.getInt(2)));
                }
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public int getIdProject() {
        return idProject;
    }

    public void setIdProject(int idProject) {
        this.idProject = idProject;
    }
}
