<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Application Payment</title>
    <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    
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
        const name = $('#name').val();
        const birthdate = $('#birthdate').val();
        const orderNum = createOrderNum();
             

        // 서버에 결제할 사용자 정보가 있는지 확인
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
                        }
                    });
                }  else if (data === "blocked") {
                    alert('이미 결제된 지원서입니다. 결제를 진행할 수 없습니다.');
                } else {
                    alert('입력하신 정보와 일치하는 사용자 정보가 없습니다. 결제를 진행할 수 없습니다.');
                }
            }
        });
    }
    </script>    

</head>
<body>
이름: <input id="name">
생년월일: <input id="birthdate">
<button onclick="requestPay()">결제하기</button> <!-- 결제하기 버튼 생성 -->

</body>
</html>
