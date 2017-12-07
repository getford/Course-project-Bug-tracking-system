package adminpage;

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

    SendMail sendMail = new SendMail();

    private Connect connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            addUser(req, resp);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        try {
            int id_position = selectIdPosition(req, resp);
            String login = req.getParameter("name");
            String password = getPassword(req, resp);
            String email = req.getParameter("email");
            String fname = req.getParameter("fname");
            String lname = req.getParameter("lname");

            final String queryInsertUser = "INSERT INTO users (id_position,login,password,email,firstname,lastname)" +
                    "VALUES (" + id_position + "," + login + "," + password + "," + email + "," + fname + "," + lname + ")";

            connect = new Connect();
            statement = connect.getConnection().createStatement();
            resultSet = statement.executeQuery(queryInsertUser);

            sendMail.sendMailRegistration(email, login, password);

            log.info("Query: " + queryInsertUser);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }

        resp.sendRedirect("/adminpage.jsp");

    }

    private int selectIdPosition(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
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
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            assert resultSet != null;
            resultSet.close();
            statement.close();
            connect.close();
        }

        return tmpIdPosition;

    }

    private String getPassword(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        String password = req.getParameter("password");
        String passwordV = req.getParameter("passwordv");

        return password;
    }
}
