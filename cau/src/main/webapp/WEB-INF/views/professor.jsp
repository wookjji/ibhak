<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="description" content="">
<meta name="author" content="">

<title>CAU - 교수정보입력</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
   type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
   rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<style>
ul {list-style: none; color: black;}
li {float: left; color: black; padding-left: 0;}
.top_box {width: 50%; height: 90px; border: 1px solid; border-radius: 3px; background-color: #a2bfdd;}
.middle_box {width: 50%;height: 90px;border: 1px solid;border-radius: 3px;background-color: #a2bfdd;}
.bottom_box {width: 50%;height: 170px;border: 1px solid;border-radius: 3px;background-color: #a2bfdd;}
.Title1 {width: 15%;height: 35px;text-align: left;line-height: 35px;}
.Answer1 {width: 40%;height: 35px;}
.divide {width: 100%;height: 5px;}
.text1 {width: 150%;margin: auto; height: 35px;}
.save_btn {background-color: #3E74C7;color: white;border-radius: 3px;height: 30px;width: 60px;}
.container-fluid {height: 90%;}
</style>
<script type="text/javascript">
function check(){
   var f = document.form;
   //id
   if(f.pr_id.value == ""){
      alert("아이디를 입력해주세요");
      f.pr_id.focus();
      return false;
   }
   //pw
   if(f.pr_pw.value == ""){
      alert("비밀번호를 입력해주세요");
      f.pr_pw.focus();
      return false;
   }
   //pr_no
   if(f.pr_no.value == ""){
      alert("교수번호를 입력해주세요");
      f.pr_no.focus();
      return false;
   }
   //pr_birth
   if(f.pr_birth.value == ""){
      alert("생년월일을 입력해주세요");
      f.pr_birth.focus();
      return false;
   }
   //pr_email
   if(f.pr_email.value == ""){
      alert("이메일을 입력해주세요");
      f.pr_email.focus();
      return false;
   }
   //pr_telno
   if(f.pr_telno.value == ""){
      alert("연락처를 입력해주세요");
      f.pr_telno.focus();
      return false;
   }
   return true;
}

function check_email(){
   let input = document.getElementById("pr_email").value;
   let email_format = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
   if(email_format.test(input)) alert("저장완료");
   else{
      alert("잘못된 형식의 이메일입니다.");
      document.getElementById("pr_email").value = "";
   }
}

$(function(){
   $("#save_btn").on("click", function(){
      var form1 = $("#form").serialize();
      
     // alert(form);
      $.ajax({
         type: "post",
         url: "/professor_info",
         data: form1,
         dataType: "json",
         success: function(data){
             $("#pr_id").val("");  // 아이디 input text 비움
             $("#pr_pw").val("");  // 비밀번호 input text 비움
             $("#pr_no").val("");  // 교수번호 input text 비움
             $("#pr_dep").val("");  // 학과코드 input text 비움
             $("#pr_name").val("");  // 이름 input text 비움
             $("#pr_birth").val("");  // 생년월일 input text 비움
             $("#pr_email").val("");  // 이메일 input text 비움
             $("#pr_telno").val("");  // 연락처 input text 비움
           },
            error: function(request, status, error){
              alert("실패");
            }
      });
   });
});
</script>
</head>
<body>
   <br>
   <!-- Begin Page Content -->
   <div class="container-fluid">
      <!-- Page Heading -->
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
         <h1 class="h3 mb-0 text-gray-800">교수정보입력</h1>
      </div>
      <!-- Divider -->
      <hr class="sidebar-divider">

      <div class="info_table">
         <form action="/professor_info" name="form" id="form" method="post" onsubmit="return check();">
            <div class="top_box">
               <ul>
                  <li class="divide"></li>
                  <li class="Title1">아이디</li>
                  <li class="Answer1"><input type="text" class="text1" maxlength="16"
                     oninput="this.value=this.value.replace(/[^a-zA-Z0-9]/g, '');"
                     id="pr_id" name="pr_id"></li>
                  <li class="divide"></li>
                  <li class="Title1">비밀번호</li>
                  <li class="Answer1"><input type="password" class="text1"
                     id="pr_pw" name="pr_pw"></li>
                  <li class="divide"></li>
               </ul>
            </div>
            <br>
            <div class="middle_box">
               <ul>
                  <li class="divide"></li>
                  <li class="Title1">교수번호</li>
                  <li class="Answer1"><input type="text" class="text1"
                     id="pr_no" name="pr_no"
                     oninput="this.value=this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g,'$1');"></li>
                  <li class="divide"></li>
                  <li class="Title1">학과코드</li>
                  <li class="Answer1"><input type="text" class="text1"
                     id="pr_dep" name="pr_dep"
                     oninput="this.value=this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g,'$1');"></li>
                  <li class="divide"></li>
               </ul>
            </div>
            <br>
            <div class="bottom_box">
               <ul>
                  <li class="divide"></li>
                  <li class="Title1">이름</li>
                  <li class="Answer1"><input type="text" class="text1" placeholder=" 한글로 입력하세요 "
                     id="pr_name" name="pr_name" oninput="this.value=this.value.replace(/[^ㄱ-힣]/g, '');"></li>
                  <li class="divide"></li>
                  <li class="Title1">생년월일</li>
                  <li class="Answer1"><input type="text" class="text1"
                     id="pr_birth" name="pr_birth" maxlength="6"
                     placeholder=" 예) 030201로 입력하세요"
                     oninput="this.value=this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g,'$1');"></li>
                  <li class="divide"></li>
                  <li class="Title1">이메일</li>
                  <li class="Answer1"><input type="text" class="text1"
                     id="pr_email" name="pr_email" placeholder=" 예) hong12@gamil.com "></li>
                  <li class="divide"></li>
                  <li class="Title1">연락처</li>
                  <li class="Answer1"><input type="text" class="text1"
                     id="pr_telno" name="pr_telno" maxlength="11"
                     placeholder=" - 없이 입력하세요"
                     oninput="this.value=this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g,'$1');"></li>
                  <li class="divide"></li>
                  <li class="cole"><input type="hidden" value="PROFESSOR"></li>
               </ul>
            </div>
            <br>
            <div class="save">
               <button type="button" class="save_btn" id="save_btn" onclick="check_email();">저장</button>
            </div>
         </form>
         <!-- info table 끝 -->
      </div>

   </div>
   <!-- End of Main Content -->
   <br>
   <!-- Bootstrap core JavaScript-->
   <script src="vendor/jquery/jquery.min.js"></script>
   <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

   <!-- Custom scripts for all pages-->
   <script src="js/sb-admin-2.min.js"></script>
</body>

</html>