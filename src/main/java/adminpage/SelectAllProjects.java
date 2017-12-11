package adminpage;

import adminpage.classes.Project;
import database.Connect;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectAllProjects {
    private ArrayList<Project> projectArrayList = new ArrayList<Project>();

    public SelectAllProjects() throws SQLException, ClassNotFoundException {
        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            String query = "SELECT" +
                    "  users.firstname, " +
                    "  users.lastname, " +
                    "  projects.id, " +
                    "  projects.key_name, " +
                    "  projects.name " +
                    "FROM projects" +
                    "  INNER JOIN users ON projects.id_user_lead = users.id;";
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                String firstLastNameLead = resultSet.getString(1) + " " + resultSet.getString(2);
                String idProject = resultSet.getString(4) + "-" + resultSet.getString(3);
                projectArrayList.add(new Project(
                        idProject,
                        firstLastNameLead,
                        resultSet.getString(4),
                        resultSet.getString(5)
                ));
            }
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
}
