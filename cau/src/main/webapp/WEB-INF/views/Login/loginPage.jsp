<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
</head>
<body>
<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
	<p style="color:red; font-weight:bold;"> login Failed : ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message }</p>
	<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session" />
</c:if>
    <form action="/auth" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <h2>로그인</h2>
            <div>
                <input type="text" name="USER_ID" placeholder="USER_ID"/>
            </div>
            <div>
                <input type="password" name="PSWD" placeholder="PSWD"/>
            </div>

            <button type="submit">로그인</button>
<!--             <button type="button" onclick="location.href='signup'">회원가입</button> -->
			 <button type="button" onclick="location.href='Login/findid'">아이디 찾기</button>
			 <button type="button" onclick="location.href='Login/findpass'">비밀번호 찾기</button>
    </form>
</body>
</html>