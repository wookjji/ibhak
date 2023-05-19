package com.teamp.cau.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.teamp.cau.service.UserService;
import com.teamp.cau.vo.UserVo;

@Component
public class AuthProvider implements AuthenticationProvider {
    @Autowired
    private UserService userService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String userId = (String) authentication.getPrincipal(); // 로그인 창에 입력한 userId 
        String password = (String) authentication.getCredentials(); // 로그인 창에 입력한 password

        PasswordEncoder passwordEncoder = userService.passwordEncoder();
        CustomAuthenticationToken token;
        UserVo userVo = userService.getUserById(userId);

        if (userVo != null && passwordEncoder.matches(password, userVo.getPSWD())) {
            List<GrantedAuthority> roles = new ArrayList<>();
            roles.add(new SimpleGrantedAuthority("ROLE_" + userVo.getROLE_CODE().name()));

            token = new CustomAuthenticationToken(userVo.getUSER_NO(), null, userVo, roles);
            return token;
        }

        throw new BadCredentialsException("아이디 혹은 비밀번호가 틀렸습니다.");
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return true;
    }
}
