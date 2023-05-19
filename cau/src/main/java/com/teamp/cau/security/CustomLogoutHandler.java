package com.teamp.cau.security;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomLogoutHandler implements LogoutHandler {

    @Autowired
    private HttpSession session;

    @Override
    public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        // 세션 무효화
        session.invalidate();
        // 로그아웃 후 리다이렉트할 URL 설정
        String targetUrl = "/main";
        // 로그아웃 처리 후 리다이렉트
        try {
            response.sendRedirect(targetUrl);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
