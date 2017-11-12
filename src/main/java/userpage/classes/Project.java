package userpage.classes;

public class Project {
    private int id;
    private String firstLastNameLead;
    private String nameProject;
    private String keyNameProject;

    public Project(int id, String firstLastNameLead, String nameProject, String keyNameProject) {
        this.id = id;
        this.firstLastNameLead = firstLastNameLead;
        this.nameProject = nameProject;
        this.keyNameProject = keyNameProject;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstLastNameLead() {
        return firstLastNameLead;
    }

    public void setFirstLastNameLead(String firstLastNameLead) {
        this.firstLastNameLead = firstLastNameLead;
    }

    public String getNameProject() {
        return nameProject;
    }

    public void setNameProject(String nameProject) {
        this.nameProject = nameProject;
    }

    public String getKeyNameProject() {
        return keyNameProject;
    }

    public void setKeyNameProject(String keyNameProject) {
        this.keyNameProject = keyNameProject;
    }
}
