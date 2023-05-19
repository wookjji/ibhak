package com.teamp.cau.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.teamp.cau.vo.UserVo;

import java.util.Collection;
import java.util.Collections;

public class CustomUserDetails implements UserDetails {

    private final UserVo userVo;

    public CustomUserDetails(UserVo userVo) {
        this.userVo = userVo;
    }

    public UserVo getUserVo() {
        return userVo;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + userVo.getROLE_CODE().name()));
    }

    @Override
    public String getPassword() {
        return userVo.getPSWD();
    }

    @Override
    public String getUsername() {
        return userVo.getUSER_ID();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
