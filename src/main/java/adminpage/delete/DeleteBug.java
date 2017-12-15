package adminpage.delete;

import database.Connect;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(urlPatterns = "/deletebug")
public class DeleteBug extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id").substring(4);

        try {
            Connect connect = new Connect();
            Statement statement = connect.getConnection().createStatement();
            String queryDeleteBug = "DELETE FROM bugs WHERE id = " + Integer.parseInt(id);
            statement.execute(queryDeleteBug);
            resp.sendRedirect("/adminpage.jsp");

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }
}
