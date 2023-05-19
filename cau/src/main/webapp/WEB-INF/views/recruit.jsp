<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
   crossorigin="anonymous">
   <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<title>모집인원관리</title>
<script type="text/javascript">
$(function(){
	var nowdate = new Date();
	var selectYear = nowdate.getFullYear();
	$("#recruitYear").val(selectYear).attr('selected', 'selected');
	$("#recruitCheck").click(function(){
		if($("#recruitBody").children().first().attr('class') == 'recAdd'){
			alert("추가 항목 설정을 완료해주세요.");
		}else{
		let date = new Date();
		let nowyear = date.getFullYear();
		let year = $("#recruitYear").val();
		let depart = $("#depart").val();
		var category = $("#category").val();
		$.ajax({
			url : '/check',
			type : 'GET',
			datatype : 'json',
			data : {year : year, depart : depart, category : category},
			success: function(data){
				if($("#recruitBody").children().length){
					$("#recruitBody").empty();
				}
				$.each(data,function(i, list){
					var checkNum = year < nowyear ? 'disabled' : '';
 					var num = list.APPL_NUM;
					var testnum = nowyear.toString()+num.toString()+i.toString();
 					var spare = num * 2 - num;
					var tableList = '<tr>'
									+ '<td class="recruitYear">'+list.RECRT_YEAR+'</td>'
									+ '<input class="recruitCD" type="hidden" value='+list.RECRT_SCHDL_CD + '>'
									+ '<td class="recruitName">'+list.SCHDL_NAME+'</td>'
									+ '<td class="recruitDepart">'+list.DEPARTMENT+'</td>'
									+ '<td><input class="applNum" type="Number" '+ checkNum +' value='+list.APPL_NUM+'></td>'
									+ '<td>'+list.APPL_COUNT+'</td>'
									+ '<td>'+list.STUD_COUNT+'</td>'
									+ '<td class="spare">'+spare+'</td>';
									$("#recruitBody").append(tableList);
					
				});
			}
		});
	}
});
	$(document).on("change", ".applNum", function(){
		var num = $(this).val();
		var spare = num *2;
		$(this).parent().siblings('.spare').text(spare);

	});
	$("#recruitSave").click(function(){
		if($("#recruitBody").children().first().attr('class') == 'recAdd'){
			alert("추가 항목 설정을 완료해주세요.");
		}else{
		var length = $("#recruitBody").children().length;
		var date = new Date();
		var nowyear = date.getFullYear();
		var recArray = new Array();
		var ea = 0;
		if($("#recruitBody").children().length && confirm("저장하시겠습니까?")){
			for(var i=0; i < length; i++){
			if($("#recruitBody").children().eq(i).children(".recruitYear").text() >= nowyear){
				var year = $("#recruitBody").children().eq(i).find(".recruitYear").text();
				var name = $("#recruitBody").children().eq(i).find(".recruitCD").val();
				var depart = $("#recruitBody").children().eq(i).find(".recruitDepart").text();
				var num = $("#recruitBody").children().eq(i).find(".applNum").val();
				ea = ea+1;
				recArray[i] = {"year" : year, "name" : name, "depart" : depart, "num" : num};
			}else{
				alert("수정할 데이터가 없습니다.");
				return false;
			}
		}
			$.ajax({
				url: '/recruitSave',
				type: 'POST',
				data: {recArray : recArray, ea : ea},
				success: function(){
					alert("저장이 완료되었습니다.");
				}
			});
		}else{
			return false;
		}
	}
});
	
	$("#recruitAdd").click(function(){
		if($("#recruitBody").children().first().attr('class') == 'recAdd'){
					let recYear = $(".recAdd").children(".recruitYear").find("#yearSelect").val();
					let recCate = $(".recAdd").children(".recCate").find("#recruitCategory").val();
					let recType = $(".recAdd").children(".typeCate").find("#typeCategory").val();
					let recDept = $(".recAdd").children(".typeCate").find("#typeCategory option:checked").text();
					let recNum = $(".recAdd").children(".recNum").find("#addNum").val();
					let year = $("#recruitYear").val();
					let AddDate = new Date();
					let AddYear = AddDate.getFullYear();
					if(recNum == ''){
						alert("모집 인원을 입력해주세요.");
					}else if(recYear < AddYear){
						alert("종료된 일정입니다.");
					}else{
						$.ajax({
	 							url : '/addRec',
	 							type : 'POST',
	 							data : {'year' : recYear, 'cd' : recCate, 'type' : recType, 'num' : recNum, 'depart' : recDept},
	 							success : function(result){
	 								if(result == "fail"){
	 									alert("중복입니다.");
	 								}else{
	 									$("#recruitBody").empty();
	 									$.each(result, function(i, list){
	 										var checkNum = year < AddYear ? 'disabled' : '';
	 					 					var num = list.APPL_NUM;
	 										var testnum = AddYear.toString()+num.toString()+i.toString();
	 					 					var spare = num * 2 - num;
	 										var tableList = '<tr>'
	 														+ '<td class="recruitYear">'+list.RECRT_YEAR+'</td>'
	 														+ '<input class="recruitCD" type="hidden" value='+list.RECRT_SCHDL_CD + '>'
	 														+ '<td class="recruitName">'+list.SCHDL_NAME+'</td>'
	 														+ '<td class="recruitDepart">'+list.DEPARTMENT+'</td>'
	 														+ '<td><input class="applNum" type="Number" '+ checkNum +' value='+list.APPL_NUM+'></td>'
	 														+ '<td>'+list.APPL_COUNT+'</td>'
	 														+ '<td>'+list.STUD_COUNT+'</td>'
	 														+ '<td class="spare">'+spare+'</td>';
	 														$("#recruitBody").append(tableList);
	 										
	 									});
	 									alert("저장 완료");
	 									$("#recruitAdd").text('추가');
	 									$("#recruitAdd").css('width','60');
	 								}
	 							}
	 						});
					}
		}else{
		if(confirm("항목을 추가하시겠습니까?")){
				let date = new Date();
				let year = date.getFullYear();
				var recList = '<tr class="recAdd">'
						+ '<td class="recruitYear">'
						+ '<select class="yearSelect" id="yearSelect">'
							<c:forEach items="${year }" var="ye">
						+ '<option>${ye.RECRT_YEAR}</option>'
							</c:forEach>
						+ '</select>'
						+ '</td>'
						+ '<td class="recCate">'
						+ '<select class="cateSelect" id="recruitCategory">'
						+ '<option value="1">정시</option>'
						+ '<option value="2">수시</option>'
						+ '</select></td>'
						+ '<td class="typeCate">'
						+ '<select class="typeSelect" id="typeCategory">'
						<c:set var="recode" value="1"></c:set>
						<c:forEach items="${depart }" var="dep">
						+ '<option value="${recode }">${dep.DEPARTMENT}</option>'
						<c:set var="recode" value="${recode+1}"></c:set>
						</c:forEach>
						+ '<td class="recNum"><input type="number" class="addNum" id="addNum"></td>'
						+ '<td><input type="button" class="btn" id="recDel" value="취소"></td>'
						+ '</tr>';
			$("#recruitBody").prepend(recList);
				$("#yearSelect").val(year).attr('selected', 'selected');
				$("#recruitAdd").text('추가완료');
				$("#recruitAdd").css('width','90');
				$("#recruitAdd").css('text-align','center');
		}else{
				alert("항목 추가를 취소하셨습니다.");
			}
		}
	});
	$(document).on("click","#recDel",function(){
			if(confirm("항목 추가를 취소하시겠습니까?")){
			$(this).parent().parent().remove();
			$("#recruitAdd").text('추가');
			$("#recruitAdd").css('width','60');
			}
		});
	
});
</script>
<style type="text/css">
form { display : inline; }
body{
margin: 0;
padding: 0;
}
.applNum{
text-align:center;
border: none;
width: 50px;
}
.addNum{
text-align:center;
width: 50px;
}
input[type='number']::-webkit-outer-spin-button,
input[type='number']::-webkit-inner-spin-button {
	  -webkit-appearance: none;
	  margin: 0;
}
.box{
background-color: white;
width: 100%;
height: 100vh;
}
.select_box{
width: inherit;
height: 40px;
line-height: 40px;
text-align: center;
}
.btn{
margin: 5px 10px 0 0;
float: right;
width:60px;
height:30px;
background-color:silver;
text-align: center;
line-height: 20px;
font-size: 15px;
}
.select{
float:left;
margin: 6px 0 0 5px;
}
.num{
width:100px;
}
.recruitTable{
text-align: center;
border-collapse: collapse;
width : 750px;
border: 1px solid silver;
}
.recruitTable>tbody>tr>td{
height : 25px;
font-size: 15px;
border: 1px solid silver;
text-align: center;
}
.recruitTable>thead>tr>th{
text-align: center;
width: 50px;
height: 30px;
border-right: 1px solid silver;
}

</style>

</head>
<body>
<span>모집 인원 관리</span>
<div class="box">
	<div class="select_box">
		<select class="select" id="recruitYear">
		<c:forEach items="${year }" var="y">
			<option>${y.RECRT_YEAR}</option>
		</c:forEach>
		</select>
		<select class="select" id="depart">
			<option value="all">학과 선택</option>
		<c:forEach items="${depart }" var="d">
			<option>${d.DEPARTMENT}</option>
		</c:forEach>
		</select>
		<select class="select" id="category">
			<option value="1">정시</option>
			<option value="2">수시</option>
		</select>
		<button type="button" class="btn" id="recruitAdd">추가</button>
		<button type="button" class="btn" id="recruitSave">저장</button>
		<button type="button" class="btn" id="recruitCheck">조회</button>
	</div>
	<div>
		<table class="table">
			<thead>
				<tr>
					<th>연도</th>
					<th>전형</th>
					<th>학과</th>
					<th>입학정원</th>
					<th>최초인원</th>
					<th>합격인원</th>
					<th>예비인원</th>
				</tr>
			</thead>
			
			<tbody id="recruitBody">
			</tbody>
			
		</table>
	</div>
</div>

</body>
<script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"></script>
</html>