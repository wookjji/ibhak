<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="js/confetti_v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  

<!-- 결제 js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<head>
<!-- 	결제 스크립트 -->

<script>
	
function createOrderNum(){
    const date = new Date();
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const day = String(date.getDate()).padStart(2, "0");
    
    let orderNum = year + month + day;
    for(let i=0;i<10;i++) {
        orderNum += Math.floor(Math.random() * 8);    
    }
    return orderNum;
}

var IMP = window.IMP; 
IMP.init("imp75220550"); 

function requestPay() {
    const name = $('#apyname').val();
    const birthdate = $('#apybirthdate').val();
    const orderNum = createOrderNum();
         

    var payment = 0; // payment 변수 선언 및 초기화

    $.ajax({
      url: "/pms",
      data: { KORN_FLNM: name, USER_BRDT: birthdate },
      success: function(data) {
        if (data === "success") { // 수정된 부분                    // 결제 진행
          IMP.request_pay({
            pg: 'html5_inicis',
            pay_method: 'card',
            merchant_uid: orderNum,
            name: 'CAU대학교 지원서',
            amount: 100,
            buyer_email: 'Iamport@chai.finance',
            buyer_name: name,
            buyer_tel: '010-1234-5678',
            buyer_addr: '서울특별시 강남구 삼성동',
            buyer_postcode: '123-456'
          }, function(rsp) {
            console.log(rsp);
            if (rsp.success) {
              var msg = '결제가 완료되었습니다.';
              alert(msg);
              location.href = "http://localhost/main";
            } else {
              var msg = '결제에 실패하였습니다.';
              msg += '에러내용 : ' + rsp.error_msg;
              alert(msg);
              
              
              $.ajax({
            	  url: "/failpay",
            	  data: { KORN_FLNM: name, USER_BRDT: birthdate },
            	  success: function(response) {
            	    if (response === "fail") {
            	      console.log("payment 값을 0으로 업데이트하였습니다.");
            	      // 추가로 필요한 처리를 진행할 수 있습니다.
            	    } else {
            	      console.error("payment 값을 업데이트하는데 실패하였습니다.");
            	    }
            	  },
            	  error: function() {
            	    console.error("서버와의 통신 중 오류가 발생하였습니다.");
            	  }
            	});

              
            }
          });
        } else if (data === "blocked") {
          alert('이미 결제된 지원서입니다. 결제를 진행할 수 없습니다.');
        } else if (data === "cancelled") {
          alert('사용자가 결제를 취소하였습니다. 결제를 진행할 수 없습니다.');
          
        } else {
          alert('입력하신 정보와 일치하는 사용자 정보가 없습니다. 결제를 진행할 수 없습니다.');
        }
        
      
        
        
      }
    });

}
</script>
<script>
//팝업 창을 닫을 때의 처리
function closePopup() {
  $('.popup_container').hide();  // 팝업 창 숨기기

  // '오늘 더이상 보지않기' 체크 여부 확인
  if ($('#no_show_today').is(':checked')) {
    var today = new Date();
    var expirationDate = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
    document.cookie = 'popupClosed=true; expires=' + expirationDate.toUTCString() + '; path=/';
  }
}

// 쿠키 확인 함수
function checkPopupCookie() {
  var cookies = document.cookie.split(';');
  for (var i = 0; i < cookies.length; i++) {
    var cookie = cookies[i].trim();
    if (cookie.indexOf('popupClosed=') === 0) {
      return true;  // 쿠키가 존재하면 true 반환
    }
  }
  return false;  // 쿠키가 존재하지 않으면 false 반환
}

// 페이지 로드 시 팝업 창 상태 확인
$(document).ready(function() {
  if (!checkPopupCookie()) {
    $('.popup_container').show();  // 팝업 창 표시
  }
  
  // 닫기 버튼 클릭 시 팝업 창 닫기
  $('#close_btn').click(function() {
    closePopup();
  });
});


