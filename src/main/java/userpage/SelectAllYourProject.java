package userpage;

import database.Connect;
import org.apache.log4j.Logger;
import userpage.classes.Project;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectAllYourProject {
    private static final Logger log = Logger.getLogger(SelectAllYourProject.class);
    private ArrayList<Project> projectArrayList = new ArrayList<Project>();
    private int userId;

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public void selectAllProjects() throws SQLException, ClassNotFoundException {
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            String query = "SELECT" +
                    "  user_project.id_project," +
                    "  projects.name," +
                    "  projects.key_name," +
                    "  users.firstname," +
                    "  users.lastname " +
                    "FROM user_project" +
                    "  INNER JOIN projects ON user_project.id_project = projects.id" +
                    "  INNER JOIN users ON projects.id_user_lead = users.id " +
                    "WHERE id_user = " + getUserId();
            resultSet = statement.executeQuery(query);
            log.info("Query: " + query);
            while (resultSet.next()) {
                String firstLastNameLead = resultSet.getString(4) + " " + resultSet.getString(5);
                projectArrayList.add(new Project(
                        resultSet.getInt(1),
                        firstLastNameLead,
                        resultSet.getString(2),
                        resultSet.getString(3)
                ));
            }
            log.info("Array projects current user was received successfully.");
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<Project> getProjectArrayList() {
        return projectArrayList;
    }

    public void setProjectArrayList(ArrayList<Project> projectArrayList) {
        this.projectArrayList = projectArrayList;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
