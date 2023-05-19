<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modify Information</title>
</head>
<style>
    .updateframe{
        padding-left: 50px;
        padding-top: 50px;
    }
</style>
<body>
    <div class="updateframe">
    <h2>회원 정보 수정</h2>
    <form action="/update" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <p>
            사용자ID<br>
            <input type="text" name="USER_ID" value="${user.USER_ID}" readonly/>
        </p>
        <p>
            사용자이름<br>
            <input type="text" name="KORN_FLNM" value="${user.KORN_FLNM}" readonly />
        </p>
        <p>
            사용자 핸드폰번호<br>
            <input type="text" name="TELNO" value="${user.TELNO}" readonly/>
        </p>
        <p>
            새 비밀번호입력<br>
            <input type="password" name="PSWD"  placeholder="새 비밀번호를 입력해주세요"/>
        </p>
        <p>
            새 비밀번호확인<br>
            <input type="password" name="PSWD_CONFIRM"  placeholder="다시 한번 입력해주세요"/>
        </p>
      
         <p style="color:red" id="pswd-error"></p>
    <button type="submit" onclick="return validate()">저장하기</button>
</form>
</div>
<script type="text/javascript">
function validate() {
    var newPassword = document.getElementsByName("PSWD")[0].value;
    var newPasswordConfirm = document.getElementsByName("PSWD_CONFIRM")[0].value;
    if(newPassword.length < 8) {
        document.getElementById("pswd-error").innerHTML = "비밀번호는 8자 이상이어야 합니다.";
        return false;
    } else if(newPassword !== newPasswordConfirm) {
        document.getElementById("pswd-error").innerHTML = "비밀번호가 서로 일치하지 않습니다.";
        return false;
    } else {
        document.getElementById("pswd-error").innerHTML = "";
    }

    // 새 비밀번호만 서버로 전송
    document.getElementsByName("PSWD_CONFIRM")[0].disabled = true;
    alert("비밀번호가 정상적으로 변경되었습니다."); // 메시지 출력
    return true;
}
</script>
</body>
</html>