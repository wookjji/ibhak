<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
</head>
<body>
    <h2>${user.KORN_FLNM}님의 회원 정보</h2>

    <p>USER_ID: ${user.USER_ID}</p>
    <p>PSWD: ${user.PSWD}</p>
    <p>USER_BRDT: ${user.USER_BRDT}</p>
    <p>EML_ADDR: ${user.EML_ADDR}</p>
    <p>TELNO: ${user.TELNO}</p>
   <p> ${userAuthority}</p>

    <button type="button" onclick="location.href='update'">비밀번호 변경하기</button>

    <form action="/logout" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button type="submit">로그아웃</button>
    </form>
<button type="button" onclick="location.href='main'">홈으로</button>
<!--     <form action="/delete" method="post"> 
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button type="submit">탈퇴하기</button>
    </form>-->
</body>
</html>