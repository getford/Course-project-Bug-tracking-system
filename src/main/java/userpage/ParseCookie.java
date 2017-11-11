package userpage;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ParseCookie {
    public int getUserIdFromCookie(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = 1;
        String token = null;
        Cookie[] cookies = req.getCookies();

        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("auth")) {
                    token = c.getValue();
                }
            }

            Jws<Claims> jws = Jwts.parser()
                    .setSigningKey("zhigalo".getBytes("UTF-8"))
                    .parseClaimsJws(token);

            id = Integer.parseInt(String.valueOf(jws.getBody().get("position")));
            System.out.println("id: " + id);
        } else {
            resp.sendRedirect("/index.jsp");
        }

        return id;
    }
}