$(function(){
    $("#Admission").click(function(){
    	var date = new Date();
    	var year = date.getFullYear();
    	var month = date.getMonth()+1;
    	var day = date.getDate();
    	if(month < 10){
    		month = '0'+month;
    	}
    	if(day < 10){
    		day = '0'+day;
    	}
    	var today = year+"-"+month+"-"+day;
    	if(("${list[0].SCHDL_START}" <= today || "${list[1].SCHDL_START}" <= today) && (today <= "${list[0].SCHDL_END_DT}" || today <= "${list[1].SCHDL_END_DT}")){
    		location.href = 'Admission';
    	}else{
    		alert('접수기간이 아닙니다.');
    	}     
    });
    
    $("#close_btn").click(function(){
    	$(".popup_container").fadeOut();
    });
  	//합격자 조회
  	
    $("#pass_Btn").click(function(){
    	$(".popup_wrap").css('display','flex').hide().fadeIn();
    });
    $("#close").click(function(){
    	modalClose();
    });
    function modalClose(){
    	$("#popup").fadeOut();
    }
 
    
  	//지원서결제
  	
    $("#pay_btn").click(function(){
    	$(".popup_paywrap").css('display','flex').hide().fadeIn();
    });
    $("#pay_close").click(function(){
    	modalClose1();
    });
    function modalClose1(){
    	$("#pay_popup").fadeOut();
    }
});



</script>


<meta charset="UTF-8">
<title>CAU</title>
<style>
    div{font-family: 'IBM Plex Sans KR', sans-serif;}
    span{display: block}
    body{
        margin: 0;
        padding: 0;
        height:930px;
    }
    .a{
    width:1920px;
    height:1000px;
    background-image: url('./images/main.jpg');
    }
    .container{
        margin: 0 auto;
        width:1440px;
        height:inherit;
        background-color:azure;
       z-index: 1;
    }
    .main-first{
        width:480px;
        height:inherit;
        background-color:darkblue;
        float:left;
    }
    .logo_top{
        width:480px;
        height:150px;
    }
    .logo-top-text{
        font-size: 40px;
        color:aliceblue;
        text-align: center;
        line-height: 100px;
    }
    .logo-top-text2{
        font-size: 20px;
        color:aliceblue;
        text-align: center;
        line-height: 0px;
        letter-spacing:5px;
    }

    .logo_middle{
        width:480px;
        height:300px;
    }
    .logo-middle-cong{
        position: relative;
        top:250px;
        left:300px;
        width:130px;
        height: 30px;
        font-size: 18px;
        font-weight: 900;
        color:darkblue;
        text-align: center;
        line-height: 34px;
        background-color: aliceblue;
        border-radius: 20px;
        letter-spacing:2px;

    }
    .logo_bottom{
        width:480px;
        height:428px;
    }
    .logo_bottom-text{
        text-align: center;
        font-size:25px;
        font-weight: 300;
        color:aliceblue;
    }
    .logo_bottom-text2{
        text-align: center;
        font-size:45px;
        font-style: italic;
        font-weight: 900;
        color:aliceblue;

    }
    .logo_bottom-text3{
        text-align: center;
        font-size: 20px;
        margin-top: 20px;
        font-weight: 300;
        letter-spacing:5px;
        color:cornflowerblue;
    }
        .logo_bottom-text4{
          text-align: center;
        font-size: 20px;
        margin-top: 45px;
        font-weight: 200;
        letter-spacing:5px;
        color:aliceblue;
    }
    .Admission_btn{
        position: relative;
        left: 85px;
        top:20px;
        width:300px;
        height:50px;
        font-size: 20px;
        font-weight: 900;
        color:darkblue;
        letter-spacing:10px;
        background-color: #FFC314;
        border-style: none;
        border-radius: 50px;
    }
    .Admission_btn:hover{
    color:white;
    cursor : pointer;
    }
    .login{
        text-align:center;
        margin: 0 auto;
        margin-top:60px;
        width:400px;
        height:100px;
        font-weight:600;
        color:darkblue;
        background-color:#e3c102;
    }
    .modalbox{
            color:darkblue;
            width:400px;
            height:30px;
            margin: 0 auto;
     		text-align:center;
            background-color:#e3c102;
    		
    }
    .modalbox a{
            color:darkblue;
    }
    .modalbox a:hover {
cursor: pointer;
}

