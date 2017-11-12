package bugs.classes;

public class Bug {
    private String idBug;
    private String idType;
    private String idStatus;
    private String idPriority;
    private String idUserAssagniee;
    private String idUserReporter;
    private String dateCreate;
    private String title;
    private String description;
    private String environment;

    public Bug(String idBug, String idType, String idStatus, String idPriority, String idUserAssagniee, String idUserReporter, String dateCreate, String title, String description, String environment) {
        this.idBug = idBug;
        this.idType = idType;
        this.idStatus = idStatus;
        this.idPriority = idPriority;
        this.idUserAssagniee = idUserAssagniee;
        this.idUserReporter = idUserReporter;
        this.dateCreate = dateCreate;
        this.title = title;
        this.description = description;
        this.environment = environment;
    }

    public String getIdBug() {
        return idBug;
    }

    public void setIdBug(String idBug) {
        this.idBug = idBug;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getIdStatus() {
        return idStatus;
    }

    public void setIdStatus(String idStatus) {
        this.idStatus = idStatus;
    }

    public String getIdPriority() {
        return idPriority;
    }

    public void setIdPriority(String idPriority) {
        this.idPriority = idPriority;
    }

    public String getIdUserAssagniee() {
        return idUserAssagniee;
    }

    public void setIdUserAssagniee(String idUserAssagniee) {
        this.idUserAssagniee = idUserAssagniee;
    }

    public String getIdUserReporter() {
        return idUserReporter;
    }

    public void setIdUserReporter(String idUserReporter) {
        this.idUserReporter = idUserReporter;
    }

    public String getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(String dateCreate) {
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

    public String getEnvironment() {
        return environment;
    }

    public void setEnvironment(String environment) {
        this.environment = environment;
    }
}
