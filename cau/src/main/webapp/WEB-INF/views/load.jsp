<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PDF Viewer</title>
</head>
<body>	
    <embed src="${pdfSrc }" type="application/pdf" width="100%" height="100%"/>
</body>
</html>
