<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원자 평가</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
</head>

<script>
$(function() {
	$('#searchStudent2').click(function() {
		  var departmentFilter = $('#filter_department').val();
		  var passedFilter = $('#passedFilter').val();


				$.ajax({
					url : '/ocs',
					type : 'GET',
					data : {
						'KORN_FLNM' : $('#name2').val(),
					    'CRCLM_CD': departmentFilter,
					    'PASSED': passedFilter

					  
					},
					dataType : "json",
					success : function(data) {
						
						  $('.table_body2').empty(); // 기존 테이블 데이터를 지웁니다.
						  $('#occno').val('');
						  $('#occname').val('');
						  $('#occdep').val('');
						  $('#occgrade').val('');	
						  $('#occpdf').val('');
						  $('#occpas').val('');						  
						  
						$.each(data, function(i, info) {
							
						    var decodedPdf = atob(info.pdf); // pdf 데이터를 디코딩합니다.
						    

						    var options = '<option value="지원자">지원자</option>' +
						      '<option value="서류합격">서류합격</option>' +
						      '<option value="불합격">불합격</option>';
						    var selected = info.passed;
						    
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
						 
						    if ((!departmentFilter || info.crclm_CD == departmentFilter) &&
						            (!passedFilter || info.passed == passedFilter)) {

						    var str = '<tr onmouseover="this.style.backgroundColor=\'#eee\';" onmouseout="this.style.backgroundColor=\'\';">'
						    	+ '<th scope="row" class="occno">' + info.appl_NO + '</th>' 
						    	+ '<td class="occname">' + info.korn_FLNM + '</td>' 
						    	+ '<td class="occdep">' + depart + '</td>'
						    	+ '<td class="occgrade">' + info.grade + '</td>'
						    	+ '<td class="occpdf"><button id="pdf-' + info.appl_NO + '" class="btn btn-sm btn-outline-primary" onclick="openPdf(\'' + decodedPdf + '\')">PDF</button></td>'
						    	+ '<td class="occpas">'+
						        '<select id="passed-' + info.appl_NO + '" name="classification" class="form-control">' +
						        options.replace('value="' + selected + '"', 'value="' + selected + '" selected') +
						      '</select>' +
						    '</td>' +
						  '</tr>';
																
									
							$('.table_body2').append(str);
						    }
													
						
						});
						
					}

				});
				
				$('#saveBtn2').unbind('click').on('click', function() {
					// 저장 버튼 비활성화
					  $(this).prop('disabled', true);
					
					  var tableRows = $('.table_body2 tr');
					  var updatedData = [];
					  
					  tableRows.each(function(index, element) {
					    var applNo = $(element).find('.occno').text();
					    var passed = $(element).find('.occpas select').val();
					    
					    if (passed) { // passed 값이 있는 경우에만 업데이트할 객체에 추가
					      updatedData.push({
					        appl_NO : applNo,
					        passed : passed
					      });
					    }
					  });

					  // 서버에 변경된 데이터를 저장하고, 페이지를 다시 로드하여 변경된 데이터를 불러옴
					  $.ajax({
					    type : 'POST',
					    url : '/saves',
					    data : JSON.stringify(updatedData),
					    contentType : 'application/json; charset=utf-8',
					    success : function(result) {
					      alert('저장되었습니다.');
					      
// 					      location.reload();
					  
// 					        document.getElementById("5-2").click();
							// 저장 버튼 활성화
    					  $('#saveBtn2').prop('disabled', false);
					      $('#saveBtn2').prop('disabled', false);

					    },
					    error : function() {
					      alert('저장 중 오류가 발생하였습니다.');
					      $('#saveBtn2').prop('disabled', false);

					    }
					  });
					
					});
				
				$('#resetBtn2').on('click', function() {

					  $('#name2').val(''); // 검색 필드 초기화	
					  $('#filter_department').val('');
				    	$('#passedFilter').val('');
						  $('.table_body2').empty(); // 검색 결과 테이블 초기화
				

					});

				
				
			});
});

function openPdf(pdfData) {
	var iframe = '<iframe src="data:application/pdf;base64,' + pdfData
			+ '" width="100%" height="100%"></iframe>';
	var x = window.open();
	x.document.open();
	x.document.write(iframe);
	x.document.close();
}


</script>
<style>
.sear {
  margin: 20px auto;
  text-align: center;
  padding: 20px;
  background-color: #AAB3C4;
  color: white;
}

.sear input,
.sear select {	
  margin: 10px;
}

.sear button {
  margin-top: 20px;
}
#resetBtn2,
#saveBtn2{
margin-left: 15px;

}
.table_body2,
.thead-dark{
text-align: center;
margin-top: 40px;
}
.top1{
border-bottom: solid 1px black;

}
</style>



<body>
<br>
	<h3 class="top1">수시 지원자 관리</h3>	
	<br>
<div class="sear">

학생 이름
	<input type="text" id="name2">
	
<select id="filter_department">
  <option value="">지원학과</option>
  <option value="1">기계과</option>
  <option value="2">컴퓨터공학과</option>
  <option value="3">전기전자과</option>
  <option value="4">화학공학과</option>
</select>

<select id="passedFilter">
  <option value="">구분</option>
  <option value="지원자">지원자</option>
  <option value="서류합격">서류합격</option>
  <option value="불합격">불합격</option>
</select>

	<button type="button" id="searchStudent2">검색</button>

</div>

		<table id="occtable" style="width: 100%" class="table table-hover">
        <thead class="thead-dark">
            <tr>
                <th scope="col">번호</th>
                <th scope="col">이름</th>  
                <th scope="col">지원학과</th>   
                <th scope="col">내신등급점수</th>        
                <th scope="col">제출서류</th>
                <th scope="col">구분</th>
                
                
               
            </tr>
        </thead>
        <tbody class="table_body2">           
        </tbody>
        
    </table>
    
<button id="saveBtn2">저장</button>	
<button id="resetBtn2">초기화</button>



<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>


<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
	

</body>
</html>