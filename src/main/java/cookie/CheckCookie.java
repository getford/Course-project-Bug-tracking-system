package cookie;

import javax.servlet.http.Cookie;

public class CheckCookie {
    public boolean isAuthorized(Cookie[] cookies) {
        boolean flag = false;
        for (Cookie cooky : cookies) {
            if (cooky.getName().equals("auth"))
                flag = true;
        }
        return flag;
    }
}
