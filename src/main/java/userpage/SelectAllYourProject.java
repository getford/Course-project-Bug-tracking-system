package userpage;

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

    public void selectAllProjects() throws SQLException, ClassNotFoundException {
        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            String query = "SELECT user_project.id_project, projects.id_user_lead, projects.name, projects.key_name " +
                    "FROM user_project inner join projects " +
                    "on user_project.id_project = projects.id " +
                    "where id_user = " + getUserId();
            resultSet = statement.executeQuery(query);
            log.info("Query: " + query);
            while (resultSet.next()) {
                projectArrayList.add(new Project(resultSet.getInt(1), resultSet.getInt(2),
                        resultSet.getString(3), resultSet.getString(4)));
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
