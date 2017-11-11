package userpage;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import org.apache.log4j.Logger;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

public class ParseCookie {
    private static final Logger log = Logger.getLogger(ParseCookie.class);
    private String token = null;

    public ParseCookie(HttpServletRequest req) {
        Cookie[] cookies = req.getCookies();

        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("auth")) {
                    token = c.getValue();
                    log.info("token: " + token);
                }
            }
        }
    }

    public int getUserIdFromToken() throws IOException {
        int userId = 0;
        Jws<Claims> jws = Jwts.parser()
                .setSigningKey("zhigalo".getBytes("UTF-8"))
                .parseClaimsJws(token);

        userId = Integer.parseInt(String.valueOf(jws.getBody().get("id")));

        return userId;
    }

    public int getPositionIdFromToken() throws UnsupportedEncodingException {
        int positionId = 1;
        Jws<Claims> jws = Jwts.parser()
                .setSigningKey("zhigalo".getBytes("UTF-8"))
                .parseClaimsJws(token);

        positionId = Integer.parseInt(String.valueOf(jws.getBody().get("position")));

        return positionId;
    }

    public String getLoginFromToken() throws UnsupportedEncodingException {
        String login = null;
        Jws<Claims> jws = Jwts.parser()
                .setSigningKey("zhigalo".getBytes("UTF-8"))
                .parseClaimsJws(token);

        login = String.valueOf(jws.getBody().get("login"));

        return login;
    }
}
