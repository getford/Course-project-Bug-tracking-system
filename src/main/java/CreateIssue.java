import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

@WebServlet(urlPatterns = "/createissue")
public class CreateIssue extends HttpServlet {

    private int idProject;
    private int idType;
    private int idStatus;
    private int idPriority;
    private int idUserAssagnee;
    private int idUserReporter;
    private Date dateCreate;
    private String title;
    private String description;
    private String enviroment;

    private final String queryInsert = "INSERT INTO bug (id_project, id_type, id_status, id_priority, id_user_assignee, " +
            "id_user_reporter, date, title, description, enviroment)" +
            "values (" + getIdProject() + "," + getIdType() + "," + getIdStatus() + "," + getIdPriority() + ","
            + getIdUserAssagnee() + "," + getIdUserReporter() + "," + getDateCreate() + ",'" + getTitle() + "','"
            + getDescription() + "','" + getEnviroment() + "')";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Connect connect = new Connect();


        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public int getIdProject() {
        return idProject;
    }

    public void setIdProject(int idProject) {
        this.idProject = idProject;
    }

    public int getIdType() {
        return idType;
    }

    public void setIdType(int idType) {
        this.idType = idType;
    }

    public int getIdStatus() {
        return idStatus;
    }

    public void setIdStatus(int idStatus) {
        this.idStatus = idStatus;
    }

    public int getIdPriority() {
        return idPriority;
    }

    public void setIdPriority(int idPriority) {
        this.idPriority = idPriority;
    }

    public int getIdUserAssagnee() {
        return idUserAssagnee;
    }

    public void setIdUserAssagnee(int idUserAssagnee) {
        this.idUserAssagnee = idUserAssagnee;
    }

    public int getIdUserReporter() {
        return idUserReporter;
    }

    public void setIdUserReporter(int idUserReporter) {
        this.idUserReporter = idUserReporter;
    }

    public String getQueryInsert() {
        return queryInsert;
    }

    public Date getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Date dateCreate) {
        this.dateCreate = dateCreate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEnviroment() {
        return enviroment;
    }

    public void setEnviroment(String enviroment) {
        this.enviroment = enviroment;
    }
}