<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
ul, li{display: block; list-style: none; float: left;}
.box{width: 100%; height: 40px; text-align: center; color: black; border-radius: 3px; background-color: #a2bfdd; }
.t1{width: 40%; position: relative; top: 5px;}
.t2{width: 40%; position: relative; top: 7px;}
.t3{width: 20%; position: relative; top: 5px;}
table{width: 100%; color: black;}
thead{background-color: #a2bfdd;}
.pr_no{width:6%; text-align: center;}
.major{width:6%; text-align: center;}
.name{width:7%; text-align: center;}
.birth{width:10%; text-align: center;}
.email{width:14%; text-align: center;}
.telno{width:12%; text-align: center;}
.addr{width:18%; text-align: center;}
.detail_addr{width:14%; text-align: center;}
.gender{width:4%; text-align: center;}
.authority{width:7%; text-align: center;}
.result{width:5%; text-align: center;}
container-fluid{height: 100%;}
.auth_btn{background-color: #3E74C7; color: white; border-radius: 3px;  height: 30px; width: 80px;}
.authresult{ width: 100%;}

</style>
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>CAU - 교수정보권한  </title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>
<body>
   <br>
   <div class="container-fluid">

      <!-- 페이지 제목  -->
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
         <h1 class="h3 mb-0 text-gray-800">교수정보권한</h1>
      </div>
      <!-- Divider -->
      <hr class="sidebar-divider">
      <!-- 페이지 헤더  -->
      <div class="search">
            <!-- searchbox -->
            <ul class="box">
               <li class="t1">교수이름 &nbsp; <input type="text"
                  name="name_search" id="name_search"></li>
               <li class="t2">학과코드 &nbsp; 
               <select name="code_search" id="code_search">
               <option value="all">학과 선택</option>
               <c:set var="code" value="1"></c:set>
               <c:forEach items="${depart }" var="de">
               <option value="${code }"> ${de.DEPARTMENT } </option>
               <c:set var="code" value="${code+1 }"></c:set>
               </c:forEach>
               </select> </li>
               <li class="t3"><button class="search_btn" type="button">
                  <img alt="icon" src="img/search_icon.png" width="20" height="20">
                  </button></li>
            </ul>
         
      </div>
      <br>

      <!-- 페이지 리스트  -->
         <table border="1">
            <thead>
               <tr>
                  <th class="pr_no">교수번호</th>
                  <th class="major">학과코드</th>
                  <th class="name">한글성명</th>
                  <th class="birth">생년월일</th>
                  <th class="email">이메일</th>
                  <th class="telno">연락처</th>
                  <th class="addr">주소</th>
                  <th class="detail_addr">상세주소</th>
                  <th class="gender">성별</th>
                  <th class="authority">평가권한</th>
               </tr>
            </thead>
            <tbody id="authlist">
               <c:forEach items="${list }" var="pr">
                  <tr>
                     <td class="pr_no">${pr.INSTR_NO }</td>
                     <td class="major">${pr.CRCLM_CD }</td>
                     <td class="name">${pr.KORN_FLNM }</td>
                     <td class="birth">${pr.USER_BRDT }</td>
                     <td class="email">${pr.EML_ADDR }</td>
                     <td class="telno">${pr.TELNO }</td>
                     <td class="addr">${pr.ADDR }</td>
                     <td class="detail_addr">${pr.DADDR }</td>
                     <td class="gender">${pr.GENDER }</td>
                     <td class="authority">
                        <!-- 옵션 선택으로 --> 
                        <select name="auth" class="auth">
                        <c:choose>
                        	<c:when test="${pr.ENDST_NO eq 0 }">
                           <option value="0" selected="selected">없음</option>
                           <option value="1">권한</option>
                           </c:when>
                           <c:when test="${pr.ENDST_NO eq 1 }">
                           <option value="0">없음</option>
                           <option value="1" selected="selected">권한</option>
                           </c:when>
                        </c:choose>
                     </select>
                     </td>
                  </tr>
               </c:forEach>
            </tbody>
         </table>
         <br>
         <button type="button" id="authbtn" class="auth_btn">권한주기</button>
   </div>
   <!-- /.container-fluid -->
   <br>
   <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
   
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
</body>
<script>
   $(function() {
      $(".search_btn").click(function() {
         var code = $("#code_search").val();
         var name = $("#name_search").val();
         $.ajax({
            url : "/pr_info_search",
            type : "GET",
            data : {"code" : code, "name" : name},
            datatype : "json",
            success : function(data){
               if($("#authlist").children().length){
                  $("#authlist").empty();
               }
               $.each(data,function(i, list){
            	   var check1 = list.ENDST_NO == 0 ? 'selected' : '';
            	   var check2 = list.ENDST_NO == 1 ? 'selected' : '';
                  var tableList = '<tr>'
                              +'<td class="pr_no">'+list.INSTR_NO+'</td>'
                              +'<td class="major">'+list.CRCLM_CD +'</td>'
                              +'<td class="name">'+list.KORN_FLNM +'</td>'
                              +'<td class="birth">'+list.USER_BRDT +'</td>'
                              +'<td class="email">'+list.EML_ADDR +'</td>'
                              +'<td class="telno">'+list.TELNO +'</td>'
                              +'<td class="addr">'+list.ADDR +'</td>'
                              +'<td class="detail_addr">'+list.DADDR +'</td>'
                              +'<td class="gender">'+list.GENDER +'</td>'
                              +'<td class="authority">'
                              +'<select name="auth" class="auth">'
                              +'<option id="0" value="0"'+check1+'>없음</option>'
                              +'<option id="1" value="1"'+check2+'>권한</option>'
                              +'</select></td>'
                              +'</tr>'
                              
                              $("#authlist").append(tableList);
               }); 
            }
         });
      });

      $("#authbtn").click(
            function() {
               var length = $("#authlist").children().length;
               var auth_test = new Array();
               var num = 0;
               for (var i = 0; i < length; i++) {
                  var prof_no = $("#authlist").children().eq(i).find(
                        ".pr_no").text();
                  var prof_auth = $("#authlist").children().eq(i).find(
                        ".authority").children().val();
                  num = num + 1;
                  auth_test[i] = {
                     "no" : prof_no,
                     "auth" : prof_auth
                  };
               }
               $.ajax({
                  url : "/pr_info_auth",
                  type : "post",
                  data : {
                     "auth_test" : auth_test,
                     "num" : num
                  },
                  success : function() {
                     alert("성공");
                  }
               });
            });
   });
</script>
</html>
