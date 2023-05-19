<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인신상조회</title>

<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(function() {
		$('#searchStudent').click(function() {		

					$.ajax({
						url : '/info',
						type : 'GET',
						data : {
							'KORN_FLNM' : $('#name').val()					
							
						},
						dataType : "json",
						success : function(data) {
							
							  $('.table_body').empty(); // 기존 테이블 데이터를 지웁니다.
							  $('#pic').empty();
							  $('#stuno').val('');
							  $('#stuname').val('');
							  $('#stubrdt').val('');
							  $('#stuage').val('');
							  $('#stucat').val('');
							  $('#studep').val('');
							  $('#stugen').val('');
							  $('#stutel').val('');
							  $('#stuemtel').val('');
							  $('#stupar').val('');
							  $('#stuemail').val('');
							  $('#stuzip').val('');
							  $('#stuadr').val('');
							  $('#studadr').val('');
							  $('#pic').val('');

							  
														  
							$.each(data, function(i, info) {
								
							 	var depart = "";
							    if(info.crclm_CD == 1){
							 		depart = "기계과";
							 	}else if(info.crclm_CD == 2){
							 		depart = "컴퓨터공학과";
							 	}else if(info.crclm_CD == 3){
							 		depart = "전기전자과";
							 	}else{
							 		depart = "화학공학과";
							 	}
							    
							    var category = "";
							    if(info.recrt_SCHDL_CD == 1){
							    	category = "정시";
							 	}else if(info.recrt_SCHDL_CD == 2){
							 		category = "수시";
							 	}
							    
							   							    

								var str = '<tr onmouseover="this.style.backgroundColor=\'#eee\';" onmouseout="this.style.backgroundColor=\'\';">'
								+ '<th scope="row" class="stuno">' + info.student_ID	+ '</th>' 
								+ '<td class="stuname">' + info.korn_FLNM + '</td>' 
								+ '<td class="stubrdt" style="display:none;">' + info.user_BRDT + '</td>'
								+ '<td class="stuage" style="display:none;">' + info.age + '</td>'
								+ '<td class="stucat" style="display:none;">' + category + '</td>'
								+ '<td class="studep">' + depart + '</td>'
								+ '<td class="stugen" style="display:none;">' + info.gender_CD + '</td>'
								+ '<td class="stutel" style="display:none;">' + info.telno + '</td>'
								+ '<td class="stuemtel" style="display:none;">' + info.rel_TELNO + '</td>'
								+ '<td class="stupar" style="display:none;">' + info.rel_CD + '</td>' 
								+ '<td class="stuemail" style="display:none;">' + info.eml_ADDR + '</td>' 
								+ '<td class="stuzip" style="display:none;">' + info.zip + '</td>' 
								+ '<td class="stuadr" style="display:none;">' + info.addr + '</td>' 
								+ '<td class="studadr" style="display:none;">' + info.daddr + '</td>' 
								+ '<td class="photofile" style="display:none;">' + info.photo_FILE + '</td>'								
								+ '</tr>';
																	
										
								$('.table_body').append(str);
							   
														
							
							});
							
						}

					});
				});
		
		$('.table_body').on('click', 'tr', function() {
			  // 클릭된 행의 각 셀 값을 가져옵니다.
			  var student_ID = $(this).find('.stuno').text();
			  var korn_FLNM = $(this).find('.stuname').text();
			  var user_BRDT = $(this).find('.stubrdt').text();
			  var age = $(this).find('.stuage').text();
			  var category = $(this).find('.stucat').text();
			  var department = $(this).find('.studep').text();
			  var gender_CD = $(this).find('.stugen').text();
			  var telno = $(this).find('.stutel').text();
			  var rel_TELNO = $(this).find('.stuemtel').text();
			  var rel_CD = $(this).find('.stupar').text();
			  var eml_ADDR = $(this).find('.stuemail').text();
			  var zip = $(this).find('.stuzip').text();
			  var addr = $(this).find('.stuadr').text();
			  var daddr = $(this).find('.studadr').text();
			  var pic = $(this).find('.photofile').text();
			  
			  var imgTag = '<img src="data:image/jpeg;base64,' + pic + '" />';
			  $('#pic').html(imgTag);	

			  // 입력란에 값을 채웁니다.
			  
			  $('#stuno').val(student_ID);
			  $('#stuname').val(korn_FLNM);
			  $('#stubrdt').val(user_BRDT);
			  $('#stuage').val(age);
			  $('#stucat').val(category);
			  $('#studep').val(department);
			  $('#stugen').val(gender_CD);
			  $('#stutel').val(telno);
			  $('#stuemtel').val(rel_TELNO);
			  $('#stupar').val(rel_CD);
			  $('#stuemail').val(eml_ADDR);
			  $('#stuzip').val(zip);
			  $('#stuadr').val(addr);
			  $('#studadr').val(daddr);

			  
		
			});
	});
