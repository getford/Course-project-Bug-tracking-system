import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.impl.crypto.MacProvider;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Key;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(urlPatterns = "/index")
public class Index extends HttpServlet {
    private static final Logger log = Logger.getLogger(Index.class);
    private static final Key key = MacProvider.generateKey();

    private int id;
    private String login;
    private String password;
    private int position;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        login(req, resp);
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter printWriter = resp.getWriter();

        setLogin(req.getParameter("login"));
        setPassword(req.getParameter("password"));

        Connect connect;
        Statement statement;
        ResultSet resultSet;

        String querySelect = "SELECT id, login, password, id_position FROM users WHERE login = '" + getLogin() + "'";

        if (!getLogin().equals("") && !getPassword().equals("")) {
            String tmpLogin = null;
            String tmpPassword = null;

            try {
                connect = new Connect();
                statement = connect.getConnection().createStatement();
                resultSet = statement.executeQuery(querySelect);

                while (resultSet.next()) {
                    setId(resultSet.getInt(1));
                    tmpLogin = resultSet.getString(2);
                    tmpPassword = resultSet.getString(3);
                    setPosition(resultSet.getInt(4));
                }
                resultSet.close();

                if (getLogin().equals(tmpLogin)) {
                    if (getPassword().equals(tmpPassword)) {
                        String token = Jwts.builder()
                                .setSubject("AuthToken")
                                //.setExpiration(new Date(1300819380))
                                .claim("id", getId())
                                .claim("login", getLogin())
                                .claim("position", getPosition())
                                .signWith(SignatureAlgorithm.HS512,
                                        "zhigalo".getBytes("UTF-8")
                                )
//                                .signWith(
//                                        SignatureAlgorithm.HS256,
//                                        key
//                                )
                                .compact();

                        Cookie cookie = new Cookie("auth", token);
                        cookie.setMaxAge(-1); //  the cookie will persist until browser shutdown
                        resp.addCookie(cookie);

                        if (getPosition() == 0) {
                            log.info("Redirect to /adminpage.jsp");
                            resp.sendRedirect("/adminpage.jsp");
                        } else {
                            log.info("Redirect to /userpage.jsp");
                            resp.sendRedirect("/userpage.jsp");
                        }
                    } else {
                        log.debug("Password is wrong");
                        printWriter.println("Password is wrong.");
                    }
                } else {
                    log.debug("Login is wrong");
                    printWriter.println("Login is wrong.");
                }

            } catch (SQLException e) {
                req.setAttribute("err", e);
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        } else {
            printWriter.println("Login or password clear");
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }
}


/*
                    while (resultSet.next()) {
                        tmpLogin = resultSet.getString(1);
                        setPosition(resultSet.getString(2));
                    }

                    if (getLogin().equals(tmpLogin)) {
                        resultSet = statement.executeQuery(querySelectPassword);
                        while (resultSet.next()) {
                            tmpPassword = resultSet.getString(1);
                        }
                        resultSet.close();

                        if (getPassword().equals(tmpPassword)) {

                            String token = Jwts.builder()
                                    .setSubject("users/TzMUocMF4p")
                                    .setExpiration(new Date(1300819380))
                                    .claim("id", "")
                                    .claim("login", getLogin())
                                    .claim("position", getPosition())
                                    .signWith(
                                            SignatureAlgorithm.HS512,
                                            key
                                    )
                                    .compact();

                            if (getPosition().equals(0))
                                resp.sendRedirect("/adminpage.jsp");
                            resp.sendRedirect("/userpage.jsp");
                        requestDispatcher = req.getRequestDispatcher("/userpage.jsp");
                        requestDispatcher.forward(req, resp);
                        } else
                                printWriter.println("Password wrong!");
                                } else
                                printWriter.println("Login wrong");
                                } else
                                printWriter.println("Login incorrect");
                                resultSet.close();
*/