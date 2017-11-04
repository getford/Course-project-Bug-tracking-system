package userpage.classes;

public class Project {
    private int id;
    private int idUserLead;
    private String nameProject;
    private String keyNameProject;

    public Project(int id, int idUserLead, String nameProject, String keyNameProject) {
        this.id = id;
        this.idUserLead = idUserLead;
        this.nameProject = nameProject;
        this.keyNameProject = keyNameProject;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUserLead() {
        return idUserLead;
    }

    public void setIdUserLead(int idUserLead) {
        this.idUserLead = idUserLead;
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
