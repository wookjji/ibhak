<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign Up</title>
</head>
<body>
    <h2>회원가입</h2>
    <form action="/signup" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <div>
            <input type="text" name="USER_ID" placeholder="USER_ID"/>
        </div>
        <div>
            <input type="text" name="PSWD" placeholder="PSWD"/>
        </div>
        <div>
            <input type="text" name="KORN_FLNM" placeholder="KORN_FLNM"/>
        </div>
        <div>
            <input type="password" name="USER_BRDT" placeholder="USER_BRDT"/>
        </div>
        <div>
            <input type="text" name="EML_ADDR" placeholder="EML_ADDR"/>
        </div>
        <div>
            <input type="text" name="TELNO" placeholder="TELNO"/>
        </div>
        <button type="submit">회원가입</button>
    </form>
</body>
</html>