package adminpage.edit;

import cookie.CheckCookie;
import cookie.ParseCookie;
import createissue.CreateIssue;
import database.Connect;
import mail.SendMail;
import userpage.SelectUserInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(urlPatterns = "/editbug")
public class EditBug extends HttpServlet {

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ParseCookie parseCookie = new ParseCookie(req);
        CheckCookie checkCookie = new CheckCookie();
        SelectUserInfo selectUserInfo = new SelectUserInfo();
        CreateIssue createIssue = new CreateIssue();
        EditProject editProject = new EditProject();

        SendMail sendMail = new SendMail();
        int id = Integer.parseInt(req.getParameter("idBug").substring(4));
        int idType = Integer.parseInt(req.getParameter("nameTypeIssue"));
        int idStatus = Integer.parseInt(req.getParameter("statusName"));
        int idPriority = Integer.parseInt(req.getParameter("namePriority"));
        String dateCreate = req.getParameter("date_issue");
        String title = req.getParameter("title_issue");
        String description = req.getParameter("description");
        String environment = req.getParameter("environment");


        try {
            String queryUpdate = "UPDATE bugs SET " +
                    "id_type = " + idType + ", " +
                    "id_status = " + idStatus + ", " +
                    "id_priority = " + idPriority + ", " +
                    "id_user_assignee = " + createIssue.selectIdUserAssignee(req, resp) + ", " +
                    "id_user_reporter = " + parseCookie.getUserIdFromToken() + ", " +
                    "date_create = '" + dateCreate + "', " +
                    "title = '" + title + "', " +
                    "description = '" + description + "', " +
                    "environment = '" + environment + "' " +
                    " WHERE id = " + id;

            connect = new Connect();
            statement = connect.getConnection().createStatement();
            statement.executeUpdate(queryUpdate);


            sendMail.sendMailEditBug(editProject.leaderEmail(createIssue.selectIdUserAssignee(req, resp)),
                    selectUserInfo.selectUserEmailFromToken(parseCookie.getUserIdFromToken()),
                    req.getParameter("idBug"), req);
            if (checkCookie.isAdmin(req.getCookies(), parseCookie.getPositionIdFromToken()))
                resp.sendRedirect("/adminpage.jsp");
            else
                resp.sendRedirect("/userpage.jsp");

            connect.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
