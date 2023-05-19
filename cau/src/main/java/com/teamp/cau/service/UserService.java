package com.teamp.cau.service;

import java.security.SecureRandom;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.teamp.cau.mapper.UserMapper;
import com.teamp.cau.vo.UserVo;



@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public List<UserVo> getUserList() {
        return userMapper.getUserList();
    }

    public UserVo getUserByNo(Long USER_NO) {
        return userMapper.getUserByNo(USER_NO);
    }

    public UserVo getUserById(String USER_ID) {
        return userMapper.getUserById(USER_ID);
    }

    public void signup(UserVo userVo) { // 회원 가입
        if (!userVo.getUSER_ID().equals("")) {
		    // password는 암호화해서 DB에 저장           
            userVo.setPSWD(passwordEncoder.encode(userVo.getPSWD()));
            userMapper.insertUser(userVo);
        }
    }

    public void edit(UserVo userVo) { // 회원 정보 수정
 		// password는 암호화해서 DB에 저장      
        userVo.setPSWD(passwordEncoder.encode(userVo.getPSWD()));
        userMapper.updateUser(userVo);
    }

    public void withdraw(Long USER_NO) { // 회원 탈퇴
        userMapper.deleteUser(USER_NO);
    }

    public PasswordEncoder passwordEncoder() { 
        return this.passwordEncoder;
    }
    
    
    
    public String findIdByNameAndTel(String KORN_FLNM, String TELNO) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("KORN_FLNM", KORN_FLNM);
        paramMap.put("TELNO", TELNO);
        UserVo findid = userMapper.findIdByNameAndTel(paramMap);
        if (findid == null) {
            return null;
        }
        return findid.getUSER_ID();
    }
    
    
    private SecureRandom random = new SecureRandom();
    public String resetPassword(String USER_ID, String KORN_FLNM, String TELNO) {
        // 사용자 확인
        UserVo user = userMapper.findPassword(USER_ID, KORN_FLNM, TELNO);
        if (user == null) {
            return null;
        }

        // 6자리 난수 생성
        byte[] bytes = new byte[4];
        random.nextBytes(bytes);
        String tempPassword = Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);

        // 암호화된 비밀번호 생성
        String encryptedPassword = passwordEncoder.encode(tempPassword);
        // DB에 암호화된 비밀번호 저장
        userMapper.updatePassword(TELNO, encryptedPassword);

        return tempPassword;
    }

    
}

