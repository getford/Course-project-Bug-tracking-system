package adminpage.add;

import database.Connect;
import mail.SendMail;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/adduser")
public class AddUser extends HttpServlet {
    private static final Logger log = Logger.getLogger(AddUser.class);

    private SendMail sendMail = new SendMail();

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id_position = selectIdPosition(req, resp);
            String login = req.getParameter("login");
            String password = getPassword(req);
            String email = req.getParameter("email");
            String fname = req.getParameter("fname");
            String lname = req.getParameter("lname");

            final String queryInsertUser = "INSERT INTO users (id_position, login, password, email, firstname, lastname) " +
                    "VALUES (" + id_position + ",'" + login + "','" + password + "','" + email + "','" + fname + "','" + lname + "')";

            connect = new Connect();
            statement = connect.getConnection().createStatement();
            statement.executeUpdate(queryInsertUser);

            sendMail.sendMailRegistration(email, login, password, req);

            log.info("Query: " + queryInsertUser);
            resp.sendRedirect("/adminpage.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private int selectIdPosition(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        int tmpIdPosition = 0;
        try {
            String namePosition = req.getParameter("position");
            final String query = "SELECT id FROM position WHERE name = '" + namePosition + "'";

            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(query);

            while (resultSet.next())
                tmpIdPosition = resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }

        return tmpIdPosition;

    }

    private String getPassword(HttpServletRequest req) {
        String resultPassword = null;
        String password = req.getParameter("password");
        String passwordV = req.getParameter("passwordv");

        if (password.equals(passwordV))
            resultPassword = password;
        else
            System.out.println("Error password not confirme...........................");


        return resultPassword;
    }
}
