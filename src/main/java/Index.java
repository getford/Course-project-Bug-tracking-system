import com.sun.org.apache.xml.internal.security.algorithms.SignatureAlgorithm;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(urlPatterns = "/index")
public class Index extends HttpServlet {
    private String login;
    private String password;
    private String position;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        setLogin(req.getParameter("login"));
        setPassword(req.getParameter("password"));

        Connect connect;
        Statement statement;
        ResultSet resultSet;

        String querySelectLogin = "SELECT login, id_position FROM users WHERE login = '" + getLogin() + "'";
        String querySelectPassword = "SELECT password FROM users WHERE password = '" + getPassword() + "'";

        if (!getLogin().equals("") && !getPassword().equals("")) {
            String tmpLogin = null;
            String tmpPassword = null;

            PrintWriter printWriter = resp.getWriter();
//            RequestDispatcher requestDispatcher = null;

            try {
                connect = new Connect();
                statement = connect.getConnection().createStatement();
                resultSet = statement.executeQuery(querySelectLogin);
                while (resultSet.next()) {
                    tmpLogin = resultSet.getString(1);
                    setPosition(resultSet.getString(2));
                }
                resultSet.close();

                if (getLogin().equals(tmpLogin)) {
                    resultSet = statement.executeQuery(querySelectPassword);
                    while (resultSet.next()) {
                        tmpPassword = resultSet.getString(1);
                    }
                    resultSet.close();

                    if (getPassword().equals(tmpPassword)) {
                        if(getPosition().equals(0))
                            resp.sendRedirect("/adminpage.jsp");
                        resp.sendRedirect("/userpage.jsp");
                        /*requestDispatcher = req.getRequestDispatcher("/userpage.jsp");
                        requestDispatcher.forward(req, resp);*/
                    } else
                        printWriter.println("Password wrong!");
                } else
                    printWriter.println("Login wrong");


            } catch (SQLException e) {
                req.setAttribute("err", e);
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println();
        }
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
