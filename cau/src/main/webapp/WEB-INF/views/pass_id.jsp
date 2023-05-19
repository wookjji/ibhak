







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
	$('#searchStudent_id').click(function() {
				  $("input:checkbox[id='check_all']").prop("checked", false);
				$.ajax({
					url : '/passInfo_id',
					type : 'GET',
					data : {
						"KORN_FLNM" : $('#name').val(),"CRCLM_CD" : $('#department').val(), "RECRT_SCHDL_CD":$('#category').val(),"RECRT_YEAR":$('#year').val()},
					dataType : "json",
					success : function(data) {
						var iii = data.list_L;
						$('.table_body_id').empty(); // 기존 테이블 데이터를 지웁니다.
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
							var str = '<tr onmouseover="this.style.backgroundColor=\'#eee\';" onmouseout="this.style.backgroundColor=\'\';">'
							+ '<td scope="row" class="checkbox_i"> <input type="checkbox" class="checkbox_a" name="checkbox_c"></td>' 
							if(i<=data.list_L){str += '<td class="passrank">' + (i+1)	+ '번</td>' ;}
							else{str += '<td class="passrank">예비' + (i+1)-(data.list_L)	+ '번</td>' ;}
						 	str += '<td class="appl_no">' + info.appl_NO	+ '</td>' 
							+ '<td class="name_m">' + info.korn_FLNM + '</td>' 
							+ '<td>' + info.age + '</td>'
							+ '<td>' + info.user_BRDT + '</td>'
							+ '<td>' + info.gender_CD + '</td>'
							+ '<td>' + info.eml_ADDR + '</td>'
							+ '<td class="telno_m">' + info.telno + '</td>'
							+ '<td>' + info.rel_TELNO + '</td>'
							+'<td> <input class="IDCREATE" type="text" holderplace="아이디를 지정해주세요"></td>'
							+'<input class="CRCLMCD" type="hidden" value='+info.crclm_CD + '>'
							+ '<td class="find_Select"> <select id='+selectid+' class="creditSelect" ><option value=0 disabled>문자대기</option><option value=1 disabled>예치금 대기</option><option value=2 disabled>합격</option><option value=3 disabled>합격의지없음</option><option value=4 disabled>예치금반환(환불)</option></select></td>'
							$('.table_body_id').append(str);
							$('#'+selectid).val(info.pass_INFO).attr("selected", "selected");
							if(i==(data.list_L)){
								return false;
							}
						});
					}

				});
			});
	
	//       입학확정버튼
	$('.admission_id').click(function() {
		if(confirm("체크된 인원들을 입학 확정시키겠습니까?")){
	    var checkBoxArr = new Array(); 
		var num=0;
		var date = new Date();
        var nowYear = date.getFullYear();
        
        
	  $("input:checkbox[name='checkbox_c']:checked").each(function(i) {
	 		 var  state= $(this).closest('tr').find('.appl_no').text();
	 		 var  crclm= $(this).closest('tr').find('.CRCLMCD').val();
			 var Student_id=$(this).closest('tr').find('.IDCREATE').val();
			num=num+1;
		  	checkBoxArr[i] = {"no" : i, "appl_NO" : state,"Student_id" : Student_id}
		});
	$.ajax({	
			url : "/admission_id",
			type : "post",
			cache : false,
      		data: { "checkBoxArr" : checkBoxArr ,"num" : num }
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
					<button type="button" id="searchStudent_id">검색</button>
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
				<th scope="col">아이디이름</th>
				<th scope="col">합격여부</th>
			</tr>
		</thead>
		<tbody class="table_body_id">
		</tbody>
		<input type="button" class="admission_id" value="아이디생성">  &nbsp;
	</table>
</div>





	<!-- JavaScript Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>