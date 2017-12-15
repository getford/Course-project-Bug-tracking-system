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

@WebServlet(urlPatterns = "/edituser")
public class EditUser extends HttpServlet {

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ParseCookie parseCookie = new ParseCookie(req);
        CheckCookie checkCookie = new CheckCookie();
        SelectUserInfo selectUserInfo = new SelectUserInfo();
        SendMail sendMail = new SendMail();
        int id = Integer.parseInt(req.getParameter("idUser"));

        String login = req.getParameter("login");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String firstName = req.getParameter("fname");
        String lastName = req.getParameter("lname");
        String position = req.getParameter("position");


        String queryUpdate = "UPDATE users SET " +
                "id_position = " + selectIdPosition(position) + ", " +
                "login = '" + login + "', " +
                "password = '" + password + "', " +
                "email = '" + email + "', " +
                "firstname = '" + firstName + "', " +
                "lastname = '" + lastName + "' WHERE id = " + id;
        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            statement.executeUpdate(queryUpdate);


            sendMail.sendMailEditUser(email,
                    selectUserInfo.selectUserEmailFromToken(parseCookie.getUserIdFromToken()),
                    selectUserInfo.selectUserNameFromToken(parseCookie.getUserIdFromToken()),
                    login,
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

    private int selectIdPosition(String name) {
        int id = 0;
        String query = "SELECT id FROM position WHERE name = '" + name + "'";

        try {
            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                id = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }
}
