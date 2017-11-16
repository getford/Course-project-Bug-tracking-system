package bugs.classes;

public class AssigneedBug {
    private String id;
    private String type;
    private String priority;
    private String dateCreate;
    private String title;

    public AssigneedBug(String id, String type, String priority, String dateCreate, String title) {
        this.id = id;
        this.type = type;
        this.priority = priority;
        this.dateCreate = dateCreate;
        this.title = title;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
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
}