</script>
</head>
 <style>
 .col-sm-2{
 width: 10%;
 }
 .pic {
 width: 200px;
 height: 200px;
 border: solid black 1px;
 }
 .pic > img{
 width: 200px;
 height: 200px;
 border: solid black 1px;
 }
 .allbox{

 width:100%;
 height: 500px;
 margin: 0 auto;
 border: solid black 1px;
 padding: 10px;
 
 
 }
 .box1{
 width:100%;
 
 height: 220px;
 }
 .pic{
 float:left;
 width:200px;
 height: 200px;
 }
 .box2{
 width:100%;
 
 height: 250px;
 }
 
.scroll{
div:100%;
height:300px;
overflow: scroll;
}
 </style>
<body>
	
	
     
   <div class="container">
<br>  
  <form>
       
     <div class="allbox">
     
     <div class="box1">
     <div id="pic" class="pic">
    
     </div>
      
       <div class="form-group row mb-3">
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">학번</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="stuno" readonly>
  </div>
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">이름</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="stuname" readonly>
  </div>
</div>

<div class="form-group row mb-3">
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">생년월일</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="stubrdt" readonly>
  </div>
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">나이</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="stuage" readonly>
  </div>
</div>

 <div class="form-group row mb-3">
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">입학전형</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="stucat" readonly>
  </div>
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">학과</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="studep" readonly>
  </div>
</div>

<div class="form-group row mb-3">
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">성별</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="stugen" readonly>
  </div>
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">전화번호</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="stutel" readonly>
  </div>
</div>
     
 
   
      
    </div>
    
    <div class="box2">
     
 <div class="form-group row mb-3">
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">비상전화번호</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="stuemtel" readonly>
  </div>
  <label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">관계</label>
  <div class="col-sm-4">
    <input type="text" class="form-control" id="stupar" readonly>
  </div>
</div>



<div class="row mb-3">
  	<label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm ">이메일</label>
  	<div class="col-sm-9">
    <input type="text" class="form-control" id="stuemail" readonly>
    </div>
    </div>
    
    <div class="row mb-3">
  	<label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">우편번호</label>
  	<div class="col-sm-9">
    <input type="text" class="form-control" id="stuzip" readonly>
    </div>
    </div>
    
    <div class="row mb-3">
  	<label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm">주소</label>
  	<div class="col-sm-9">
    <input type="text" class="form-control" id="stuadr" readonly>
    </div>
    </div>
    
    <div class="row mb-3">
  	<label for="colFormLabel" class="col-sm-2 col-form-label col-form-label-sm ">상세주소</label>
  	<div class="col-sm-9">
    <input type="text" class="form-control" id="studadr" readonly>
    </div>
    </div>
    
</div>
  
      
    
    </div>
        </form>
    
    </div>        
    
  
      
	
	
	<br>
	<br> 

	학생 이름
	<input type="text" id="name">	
	<button type="button" id="searchStudent">검색</button>
	
	
	<div class="scroll">
	
	<table class="table">
		<thead>
			<tr>
				<th scope="col">학번</th>
				<th scope="col">이름</th>
				<th scope="col" style= display:none;>생년월일</th>
				<th scope="col" style= display:none;>나이</th>
				<th scope="col" style= display:none;>입학전형</th>
				<th scope="col" >학과</th>
				<th scope="col" style= display:none;>성별</th>
				<th scope="col" style= display:none;>전화번호</th>
				<th scope="col" style= display:none;>비상전화번호</th>
				<th scope="col" style= display:none;>관계</th>
				<th scope="col" style= display:none;>이메일</th>
				<th scope="col" style= display:none;>우편번호</th>
				<th scope="col" style= display:none;>주소</th>
				<th scope="col" style= display:none;>상세주소</th>
				
			</tr>
		</thead>
		<tbody class="table_body">
		</tbody>
	</table>
	</div>




<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<!-- JavaScript Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>