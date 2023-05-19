







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
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

$(function(){
	$('#searchStudent_pass').click(function() {
				  $("input:checkbox[id='check_all']").prop("checked", false);
				$.ajax({
					url : '/passInfo',
					type : 'GET',
					data : {
						"KORN_FLNM" : $('#name').val(),
						"CRCLM_CD" : $('#department').val(), 
						"RECRT_SCHDL_CD":$('#category').val(),
						"RECRT_YEAR":$('#year').val()},
					dataType : "json",
					success : function(data) {
						var iii = data.list_L;
						$('.table_body_pass').empty(); // 기존 테이블 데이터를 지웁니다.
						$('#no').val('');
						  $('#name2').val('');
						  $('#age').val('');
						  $('#brdt').val('');
						  $('#gender').val('');
						  $('#email').val('');
						  $('#tel').val('');
						  $('#retel').val('');
						  $('#avg').val('');
						  $('#zipnum').val('');
						  $('#adr').val('');
						  $('#detailadr').val('');
						  $('#PDF').val('');
						  $('#PASS_INFO').val('');
						$.each(data.list, function(i, info) {
							var selectid="creditSelect"+info.appl_NO;
							if($('#category').val()=="1"){ var abc=info.avg}else{ var abc= info.total};
							var str = '<tr onmouseover="this.style.backgroundColor=\'#eee\';" onmouseout="this.style.backgroundColor=\'\';">'
							+ '<td scope="row" class="checkbox_i"> <input type="checkbox" class="checkbox_a" name="checkbox_c"></td>' 
							if(i<data.list_L){str += '<td class="passrank">' + (i+1)	+ '번</td>' ;}
							else{str += '<td class="passrank">예비' + (i-(data.list_L)+1)	+ '번</td>' ;}
						 	str += '<td class="appl_no">' + info.appl_NO	+ '</td>' 
							+ '<td class="name_m">' + info.korn_FLNM + '</td>' 
							+ '<td>' + info.age + '</td>'
							+ '<td>' + info.user_BRDT + '</td>'
							+ '<td>' + info.gender_CD + '</td>'
							+ '<td>' + info.eml_ADDR + '</td>'
							+ '<td class="telno_m">' + info.telno + '</td>'
							+ '<td>' + info.rel_TELNO + '</td>'
							+ '<td>' + abc + '</td>'
							+'<input class="CRCLMCD" type="hidden" value='+info.crclm_CD + '>'
							+'<input class="RECRTSCHDLCD" type="hidden" value='+info.recrt_SCHDL_CD + '>'
							+ '<td class="find_Select"> <select id='+selectid+' class="creditSelect"><option value=0>문자대기</option><option value=1>예치금 대기</option><option value=2>합격</option><option value=3>합격의지없음</option><option value=4>예치금반환(환불)</option></select></td>'
							$('.table_body_pass').append(str);
							$('#'+selectid).val(info.pass_INFO).attr("selected", "selected");
							if(i==((data.list_L)*2-1)){
								return false;
							}
						});
					}

				});
			});
	
		//예비번호 문자보내기버튼
	$('.permit1').click(function() {
		if(confirm("예약번호문자를 보내시겠습니까?")){
	    var checkBoxArr = new Array(); 
		var num=0;
	  $("input:checkbox[name='checkbox_c']:checked").each(function(i) {
	 	 var name_m = $(this).closest('tr').find('.name_m').text();
	 	 var telno_m = $(this).closest('tr').find('.telno_m').text();
	 	 var passrank = $(this).closest('tr').find('.passrank').text();

		num=num+1;
	  	checkBoxArr[i] = {"no" : i, "name_m" : name_m, "telno_m":telno_m,"passrank":passrank}
	});
	  $.ajax({
			url : "/permit1",
			type : "post",
			cache : false,
	      	data: { "checkBoxArr" : checkBoxArr ,"num" : num }     
	   });
	}
	});
	
	//계좌번호 문자보내기 버튼
	$('.permit2').click(function() {
		if(confirm("계좌번호문자를 보내시겠습니까?")){		
	    var checkBoxArr = new Array(); 
		var num=0;
	  $("input:checkbox[name='checkbox_c']:checked").each(function(i) {
	 	 var name_m = $(this).closest('tr').find('.name_m').text();
	 	 var telno_m = $(this).closest('tr').find('.telno_m').text();
		num=num+1;
	  	checkBoxArr[i] = {"no" : i, "name_m" : name_m, "telno_m":telno_m}
	});
	  $.ajax({
			url : "/permit1",
			type : "post",
			cache : false,
	      	data: { "checkBoxArr" : checkBoxArr ,"num" : num }     
	   });
		}
	});
	//       저장버튼
	$('.save_button1').click(function() {
		if(confirm("저장을 하시겠습니까?")){
	    var checkBoxArr = new Array(); 
		var num=0;
	  $("input:checkbox[name='checkbox_c']:checked").each(function(i) {
	 		 var  find= $(this).closest('tr').find('.find_Select').children(".creditSelect").val();
	 		 var  state= $(this).closest('tr').find('.appl_no').text();
			num=num+1;
		  	checkBoxArr[i] = {"no" : i, "appl_NO" : state,"PASS_INFO" : find}
		});
	$.ajax({
			url : "/passUpdate1",
			type : "post",
			cache : false,
      		data: { "checkBoxArr" : checkBoxArr ,"num" : num },
      		 success: function() {
      			 alert("저장을완료했습니다.");
      		 }
		});
		}
		
		
	});
	//       입학확정버튼
	$('.admission').click(function() {
		if(confirm("체크된 인원들을 입학 확정시키겠습니까?")){
	    var checkBoxArr = new Array(); 
		var num=0;
		var date = new Date();
        var nowYear = date.getFullYear();
        
        
	  $("input:checkbox[name='checkbox_c']:checked").each(function(i) {
	 		 var  state= $(this).closest('tr').find('.appl_no').text();
	 		 var  crclm= $(this).closest('tr').find('.CRCLMCD').val();
	 		 var  recrt= $(this).closest('tr').find('.RECRTSCHDLCD').val();
	 		 var  find= $(this).closest('tr').find('.find_Select').children(".creditSelect").val();
	 		 
	 		 if(find!="2"){
	 			 alert(state+"번호의 학생이 상태값이 합격이아닙니다.");
	 		 }
	 		 else{
			num=num+1;
			//학번만드는로직 요번년도+학과코드+모집전형코드+점점늘어나는숫자
			 var Student_id=nowYear+crclm+recrt+num;
		  	checkBoxArr[i] = {"no" : i, "appl_NO" : state,"Student_id" : Student_id}
	 		 }});
	$.ajax({	
			url : "/admission",
			type : "post",
			cache : false,
      		data: { "checkBoxArr" : checkBoxArr ,"num" : num },
      		success: function(){
          alert('데이터저장에  성공하였습니다.');			
      		},
        error: function() {
          // 저장 실패 시
          alert('데이터저장에 실패였습니다.');
        }
		});
		}
	});
	//체크박스 전체 체크및해제
		$(document).on('click','#check_all',function(){
			  if($('#check_all').is(':checked')){
			       $('.checkbox_a').prop('checked',true);
			    }else{
			       $('.checkbox_a').prop('checked',false);
			    }
		});
		$(document).on('click','.checkbox_a',function(){
		    if($('input[class=checkbox_a]:checked').length==$('.checkbox_a').length){
		        $('#check_all').prop('checked',true);
		    }else{
		       $('#check_all').prop('checked',false);
		    }
		});
	});
