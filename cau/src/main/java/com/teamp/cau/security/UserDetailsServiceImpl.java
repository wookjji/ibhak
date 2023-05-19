package com.teamp.cau.security;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.teamp.cau.service.UserService;
import com.teamp.cau.vo.UserVo;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
@Autowired
private UserService userService;
@Override
public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    UserVo userVo = userService.getUserById(username);
    if (userVo == null) {
        throw new UsernameNotFoundException("User not found");
    }

    return new CustomUserDetails(userVo);
}
}