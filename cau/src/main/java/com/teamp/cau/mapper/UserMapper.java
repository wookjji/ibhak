package com.teamp.cau.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.teamp.cau.vo.UserVo;

@Mapper
public interface UserMapper {
    List<UserVo> getUserList(); // User 테이블 가져오기
    void insertUser(UserVo userVo); // 회원 가입
    UserVo getUserById(String USER_ID); // 회원 정보 가져오기
    UserVo getUserByNo(Long USER_NO); // PK가져오기
    void updateUser(UserVo userVo); // 회원 정보 수정
    void deleteUser(Long USER_NO); // 회원 탈퇴
    UserVo findIdByNameAndTel(Map<String, Object> paramMap);
    UserVo findPassword(@Param("USER_ID") String USER_ID, @Param("KORN_FLNM") String KORN_FLNM, @Param("TELNO") String TELNO);
    void updatePassword(@Param("TELNO") String TELNO, @Param("PSWD") String PSWD);
	
}