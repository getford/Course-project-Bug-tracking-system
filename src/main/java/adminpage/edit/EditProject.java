package adminpage.edit;

import cookie.CheckCookie;
import cookie.ParseCookie;
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

@WebServlet(urlPatterns = "/editproject")
public class EditProject extends HttpServlet {

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ParseCookie parseCookie = new ParseCookie(req);
        CheckCookie checkCookie = new CheckCookie();
        SelectUserInfo selectUserInfo = new SelectUserInfo();
        SendMail sendMail = new SendMail();
        String id = req.getParameter("idProject");

        String nameP = req.getParameter("pName");
        String key = req.getParameter("kName");
        int idLeader = Integer.parseInt(req.getParameter("idLead"));


        String queryUpdate = "UPDATE projects SET " +
                "name = '" + nameP + "', " +
                "key_name = '" + key + "', " +
                "id_user_lead = " + idLeader +
                " WHERE id = " + id.substring(4);
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            statement.executeUpdate(queryUpdate);


            sendMail.sendMailEditProject(leaderEmail(idLeader),
                    selectUserInfo.selectUserEmailFromToken(parseCookie.getUserIdFromToken()),
                    nameP,
                    selectUserInfo.selectUserNameFromToken(parseCookie.getUserIdFromToken()),
                    req);
            connect.close();
            if (checkCookie.isAdmin(req.getCookies(), parseCookie.getPositionIdFromToken()))
                resp.sendRedirect("/adminpage.jsp");
            else
                resp.sendRedirect("/userpage.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

     String leaderEmail(int id) {
        String email = null;
        String query = "SELECT email FROM users WHERE id = '" + id + "'";

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                email = resultSet.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return email;
    }

}
