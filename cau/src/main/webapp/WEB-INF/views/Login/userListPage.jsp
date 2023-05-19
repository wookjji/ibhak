<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User List</title>
</head>
<body>
    <h2>User List</h2>
    <table>
        <tr>
            <th>USER_NO</th>
            <th>USER_ID</th>
            <th>PSWD</th>
            <th>KORN_FLNM</th>
            <th>USER_BRDT</th>
            <th>EML_ADDR</th>
            <th>TELNO</th>
        </tr>
        <c:forEach items="${list}" var="u">
        <tr>
            <td>${u.USER_NO}</td>
            <td>${u.USER_ID}</td>
            <td>${u.PSWD}</td>
            <td>${u.KORN_FLNM}</td>
            <td>${u.USER_BRDT}</td>
            <td>${u.EML_ADDR}</td>
            <td>${u.TELNO}</td>
        </tr>
        </c:forEach>
    </table>
</body>
</html>