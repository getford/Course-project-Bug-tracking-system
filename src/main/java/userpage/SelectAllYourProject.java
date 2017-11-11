package userpage;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import userpage.classes.Project;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SelectAllYourProject {
    private ArrayList<Integer> idUserProjectArrayList = new ArrayList<Integer>();
    private ArrayList<Project> projectArrayList = new ArrayList<Project>();
    private int userId;

    public void selectAllYouProject() throws SQLException, ClassNotFoundException {
        selectIdYourProject();
        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            for (int i = 0; i < idUserProjectArrayList.size(); i++) {
                String query = "SELECT * FROM projects WHERE id = " + getIdUserProjectArrayList().get(i);
                resultSet = statement.executeQuery(query);
                while (resultSet.next()) {
                    projectArrayList.add(new Project(resultSet.getInt(1), resultSet.getInt(2),
                            resultSet.getString(3), resultSet.getString(4)));
                }
            }

        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    private void selectIdYourProject() throws SQLException, ClassNotFoundException {
        String query = "SELECT id_project FROM user_project WHERE id_user = " + getUserId();
        Connect connect = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                idUserProjectArrayList.add(resultSet.getInt(1));
            }
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }
    }

    public ArrayList<Integer> getIdUserProjectArrayList() {
        return idUserProjectArrayList;
    }

    public void setIdUserProjectArrayList(ArrayList<Integer> idUserProjectArrayList) {
        this.idUserProjectArrayList = idUserProjectArrayList;
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
