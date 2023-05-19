<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!DOCTYPE html>
<html>
<script>
$(function(){
    $("#btn").click(function(){
        if($("#in").val() == ""){
       alert("!");
}
    });
});
</script>
<head>
<style>
.imge_size{
    width:100px;
    height:200px;
}
.test{
    width:100px;
    height:200px;
    background-color:red;
}
.imge_size>img{
    width:180px;
    height:215px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form id="file" action="/test" method="post" enctype="multipart/form-data">
파일<input type="file" id="in" name="image">
<button id="btn" type="submit">사진보내기</button>
<hr>
<c:forEach items="${list}" var="c">

<image src="data:image/jpeg;base64,${c.eml_addr}">
</c:forEach>
<hr>
 <input type="file" id="image" accept="image/*" onchange="setThumbnail(event);"/>
    <div class="imge_size" id="image_container"></div>
    <div class="test"></div>

</body>
<script>
      function setThumbnail(event) {
        var reader = new FileReader();

        reader.onload = function(event) {
          var img = document.createElement("img");
          img.setAttribute("src", event.target.result);
          document.querySelector("div#image_container").appendChild(img);
        };

        reader.readAsDataURL(event.target.files[0]);
      }
    </script>
</html>