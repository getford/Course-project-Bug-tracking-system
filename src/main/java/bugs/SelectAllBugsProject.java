package bugs;

import bugs.classes.Bug;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectAllBugsProject {
    private static final Logger log = Logger.getLogger(SelectAllBugsProject.class);
    private ArrayList<Bug> bugArrayList = new ArrayList<Bug>();
    private String keyProject;
    private int idProject;

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public void showBugs() throws SQLException, ClassNotFoundException {
        log.info("show bugs in selected project");

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();

            String querySelectBugs = "SELECT " +
                    "bugs.id," +
                    "  type.name," +
                    "  status.name," +
                    "  priority.name," +
                    "  users.firstname," +
                    "  users.lastname," +
                    "  id_user_reporter," +
                    "  date_create," +
                    "  title," +
                    "  description," +
                    "  environment " +
                    "FROM bugs" +
                    "  INNER JOIN type ON bugs.id_type = type.id" +
                    "  INNER JOIN status ON bugs.id_status = status.id" +
                    "  INNER JOIN priority ON bugs.id_priority = priority.id" +
                    "  INNER JOIN users ON bugs.id_user_assignee = users.id " +
                    "WHERE id_project =" + getIdProject();
            resultSet = statement.executeQuery(querySelectBugs);
            log.info("Query: " + querySelectBugs);
            while (resultSet.next()) {
                String idKeyProject = getKeyProject() + "-" + resultSet.getInt(1);
                String firstLastName = resultSet.getString(5) + " " + resultSet.getString(6);
                bugArrayList.add(new Bug(
                        idKeyProject, // id
                        resultSet.getString(2), // type
                        resultSet.getString(3), // status
                        resultSet.getString(4), // priority
                        firstLastName,
                        resultSet.getString(7), // id user reporter
                        resultSet.getString(8), // date
                        resultSet.getString(9), // title
                        resultSet.getString(10), // description
                        resultSet.getString(11) // environment
                ));
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public void returnIdSelectedProject(String nameProject) throws SQLException, ClassNotFoundException {
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();

            String querySelectIdByName = "SELECT id FROM projects WHERE name = '" + nameProject + "'";
            log.info("Query: " + querySelectIdByName);
            resultSet = statement.executeQuery(querySelectIdByName);
            while (resultSet.next())
                setIdProject(resultSet.getInt(1));
            resultSet.close();

            String querySelectKeyByName = "SELECT key_name FROM projects WHERE name = '" + nameProject + "'";
            log.info("Query: " + querySelectKeyByName);
            resultSet = statement.executeQuery(querySelectKeyByName);
            while (resultSet.next())
                setKeyProject(resultSet.getString(1));

        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public String getKeyProject() {
        return keyProject;
    }

    public void setKeyProject(String keyProject) {
        this.keyProject = keyProject;
    }

    public int getIdProject() {
        return idProject;
    }

    public void setIdProject(int idProject) {
        this.idProject = idProject;
    }

    public ArrayList<Bug> getBugArrayList() {
        return bugArrayList;
    }

    public void setBugArrayList(ArrayList<Bug> bugArrayList) {
        this.bugArrayList = bugArrayList;
    }

}
