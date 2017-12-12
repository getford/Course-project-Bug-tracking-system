package bugs;

import bugs.classes.Bug;
import database.Connect;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectAllBugsProject {
    private static final Logger log = Logger.getLogger(SelectAllBugsProject.class);
    private ArrayList<Bug> bugArrayList = new ArrayList<Bug>();
    private ArrayList<Bug> allBugArrayList = new ArrayList<>();
    private String keyProject;
    private int idProject;

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public SelectAllBugsProject() {
        try {
            showAllBugs();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void showAllBugs() throws SQLException, ClassNotFoundException {
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();

            String querySelectBugs = "SELECT " +
                    "  bugs.id," +
                    "  type.name," +
                    "  status.name," +
                    "  priority.name," +
                    "  users.firstname," +
                    "  users.lastname," +
                    "  (SELECT firstname FROM users WHERE users.id = bugs.id_user_reporter)," +
                    "  (SELECT lastname FROM users WHERE users.id = bugs.id_user_reporter)," +
                    "  bugs.date_create," +
                    "  bugs.title," +
                    "  bugs.description," +
                    "  bugs.environment, " +
                    "  projects.key_name " +
                    "FROM bugs " +
                    "  INNER JOIN type ON bugs.id_type = type.id" +
                    "  INNER JOIN status ON bugs.id_status = status.id" +
                    "  INNER JOIN priority ON bugs.id_priority = priority.id" +
                    "  INNER JOIN users ON bugs.id_user_assignee = users.id " +
                    "  INNER JOIN projects ON bugs.id_project = projects.id";
            resultSet = statement.executeQuery(querySelectBugs);
            while (resultSet.next()) {
                String idKeyProject = resultSet.getString(13) + "-" + resultSet.getInt(1);
                String firstLastNameAssignee = resultSet.getString(5) + " " + resultSet.getString(6);
                String firstLastNameReporter = resultSet.getString(7) + " " + resultSet.getString(8);
                String dateDayCreateBug = resultSet.getString(9).substring(0, 10);
                allBugArrayList.add(new Bug(
                        idKeyProject, // id
                        resultSet.getString(2), // type
                        resultSet.getString(3), // status
                        resultSet.getString(4), // priority
                        firstLastNameAssignee,
                        firstLastNameReporter,
                        dateDayCreateBug,
                        resultSet.getString(10), // title
                        resultSet.getString(11), // description
                        resultSet.getString(12) // environment
                ));
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

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
                    "  (SELECT firstname FROM users WHERE users.id = bugs.id_user_reporter)," +
                    "  (SELECT lastname FROM users WHERE users.id = bugs.id_user_reporter)," +
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
                String firstLastNameAssignee = resultSet.getString(5) + " " + resultSet.getString(6);
                String firstLastNameReporter = resultSet.getString(7) + " " + resultSet.getString(8);
                String dateDayCreateBug = resultSet.getString(9).substring(0, 10);
                bugArrayList.add(new Bug(
                        idKeyProject, // id
                        resultSet.getString(2), // type
                        resultSet.getString(3), // status
                        resultSet.getString(4), // priority
                        firstLastNameAssignee,
                        firstLastNameReporter,
                        dateDayCreateBug,
                        resultSet.getString(10), // title
                        resultSet.getString(11), // description
                        resultSet.getString(12) // environment
                ));


            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public int returnIdSelectedProject(String nameProject) throws SQLException, ClassNotFoundException {
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

        return getIdProject();
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

    public ArrayList<Bug> getAllBugArrayList() {
        return allBugArrayList;
    }

    public void setAllBugArrayList(ArrayList<Bug> allBugArrayList) {
        this.allBugArrayList = allBugArrayList;
    }
}
