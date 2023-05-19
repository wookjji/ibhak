package com.teamp.cau.security;

import java.util.Collection;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import com.teamp.cau.vo.UserVo;

public class CustomAuthenticationToken extends UsernamePasswordAuthenticationToken {

    private final UserVo userVo;

    public CustomAuthenticationToken(Object principal, Object credentials, UserVo userVo,
                                      Collection<? extends GrantedAuthority> authorities) {
        super(principal, credentials, authorities);
        this.userVo = userVo;
    }

    public UserVo getUserVo() {
        return userVo;
    }
}