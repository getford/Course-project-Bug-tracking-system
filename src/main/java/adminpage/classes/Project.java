package adminpage.classes;

public class Project {
    private String id;
    private String firstLastName;
    private String keyName;
    private String projectName;

    public Project(String id, String firstLastName, String keyName, String projectName) {
        this.id = id;
        this.firstLastName = firstLastName;
        this.keyName = keyName;
        this.projectName = projectName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirstLastName() {
        return firstLastName;
    }

    public void setFirstLastName(String firstLastName) {
        this.firstLastName = firstLastName;
    }

    public String getKeyName() {
        return keyName;
    }

    public void setKeyName(String keyName) {
        this.keyName = keyName;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
}