.mymodal{
	display:none; 
	position:fixed; 
	z-index:1;
	padding-top:100px;
	left:0; 
	top:0; 
	width:100%;
	height:100%; 
	overflow:auto;
	background-color:rgba(0,0,0,0.4);
}

    input[type=text]{
    border-style:none;
    border-radius:3px;
    width:200px;
    height:20px;
    text-align:center;
    }
    input[type=password]{
    border-style:none;
    border-radius:3px;
    width:200px;
    height:20px;
    text-align:center;
    }
    .login-btn{
    color:white;
    font-size:15px;
    border-style:none;
    border-radius:2px;
    width:100px;
    height:50px;
    background-color:darkblue;
    }
    .login-btn:hover{
    color:#e3c102;
    cursor : pointer
    }
    .main-second{
        width:480px;
        height:inherit;
        float:left;
        background-color:#edf4ff;
    }
    .service-top{
        width:480px;
        height:340px;
    }
    .head-text{
        position: relative;
        top:30px;
        left: 25px;
        width:300px;
        height:50px;
        font-size:35px;
        font-weight: 500;
        color:black;
        text-decoration: underline;
    }
    .notice_text{
        position:relative;
        left:100px;
        top:50px;
    }
    .service-top-table{
        position: relative;
        top:40px;
        width:480px;
        height:250px;
        text-align: center;
        border-spacing: 20px;
        border-collapse: separate;
    }
    .tr1>td{
        border: 1px solid #E0EBFF;
        border-radius: 20px;
        cursor: pointer;
    }

    .service-middle{
        width:480px;
        height:340px;

    }
    .middle-table{
        position: relative;
        top:40px;
        width:480px;
        height:250px;
        text-align: center;
        border-spacing: 20px;
        border-collapse: separate;
    }
    .service-bottom{
        width:480px;
        height:300px;

    }
    .service-bottom-text{
        position: relative;
        top:160px;
        left: 40px;
    }
    .main-third{
        width:480px;
        height:inherit;
        float:left;
        background-color:#edf4ff;
    }
    .v_line{
    position: absolute;
    border-left : 1px solid #BECDFF;
    height : inherit;

    }
      .service2-top{
        width:480px;
        height:340px;

    }
    .service2-middle{
        width:480px;
        height:340px;

    }
    .service2-bottom{
        width:480px;
        height:300px;
    }
    .service2-bottom-text{
        position: relative;
        top:160px;
        left: 140px;
    }
    .material-symbols-outlined {
    font-size:50px;
    color:darkblue;
    cursor:pointer;
      font-variation-settings:
      'FILL' 0,
      'wght' 200,
      'GRAD' 200,
      'opsz' 48
    }
    .logout-btn{
   	 	width:200px;
    	height:30px;
        font-size: 20px;
        font-weight: 900;
        color:#FFC314;
        letter-spacing:10px;
        background-color: darkblue;
        border-style: none;
        border-radius: 10px;
    }
    .logout-btn:hover{
    	color:white;
    	cursor: pointer;
    }
    .goManagement{
    	margin:0 auto;
    	margin-top:20px;
    	width:200px;
    	height:30px;
        font-size: 20px;
        font-weight: 900;
        color:darkblue;
        letter-spacing:5px;
    }
    .goManagement:hover{
    	color:white;
    	cursor : pointer;
    }
    .clsbt:hover{
    color:gray;
    	cursor : pointer;
    }
