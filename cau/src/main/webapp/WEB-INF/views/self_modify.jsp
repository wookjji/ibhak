<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>CAU - 본인정보수정   </title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

   <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

<style>
ul{list-style: none; color: black;}
li{float: left; color: black; padding-left:0;}
.top_box{ width: 60%; height: 50px; border: 1px solid; border-radius: 3px; background-color: #a2bfdd; }
.middle_box{ width: 60%; height:90px; border: 1px solid; border-radius: 3px; background-color: #a2bfdd; }
.bottom_box{ width: 60%; height: 215px; border: 1px solid; border-radius: 3px; background-color: #a2bfdd;}
.Title1{ width: 15%; height: 35px; text-align: left; line-height: 35px; }
.Answer1{ width: 85%; height: 35px;}
.Title2{ width: 15%; height: 35px; line-height: 35px;}
.Answer2{ width: 85%; height: 35px;}
.Title3{ width: 15%; height: 35px; line-height: 35px;}
.Answer3{ width: 33.5%; height: 35px;}
.Answer4{ width: 60%; height: 35px;}
.text1{ width: 95%; margin: auto; height: 35px;}
.divide{ width: 100%; height: 5px;}
.img_box{width: 180px; height: 215px; border: 1px solid; line-height: 200px; text-align: center; background-color: white;}
.blank{ width: 180px; height: 215px;}
.addr_btn{ width: 15%; height: 30px; border-radius: 3px; background-color: #ccc;}
.imgfile{ width: 60%; height: 300px; border: 1px solid; border-radius: 3px; background-color: #a2bfdd;}
.container-fluid{height: 90%;} 
#image1{width: 180px; height: 215px;}
.img{width: 60%;}
.font{width: 60%;}
.save_btn{background-color: #3E74C7; color: white; border-radius: 3px;  height: 30px; width: 60px;}
</style>

</head>
<body>
   <br>
   <!-- Begin Page Content -->
   <div class="container-fluid">

      <!-- Page Heading -->
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
         <h1 class="h3 mb-0 text-gray-800">본인정보수정</h1>
      </div>
      <!-- Divider -->
      <hr class="sidebar-divider">

      <div class="info_table">
         <form action="/pr_self" name="form" id="form" method="post" onsubmit="return check();"
            enctype="multipart/form-data">

            <div class="top_box">
               <ul>
                  <li class="divide"></li>
                  <li class="Title1">교수번호</li>
                  <li class="Answer1"><input class="text1" type="text"
                     id="pr_no" name="pr_no" value="${dto.INSTR_NO}"  readonly
                     oninput="this.value=this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g,'$1');"></li>
                  <li class="divide"></li>
               </ul>
            </div>
            <br>

            <div class="middle_box">
               <ul>
                  <li class="divide"></li>
                  <li class="Title1">이름 [한글]</li>
                  <li class="Answer1"><input class="text1" type="text" readonly
                     id="name_kr" name="name_kr"value="${dto.KORN_FLNM}" ></li>
                  <li class="divide"></li>
                  <li class="Title1">이름 [영어]</li>
                  <li class="Answer1"><input class="text1" type="text"
                     id="name_en" name="name_en" maxlength="15" value="${dto.ENG_FLNM}" 
                     onkeyup="this.value=this.value.replace(/[^a-zA-Z]/g,' ');"></li>
               </ul>
            </div>
            <br>
            <div class="imgfile">
               <ul>
                  <li class="divide"></li>
                  <li class="Title1">* 이미지</li>
                  <li class="img_box"><img id="image1" src="data:image/jpeg;base64,${dto.pa}"></li>
                  <li class="blank"></li>
                  <li class="divide"></li>
                  <li class="Title1"></li>
                  <li class="img"><input type="file" id="image" name="image"
                     accept="image/*" onchange="setThumbnail(event);" /></li>
                  
                  <li class="font"><p>이미지 사이즈는 3 X 4로 해주세요.</p></li>
                  <li class="divide"></li>
               </ul>
            </div>
            <br>
            

            <div class="bottom_box">
               <ul>
                  <li class="divide"></li>
<!--                   <li class="Title2">* 우편번호</li> -->
<!--                   <li class="Answer4"><input type="hidden" id="confmKey" -->
<!--                      name="confmKey" value=""> <input class="text1"  -->
<!--                      type="text"  id="zipNo" name="zipNo" readonly></li> -->
                  <li class="Title2">* 주소</li>
                  <li class="Answer4"><input class="text1" type="text" value="${dto.ADDR}" 
                     id="roadAddrPart1" name="roadAddrPart1" readonly></li>
                  <input type="button" value="주소검색" class="addr_btn"
                     onclick="goPopup();">
<!--                   <li class="divide"></li> -->
                  <li class="divide"></li>
                  <li class="Title2">* 상세주소</li>
                  <li class="Answer2"><input class="text1" type="text" value="${dto.DADDR}" 
                     id="addrDetail" name="addrDetail" placeholder=" 상세주소를 입력하세요"></li>
                  <li class="divide"></li>
                  <li class="Title2">* 연락처</li>
                  <li class="Answer2"><input class="text1" type="text" value="${dto.TELNO}" 
                     id="pr_telno" name="pr_telno"
                     oninput="this.value=this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g,'$1');"
                     placeholder=" - 없이 입력하세요" maxlength="11"></li>
                  <li class="divide"></li>
                  <li class="Title2">* 이메일</li>
                  <li class="Answer2"><input class="text1" type="text"  value="${dto.EML_ADDR}" 
                     id="pr_email" name="pr_email" placeholder=" 예) hong12@gamil.com "></li>
                  <li class="divide"></li>
                  <li class="Title3">* 생년월일</li>
                  <li class="Answer3"><input class="text1" type="text" value="${dto.USER_BRDT}" 
                     id="pr_birth" name="pr_birth" placeholder=" 예) 890909식으로 입력하세요 "
                     maxlength="6" readonly
                     oninput="this.value=this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g,'$1');"></li>
                  <li class="Title3">* 성별</li>
                  <li class="Answer3"><input class="text1" type="text" value="${dto.GENDER}" 
                     id="pr_gender" name="pr_gender"
                     placeholder=" 예) 남성 또는 여성으로 입력하세요" oninput="this.value=this.value.replace(/[^ㄱ-힣]gi,'');"></li>
                  <li class="divide"></li>
               </ul>
            </div>
            <br>

            <p>* 필수로 입력해야합니다.</p>
            <div class="save">
               <button type="submit" class="save_btn" id="save_btn" onclick="check_email();">저장</button>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
   function goPopup() {
      new daum.Postcode({
         oncomplete : function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
               addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
               addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === 'R') {
               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                  extraAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if (data.buildingName !== '' && data.apartment === 'Y') {
                  extraAddr += (extraAddr !== '' ? ', '
                        + data.buildingName : data.buildingName);
               }
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            //document.getElementById('zipNo').value = data.zonecode;
            document.getElementById("roadAddrPart1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("addrDetail").focus();
         }
      }).open();
   };
   // 이미지 썸네일 
   function setThumbnail(event) {
      var reader = new FileReader();

      reader.onload = function(event) {
         var img = document.createElement("img");
         img.setAttribute("src", event.target.result);
         document.querySelector("div#image_container").appendChild(img);
      };

      reader.readAsDataURL(event.target.files[0]);
   }
   
    function check_email() {
        let input = document.getElementById("pr_email").value

        let email_format = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
        if (email_format.test(input)) alert("이메일 입력 성공!");
        else {
            alert("잘못된 이메일 형식입니다");
            document.getElementById("pr_email").value = "";
        }
    }
    
    $('.add-btn').click(function() {
        if(confirm("수정하진 내용을 저장하시겠습니까?")) {
           var KORN_FLNM = $("#name_kr").val();
          var ENG_FLNM = $("#name_en").val();
          var TELNO = $("#pr_telno").val();
          var INSTR_NO = $("#pr_no").val();
          var ADDR = $("#roadAddrPart1").val();
          var DADDR = $("#addrDetail").val();
          var EML_ADDR = $("#pr_email").val();
          var USER_BRDT = $("#pr_birth").val();
          var GENDER = $("#pr_gender").val();
          if($("#image")[0].files[0]){ var FileInput = $("#image")[0].files[0];}
          else{
          // 이미지 데이터를 가져와서 Blob 객체로 변환
          var imageSrc = $("#image1").attr("src");
          var byteCharacters = atob(imageSrc.split(',')[1]);
          var byteNumbers = new Array(byteCharacters.length);
          for (var i = 0; i < byteCharacters.length; i++) {
            byteNumbers[i] = byteCharacters.charCodeAt(i);
          }
          var byteArray = new Uint8Array(byteNumbers);
          var imageBlob = new Blob([byteArray], { type: 'image/jpeg' });
          // Blob 객체를 File 객체로 변환
          var fileName = "default.jpg";
          var FileInput = new File([imageBlob], fileName);}
          
          var formData = new FormData();
          formData.append('pr_no', INSTR_NO);
            formData.append('name_kr', KORN_FLNM);
            formData.append('name_en', ENG_FLNM);
            formData.append('pr_email', EML_ADDR);
            formData.append('roadAddrPart1', ADDR);
            formData.append('addrDetail', DADDR);
            formData.append('pr_birth', USER_BRDT);
            formData.append('pr_gender', GENDER);
            formData.append('image', FileInput);
            
            $.ajax({
                url : "/pr_self",
                type : "post",
                cache : false,
                processData: false,
                contentType: false,
                data: formData     
                success: function(data){
                  alert("저장하셨습니다.");
                  window.location.reload(); // 페이지 전체를 갱신
                },
                error: function(request, status, error){
                  alert("실패");
                }
            })
        }
    });
    
</script>