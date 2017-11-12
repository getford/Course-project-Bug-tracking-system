package userpage;

import createissue.classes.User;
import org.apache.log4j.Logger;
import userpage.classes.Project;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectAllYourProject {
    private static final Logger log = Logger.getLogger(SelectAllYourProject.class);
    private ArrayList<Project> projectArrayList = new ArrayList<Project>();
    private ArrayList<User> leaderArrayList = new ArrayList<User>();
    private int userId;

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    public void selectAllProjects() throws SQLException, ClassNotFoundException {
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
        selectNameLeaderProjects();
    }

    public void selectNameLeaderProjects() throws SQLException, ClassNotFoundException {
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();

            for (int i = 0; i < getProjectArrayList().size(); i++) {
                String query = "SELECT firstname, lastname FROM users WHERE id = " + getProjectArrayList().get(i).getIdUserLead();
                resultSet = statement.executeQuery(query);
//                log.info("Query: " + query);
                while (resultSet.next()) {
                    leaderArrayList.add(new User(resultSet.getString(1), resultSet.getString(2)));
                }
            }
            log.info("Array name leaders was received successfully.");
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<User> getLeaderArrayList() {
        return leaderArrayList;
    }

    public void setLeaderArrayList(ArrayList<User> leaderArrayList) {
        this.leaderArrayList = leaderArrayList;
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