/*     입시기간 팝업 */
    .popup_container{
    position: absolute;
    top:50px;
    left:50px;
    width:500px;
    height: 500px;
    background-color:white;
    border-radius:2px;
    border:solid 5px black;
    z-index: 10;
    display:block;
    background-color: darkblue;
    }
    
    .popup_container>button{
    position: absolute;
    top:10px;
    left:455px;
    width:30px;
    height:30px;
    border-style:none;
    border-radius:5px;
    font-size:20px;
    font-weight:5px;
    line-height:10px;
    z-index: 11;
    }
    .popup_container>button:hover{
    background-color: darkblue;
    color:white;
    cursor: pointer;
    }
    .popup_whitebox{
    position: absolute;
 	top:60px;
    left:15px;
    width:470px;
    height: 400px;
    background-color:#EDF4FF;
    border-radius:10px;
    }
    .popup_gigan{
    width:470px;
    height:70px;
    font-size:45px;
    font-weight:600;
    line-height:70px;
    text-align:center;
    border-bottom: 2px solid black;
    border-radius: 10px 10px 0 0;
    background-color: #690010;
    }
    .schName{
    width:470px;
    height:70px;
    font-size:30px;
    font-weight:500;
    line-height:70px;
    text-align:center;
    border-bottom : 2px solid black;
    background-color: #E3C102;
    }
    .popup_start{
    width:220px;
    height:70px;
    font-size:30px;
    line-height:70px;
    text-align:center;
    float: left;
    }
    .popup_end{
    width:220px;
    height:70px;
    font-size:30px;
    line-height:70px;
    text-align:center;
    float: left;
    }
    .datebox{
    width:470px;
    height:70px;
    font-size:30px;
    line-height:70px;
    text-align:center;
    border-bottom : 2px solid black;
    padding: 10px 0 10px 0;
    }
    .datebox:nth-child(2){
    border-radius:0 0 10px 10px; 
    }
    .popupmi{
    width:30px;
    height:70px;
    font-size: 30px;
    line-height: 70px;
    text-align: center;
    float: left;
    }
/*    	합격자조회 */

    .popup_wrap{
     background-color: rgba(0,0,0,0.3);
     justify-content: center;
     align-items: center;
     position:fixed;
     top:0;
     left:0;
     right:0;
     bottom:0;
     display:none;
     paddig:15px;
     z-index: 15;
     }
     
    .popup_pass{
     width:100%;
     max-width:800px;
     border-radius: 10px;
     overflow:hidden;
     background-color: white;
     box-shadow: 5px 10px 10px 1px rgba(0,0,0,3);
     }
    .popup_head{
     width:100%;
     height:50px;
     display:flex;
     background-color:darkblue;
     font-weight:800;
     font-size:30px;
     color:white;
     align-items: center;
     justify-content: center;
     }
    .popup_body{
     width:100%;
     }
 	.body-content{  
  	 width:100%;
  	 padding:30px;           
	 }
	.body_titleBox{            
  	 text-align:center;        
  	 width:100%;
  	 height:40px;
 	 margin-top:10px;
 	 font-size:15px;
 	        
	 }
	.body_contentbox{           
 	 word-break:break-word;  
 	 width:100%; 
 	 text-align:center; 
 	 overflow-y:auto;          
 	 min-height:100px;         
  	 max-height:200px; 
  	 float:left;    
	}
	.body_contentbox>span{
	margin-top:10px;
	}
	.contenText{
	background-color: #cecee0;
	margin-top: 5px;
	}
	.popup-foot{                      
 	 width:100%;
 	 height:50px;
	}
	.pop-btn{ 
  	 display:inline-flex;           
 	 width:49.8%;                      
 	 height:100%;                 
 	 justify-content:center;         
 	 align-items:center;            
  	 float:left;   
  	 font-weight:800;
  	 font-size:20px;                  
  	 color:darkblue;                  
 	 cursor:pointer;  
 	 background-color: #FFC314;               
	}
	.pop-btn.confirm{  
	 float:left;              
 	 border-right:3px solid darkblue; 
 	 background-color: #FFC314;
	}
	.pop-btn:hover{
	color:white;
	}
	
/* 	지원서결제  */

	.popup_paywrap{
     background-color: rgba(0,0,0,0.3);
     justify-content: center;
     align-items: center;
     position:fixed;
     top:0;
     left:0;
     right:0;
     bottom:0;
     display:none;
     paddig:15px;
     z-index: 15;
     }
     
