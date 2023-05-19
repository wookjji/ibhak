<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원자 평가</title>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
 <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script>
        var IMP = window.IMP; 
        IMP.init("imp75220550"); 
    
        function requestPay() {
        	IMP.request_pay({
        	pg: 'html5_inicis',
        	pay_method: 'card',
        	merchant_uid: "57008833-33008",
        	name: '대한항공 후쿠오카 퍼스트클래스 1인석',
        	amount: 100,
        	buyer_email: 'Iamport@chai.finance',
        	buyer_name: '포트원 기술지원팀',
        	buyer_tel: '010-1234-5678',
        	buyer_addr: '서울특별시 강남구 삼성동',
        	buyer_postcode: '123-456'
        	}, function(rsp) {
        	console.log(rsp);
        	if (rsp.success) {
        	var msg = '결제가 완료되었습니다.';
        	alert(msg);
        	location.href = "http://localhost/assessment";
        	} else {
        	var msg = '결제에 실패하였습니다.';
        	msg += '에러내용 : ' + rsp.error_msg;
        	alert(msg);
        	}
        	});
        	}
        
       
    </script>	
</head>

<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
  
<script>
$(document).ready(function () {
    var table = $('#mytable').DataTable({
        ajax: {
            url: '/asm',
            type: 'GET',
            dataSrc: ''
        },
        columns: [
      	  { data: "appl_NO" },
      	  { data: "category" },
      	  { data: "korn_FLNM" },
      	  { data: "department" },
      	  { data: "korean" },
      	  { data: "math" },
      	  { data: "english" },
      	  { data: "avg" },
      	  {
      	    data: "pdf",
      	  render: function (data, type, row) {
      		  var decodedPdf = atob(row.pdf);
              return '<button id="pdf-' + row.appl_NO + '" class="btn btn-sm btn-outline-primary" onclick="openPdf(\'' + decodedPdf + '\')">PDF</button>';
          }
      	  
      	    },      	    
      	  {
      	    data: "passed",
      	  render: function (data, type, row) {
      	      var options = '<option value="지원자">지원자</option>' +
      	                    '<option value="합격">합격</option>' +
      	                    '<option value="합격">불합격</option>' ;


      	      var selected = data || 'applicant'; // passed 값이 null 이면 'applicant'로 설정

      	      return '<select id="passed-' + row.appl_NO + '" name="classification" class="form-control">' +
      	             options.replace('value="' + selected + '"', 'value="' + selected + '" selected') +
      	             '</select>';
      	    }
      	       	 
      	  }
      	],


      	initComplete: function () {
      	    // Create two input fields and a search button
      	      var dropdowns = '<div><select id="dept_select" class="form-control">' +
	                '<option value="">지원 학과</option>' +
	                '<option value="기계공학과">기계공학과</option>' +
	                '<option value="전자공학과">전자공학과</option>' +
	                '<option value="컴퓨터공학과">컴퓨터공학과</option>' +
	                '</select></div>';
	                
      	    var inputs = '<div class="d-flex">' +
      	                 '<div class="mx-2"><input id="name_input" type="text" placeholder="이름 검색" class="form-control"></div>' +
      	                 '<button id="search_button" type="button" class="btn btn-primary">검색</button>' +
      	                 '</div>';

      	               var filterHtml = dropdowns + inputs;

      	             // Add the input fields and search button to the DataTables' search filter
      	             $('#mytable_filter').html(filterHtml);
      	    // Handle the search button's click event
      	    $('#search_button').on('click', function () {
      	        var name = $('#name_input').val();

      	        
      	        table.column(2).search(name);

      	        // Redraw the table with the new search filter
      	        table.draw();
      	    });
      	    
      	   $('#dept_select').on('change', function () {
          	
              var dept = $('#dept_select').val();
             
              table.column(3).search(dept);
              

              // Redraw the table with the new search filter
              table.draw();
          });
      	}


       });
   



    
    $('#saveBtn').click(function() {
        var tableData = $('#mytable').DataTable().data().toArray();
        var updatedData = [];
        for (var i = 0; i < tableData.length; i++) {
            var row = tableData[i];
            var passed = $('#passed-' + row.appl_NO).val(); // 각 행에 대한 id 값을 이용하여 선택자를 지정
            updatedData.push({
            	appl_NO: row.appl_NO,
                passed: passed
            });
        }
        console.log(updatedData); // 예시 출력
        
        $.ajax({
            type: 'POST',
            url: '/save',
            data: JSON.stringify(updatedData),
            contentType: 'application/json; charset=utf-8',
            success: function(result) {
                alert('저장되었습니다.');
            },
            error: function() {
                alert('저장 중 오류가 발생하였습니다.');
            }
        });
    });

    
    $('#resetBtn').click(function() {
        $('#dept_input').val('');
        $('#name_input').val('');
        table.columns().search('').draw();
    });
});
function openPdf(pdfData) {
    var iframe = '<iframe src="data:application/pdf;base64,' + pdfData + '" width="100%" height="100%"></iframe>';
    var x = window.open();
    x.document.open();
    x.document.write(iframe);
    x.document.close();
}
    
	

</script>

<body>

<table id="mytable" class="display" style="width:100%">
        <thead>
            <tr>
                <th>번호</th>
                <th>유형</th>   
                <th>이름</th>  
                <th>지원학과</th>   
                <th>언어</th>        
                <th>수학</th>
                <th>영어</th>
                <th>평균</th>
                <th>제출서류</th>
                <th>구분</th>
                
                
               
            </tr>
        </thead>
        <tbody>           
        </tbody>
        
    </table>
    
<button id="saveBtn">저장</button>	
<button id="resetBtn">초기화</button>
    <button onclick="requestPay()">결제하기</button> <!-- 결제하기 버튼 생성 -->


<!-- grid  -->
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>