</script>
</head>
<style>
.col-sm-2 {
	width: 10%;
}
.scroll{
div:100%;
height:600px;
overflow: scroll;
}
.text_right{
text-align: right;
}
</style>
<body>
	<div class="row">
		<div class="col-sm-12 col-md-6">
			<div class="dataTables_length" id="dataTable_length">
				<label>입학년도 <select
					class="custom-select custom-select-sm form-control form-control-sm"
					id="year">
						<c:forEach items="${list_c}" var="y">
							<option>${y.RECRT_YEAR }</option>
						</c:forEach>
				</select>

				</label> <label>지원 전형<select
					class="custom-select custom-select-sm form-control form-control-sm"
					id="category">
							<option value="1">정시</option>
							<option value="2">수시</option>
				</select>

				</label> <label>지원 학과 <select
					class="custom-select custom-select-sm form-control form-control-sm"
					id="department">
						<c:forEach items="${list_d}" var="d">
							<option value="${d.CRCLM_CD}">${d.department }</option>
						</c:forEach>
				</select>
				</label>
			</div>
		</div>
		<div class="col-sm-12 col-md-6">
			<div id="dataTable_filter" class="dataTables_filter text_right">
				<label> 학생 이름: <input type="text" id="name">
					<button type="button" id="searchStudent_pass">검색</button>
				</label>
			</div>
		</div>
	</div>

	<br> 
<div class="scroll">
	<table class="table">
		<thead>
			<tr>
				<th scope="col"><input type="checkbox" id="check_all"></th>
				<th scope="col">성적순번</th>
				<th scope="col">지원서번호</th>
				<th scope="col">이름</th>
				<th scope="col">나이</th>
				<th scope="col">생년월일</th>
				<th scope="col">성별</th>
				<th scope="col">이메일</th>
				<th scope="col">전화번호</th>
				<th scope="col">비상연락처</th>
				<th scope="col">평균점수</th>
				<th scope="col">합격여부</th>
			</tr>
		</thead>
		<tbody class="table_body_pass">
		</tbody>
		<input type="button" class="permit1" value="예비번호 문자보내기">  &nbsp;
		<input type="button" class="permit2" value="계좌번호 문자보내기">  &nbsp;
		<input type="button" class="save_button1" value="저장하기">  &nbsp;
		<input type="button" class="admission" value="입학확정">  &nbsp;
	</table>
</div>





	<!-- JavaScript Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>