/*  	폭죽 */
	.canvas{
	z-index:20;
	pointer-events: none;
	position: fixed;
	top: 0;
	transform: scale(1.1);
	}

</style>
</head>
<body>
<div class="a">
<canvas id="canvas" class="canvas"></canvas>
<div class="container">
    <div class="main-first">
    <div class="logo_top">
    
<!--     기간알림팝업창 -->
    <div class="popup_container">
    <button type="button" id="close_btn">x</button>
    <div class="popup_whitebox">
    <div class="popup_gigan">
   입학기간
   </div>
   <c:forEach items="${list }" var="l">
   	<div class="schName">
   	${l.SCHDL_NAME }
   	</div>
   	<div class="datebox">
   	<div class="popup_start">${l.SCHDL_START }</div>
   	<div class="popupmi">~</div>
   	<div class="popup_end">${l.SCHDL_END_DT }</div>
   	</div>
   </c:forEach>
    </div>
    <p style="color: white; margin-top: 95%;">오늘 더이상 보지않기<input type="checkbox" name="no_show_today" id="no_show_today"></p>
    </div>
<!--   	합격자조회 팝업 -->
	
	<div class="popup_passcon"><!-- 합격조회 컨테이너 -->
		<div class="popup_wrap" id="popup"><!-- 팝업창 외부박스 -->
		 	<div class="popup_pass"><!-- 실질적 팝업창 -->
		 		<div class="popup_head"><!-- 헤드부분 -->
		 			<span class="popup_title">합격자조회</span>
		 		</div>
		 		<div class="popup_body">
		 		<div class="body_content">
		 			<div class="body_titleBox">
		 				지원자의 성함과 생년월일을 적어주세요
		 			</div>
		 			<div class="body_contentbox"><!-- 팝업내용 -->
		 				<span>
		 					
		 					성함&emsp;&emsp;<input type="text" name="search_name" class="contenText" id="passName"><br>
		 					생년월일 <input type="text" name="search_brd" class="contenText" id="passBrd" placeholder="ex)19981102">
		 					
		 					
		 				</span>
		 			</div>
		 		</div>
		 		</div>
		 		<div class="popup-foot"><!--하단 버튼 -->
		 			<span class="pop-btn confirm" id="confirm">확인</span>
        			<span class="pop-btn close" id="close">창 닫기</span>
		 		</div>
		 	</div>
		</div>
	</div><!-- 끝 -->
    
    
    <!--   	지원서결제 팝업 -->
	
	<div class="popup_paycon"><!-- 합격조회 컨테이너 -->
		<div class="popup_paywrap" id="pay_popup"><!-- 팝업창 외부박스 -->
		 	<div class="popup_pass"><!-- 실질적 팝업창 -->
		 		<div class="popup_head"><!-- 헤드부분 -->
		 			<span class="popup_title">지원서결제조회</span>
		 		</div>
		 		<div class="popup_body">
		 		<div class="body_content">
		 			<div class="body_titleBox">
		 				지원자의 이름과 생년월일을 적어주세요
		 			</div>
		 			<div class="body_contentbox"><!-- 팝업내용 -->
		 				<span>
		 					
		 					이름&emsp;<input type="text" name="apyname" class="contenText" id="apyname"><br>
		 					생년월일 <input type="text" name="apybirthdate" class="contenText" id="apybirthdate" placeholder="ex)19981102">
		 					
		 					
		 				</span>
		 			</div>
		 		</div>
		 		</div>
		 		<div class="popup-foot"><!--하단 버튼 -->
		 			<span class="pop-btn confirm" id="pay_confirm" onclick="requestPay()">결제하기</span>
        			<span class="pop-btn close" id="pay_close">창 닫기</span>
		 		</div>
		 	</div>
		</div>
	</div> <!--끝 -->
    
        <span class="logo-top-text">중앙입학서비스</span>
        <span class="logo-top-text2">Choogang Service</span>
    </div>
    <div class="logo_middle">
        <span class="logo-middle-cong">환영합니다!</span>
    </div>
        <div class="logo_bottom">
            <span class="logo_bottom-text">정보와 지식을 끊임없이 탐구하는 중앙</span>
            <span class="logo_bottom-text2">Choogang University</span>
            <span class="logo_bottom-text3">Choogang Login</span>
            <% if (request.getUserPrincipal() == null) { %>
            <button type="button" class="Admission_btn" id="Admission">입학지원</button>
            <table class="login">
            <tr>
<!--             <td>학생<input type="radio" name="chu">교수<input type="radio" name="chu"></td> -->
            </tr>
            <tr>
            <form action="/auth" method="post">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <td><input type="text" name="USER_ID" placeholder="아이디"></td>
            <td rowspan="2"><button type="submit" class="login-btn">로그인</button></td>
            </tr>
            <tr>
            <td><input type="password"  name="PSWD" placeholder="비밀번호"></td>
            </tr>
         <c:if test="${param.error != null}">
  <script>alert("아이디 혹은 비밀번호가 틀렸습니다.");</script>
</c:if>
            </form>
            </table>

<div class="modalbox"><a onclick="openModal()">아이디찾기 / 비밀번호찾기</a></div>

<div id="myModal" class="mymodal">
  <div style="background-color:#fefefe; margin:auto;  border:1px solid #888; width:40%; ">
    <span onclick="closeModal()" class="clsbt" style="float:right; font-size:28px; font-weight:bold; margin-right: 20px;
    clear:both; z-index: 99999;">&times;</span>
    <div>
      <%@ include file="/WEB-INF/views/Login/findid.jsp" %>
    </div>
  </div>
</div>

<div id="findPassModal" class="mymodal">
  <div style="background-color:#fefefe; margin:auto;  border:1px solid #888; width:40%;">
    <span onclick="closepassModal()" class="clsbt" style="float:right; font-size:28px; font-weight:bold; margin-right: 20px;
    clear:both; z-index: 99999; ">&times;</span>
     <div>
      <%@ include file="/WEB-INF/views/Login/findpass.jsp" %>
    </div>
  </div>
</div>


<div id="myFindResultModal" class="mymodal">
  <div style="background-color:#fefefe; margin:auto;  border:1px solid #888; width:40%;">
    <span onclick="closeresultModal()" class="clsbt" style="float:right; font-size:28px; font-weight:bold; margin-right: 20px;
    clear:both; z-index: 99999; ">&times;</span>
    <div class="modal-body">
      <%@ include file="/WEB-INF/views/Login/resultid.jsp" %>
    </div>
  </div>
</div>


<div id="myFindResultPassModal" class="mymodal">
  <div style="background-color:#fefefe; margin:auto;  border:1px solid #888; width:40%;">
    <span onclick="closeresultPassModal()" class="clsbt" style="float:right; font-size:28px; font-weight:bold; margin-right: 20px;
    clear:both; z-index: 99999; ">&times;</span>
    <div class="modal-body2">
      <%@ include file="/WEB-INF/views/Login/resultpass.jsp" %>
    </div>
  </div>
</div>
<script>
function openModal() {
	  var findIdModal = document.getElementById("myModal");
	  var findPassModal = document.getElementById("findPassModal");

	  if (findPassModal) {
	    findPassModal.style.display = 'none';
	  }
	  if (findIdModal) {
	    findIdModal.style.display = "block";
	  }
	
	}


function closeModal() {
  var modal = document.getElementById("myModal");
  var findPassModal = document.getElementById("findPassModal");

  modal.style.display = 'none';
  document.getElementById('KORN_FLNM_ID').value = '';
  document.getElementById('TELNO_ID').value = '';
  var warningMsg = modal.querySelector(".warning");
  if (warningMsg) {
    warningMsg.remove();
  }
  
}

function openFindPassModal() {
	  var findIdModal = document.getElementById("myModal");
	  var findPassModal = document.getElementById("findPassModal");

	  if (findIdModal) {
	    findIdModal.style.display = 'none';
	  }
	  if (findPassModal) {
	    findPassModal.style.display = "block";
	  }
	  closeModal(); // findId 모달을 닫는 함수 호출

	}


function closepassModal() {
	 var modal = document.getElementById("myModal");
	 var findPassModal = document.getElementById("findPassModal");
  
	findPassModal.style.display = 'none';
  document.getElementById('USER_ID_ps').value = '';
  document.getElementById('KORN_FLNM_ps').value = '';
  document.getElementById('TELNO_ps').value = '';
  var warningMsg = modal.querySelector(".warning");
  if (warningMsg) {
    warningMsg.remove();
  }
  
}



function openFindResultModal(result) {
	
	
	  var findIdModal = document.getElementById("myModal");
	  var findResultModal = document.getElementById("myFindResultModal");

	  if (findIdModal) {
	    findIdModal.style.display = 'none';
	  }
	  if (findResultModal) {
	    findResultModal.style.display = "block";
	  }
	  
	}
	
function closeresultModal() {
	  var modal = document.getElementById("myFindResultModal");

	  modal.style.display = 'none';
	  document.getElementById('KORN_FLNM_ID').value = '';
	  document.getElementById('TELNO_ID').value = '';
	  var warningMsg = modal.querySelector(".warning");
	  if (warningMsg) {
	    warningMsg.remove();
	  }
	}
	

function openFindResultPassModal(result) {
	  var findPassModal = document.getElementById("findPassModal");
	  var findResultPassModal = document.getElementById("myFindResultPassModal");
	 
	  if (findPassModal) {
		  findPassModal.style.display = 'none';
	  }
	  if (findResultPassModal) {
		  findResultPassModal.style.display = "block";
	  }
	
	}
	
function closeresultPassModal() {
	  var modalpass = document.getElementById("myFindResultPassModal");

	  modalpass.style.display = 'none';
	  document.getElementById('USER_ID_ps').value = '';
	  document.getElementById('KORN_FLNM_ps').value = '';
	  document.getElementById('TELNO_ps').value = '';
	
	}
	
//모달 바깥쪽을 클릭하면 모달이 닫히도록 이벤트를 추가합니다.
window.onclick = function(event) {
  var modal = document.getElementById("myModal");
  var findPassModal = document.getElementById("findPassModal");
  var findResultModal = document.getElementById("myFindResultModal");
  var findResultPassModal = document.getElementById("myFindResultPassModal");
  if (event.target == modal) {
    closeModal();
  }
  if (event.target == findPassModal) {
    closepassModal();
  }
  if (event.target == findResultModal) {
    closeresultModal();
  }
  if (event.target == findResultPassModal) {
	    closeresultModal();
	  }
}

</script>
            <% } else { %>
            	<table class="login">
            <tr>
            <td><form action="/logout" method="post">
            <div class="goManagement"><a href="/index" onclick="location.href='index.jsp'"> 학사관리로 이동 </a></div><br>
        	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       		 <button type="submit" class="logout-btn">로그아웃</button>
   			 </form>
   			 
   			</td>
            </tr>
            
            
            </table>
            <% } %>
            <span class="logo_bottom-text4">개인정보처리방침</span>
        </div>
    </div>
    <div class="main-second">
        <div class="service-top">
            <div class="head-text">Choogang Service</div>
            <table class="service-top-table">
            <tr class="tr1">
                <td><span class="material-symbols-outlined" id="startButton">
                    browse_activity
                    </span><br>학사정보</td>
                <td><span class="material-symbols-outlined" id="stopButton">
                    view_compact_alt
                    </span><br>과목정보</td>
                <td><span class="material-symbols-outlined">
                    quick_reference_all
                    </span><br>접수확인</td>
            </tr>
            <tr class="tr1">
                <td><span class="material-symbols-outlined" id="pay_btn">
                    manage_search
                    </span><br>지원서결제</td>
                <td><span class="material-symbols-outlined" id="pass_Btn">
                    zoom_in
                    </span><br>합격자조회</td>
                <td><span class="material-symbols-outlined" id="ee" >
                    transcribe
                    </span><br>온라인강의</td>
            </tr>
            </table>
        </div>
        <div class="service-middle">
            <div class="head-text">학사 LINK</div>
            <table class="middle-table">
                <tr>
                    <td>전자출결</td>
                    <td>온라인강의</td>
                </tr>
                <tr>
                    <td>학부모서비스</td>
                    <td>대학원입학지원</td>
                </tr>
                <tr>
                    <td>Inbiund 교환학생 신청</td>
                    <td>학생증발급</td>
                </tr>
            </table>
        </div>
        <div class="service-bottom">
            <div class="head-text">Choogang Notice</div>
            <div class="notice_text">학사 &emsp;| &emsp;입학지원 필독공지&emsp; | &emsp;2023.4.23 </div>

            <small class="service-bottom-text">COPYRIGHT(C)2023 CHOGANG UNUVERSUTY.ALL RIGHTS RESERVED</small>
        </div>
        </div>
    <div class="main-third">
        <div class="v_line"></div>
        <div class="service2-top">
        <div class="head-text">IT Service</div>
            <table class="service-top-table">
            <tr class="tr1">
                <td><span class="material-symbols-outlined">
                    transcribe
                    </span><br>인터넷 증명서</td>
                <td><span class="material-symbols-outlined">
                    mark_as_unread
                    </span><br>웹메일</td>
                <td><span class="material-symbols-outlined">
                    google_wifi
                    </span><br>신촌 IT서비스</td>
            </tr>
            <tr class="tr1">
                <td><span class="material-symbols-outlined">
                    mindfulness
                    </span><br>미래 IT서비스</td>
                <td><span class="material-symbols-outlined">
                    directions_bus
                    </span><br>셔틀버스</td>
                <td><span class="material-symbols-outlined">
                    conversion_path
                    </span><br>미래통학버스</td>
            </tr>
            </table>
        </div>
        <div class="service2-middle">
            <div class="head-text">행정 LINK</div>
            <table class="middle-table">
                <tr>
                    <td>ERP 행정정보시스템</td>
                    <td>연구관리 | YRI(통합연구업적)</td>
                </tr>
                <tr>
                    <td>공간대관시스템</td>
                    <td>협업시스템(그룹웨어)</td>
                </tr>
                <tr>
                    <td>신분증 발급</td>
                    <td>연말정산 시스템</td>
                </tr>
            </table>
        </div>
        <div class="service2-bottom">
            <div class="head-text">QnA</div>
            <div class="notice_text"> Cau대학교&emsp;| &emsp;입학지원&emsp; | &emsp;2023.4.23 </div>
            <small class="service2-bottom-text">06134 서울특별시 강남구 테헤란로7길7</small>
        </div>
        </div>
    </div>
</div>



</body>
<script type="text/javascript">

$(function(){
	 function reAction(){
		  	$("#startButton").trigger("click");
		  	setTimeout(function(){
		  		$("#stopButton").trigger("click");
		  	}, 6000);
		  }
		  
		  $(".uoc-icon").on('click', function(){
		      reAction();
		  }); 
	
	$("#confirm").click(function(){
		var passName = $("#passName").val();
		var passBrd = $("#passBrd").val();
				$.post( //post방식으로 
							{
							url:"/passinfo", //url
							dataType : "json", //받아올 데이터타입 
							data : {
								"passName" : passName, // 보낼 데이터 == httparameter 과 같음
								"passBrd"  : passBrd
							}
					}).done(function(data){//성공 data라는곳에 정보가있음
						
						if(data == 0){
							alert("정보를 잘못 입력하셨습니다.");
							alert("올바르게 다시 입력해주세요.");
						}
						else if(data == 1){
							reAction();
							alert("합격입니다.");
							
						}else{
							alert("불합격입니다.");
						}


					}).fail(function(xhr){ //실패 xhr 에 정보가 있음
						alert("fail");
					})
				});
		});


		
	
</script>
</html>