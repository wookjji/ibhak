<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>    
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/IdFind.css">
<title>USER_ID</title>
</head>
<style>
    .error-message {
        color: red;
    }
</style>
<body>
<div class="session">
    <div class="left">
      <?xml version="1.0" encoding="UTF-8"?>
      <svg enable-background="new 0 0 300 302.5" version="1.1" viewBox="0 0 300 302.5" xml:space="preserve" xmlns="http://www.w3.org/2000/svg">
<style type="text/css">
	.st0{fill:#fff;}
</style>
</svg>      
    </div>
    <form class="log-in" autocomplete="off"> 
      <h4>여기는<span>  Cau</span></h4>
      <%-- error 메시지 출력 --%>
     <c:if test="${not empty error}">
    <p class="error-message">${error}</p>
</c:if>

      <c:if test="${empty error}">
          <p>당신의 아이디는 ${USER_ID} 입니다.</p>
      </c:if>
    </form>
</div>


</body>
</html>