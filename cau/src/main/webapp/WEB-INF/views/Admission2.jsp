<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
<head>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
$(function(){
	
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
	if("${as.SCHDL_START}" <= today && today <= "${as.SCHDL_END_DT}"){
		$("#SAT").attr('disabled', false);
	}else{
		$("#SAT").attr('disabled', true);
	}
	if("${oc.SCHDL_START}" <= today && today <= "${oc.SCHDL_END_DT}"){
		$("#ED").attr('disabled', false);
	}else{
		$("#ED").attr('disabled', true);
	}
	
    $(".add-btn").click(function(){
        if(!$('input[name="newtranschcek"]').is(":checked")){
            alert("신편입구분을 체크를 확인해주세요");
            alert($("#image"));
        }else if(($("#depart").val()) == ""){
            alert("모집계열및 학과를 선택해주세요");
        }else if(!$('input[name="RECRT_SCHDL_CD"]').is(":checked")){
            alert("지원구분을 선택해주세요");
        }else if(($("#ed").val()) == "" && $("#ed").attr("disabled")== undefined){
            alert("학교코드를 확인해주세요");
        }else if(($("#sta").val()) == "" && $("#sta").attr("disabled")== undefined ){
            alert("수험번호를 확인해주세요");
        }else if(($("#email_1").val()) == "" || ($("#email_2").val()) == ""){
            alert("이메일을 확인해주세요");
        }else if(($("#korn_flnm").val()) == ""){
            alert("이름을 확인해주세요");
        }else if($("#image").val() == ""){
              alert("증명사진을 선택하셨는지 확인해주세요");
        }else if(($("#telno").val()) == ""){
            alert("연락처를 확인해주세요");
        }else if(($("#rel_telno").val()) == ""){
            alert("비상연락처를 확인해주세요");
        }else if(($("#rel_cd").val()) == ""){
            alert("보호자관계를 확인해주세요");
        }else if(($("#zip").val()) == ""){
            alert("우편번호를 확인해주세요");
        }else if(($("#addr").val()) == ""){
            alert("주소를 확인해주세요");
        }else if(($("#daddr").val()) == ""){
            alert("상세주소를 확인해주세요");
        }else if(($("#user_brdt").val()) == ""){
            alert("생년월일을 확인해주세요");
        }else if(($("#s_name").val()) == ""){
            alert("학교명을 확인해주세요");
        }else if(($("#s_date").val()) == ""){
            alert("졸업년월을 확인해주세요");
        }else if(!$('input[name="gender_cd"]').is(":checked")){
            alert("성별 체크를 확인해주세요");
        }else if(!$('input[name="s_check"]').is(":checked")){
            alert("학력정보 체크를 확인해주세요");
        }else if(!$('input[name="s_final"]').is(":checked")){
            alert("최종학력 체크를 확인해주세요");
        }else{
        alert("지원완료되었습니다.");
        alert("결제를 진행해주시기 바랍니다.");
        alert("메인페이지로 이동합니다.");
        $("#admission2").submit();
        }
    });



    $('input[name="RECRT_SCHDL_CD"]').change(function() {
        var value = $(this).val();
        if(value == 1){
            $("#sta").attr("disabled",false);
            $("#ed").attr("disabled",true);
         }else{
             $("#ed").attr("disabled",false);
             $("#sta").attr("disabled",true);
         }
    });
 
});

</script>
<style>
    div{font-family: 'IBM Plex Sans KR', sans-serif;}
    body{margin: 0;padding: 0}
    .main-body{
    width:1920px;
    height:2100px;
    background-color: #e6e6e6;
    }
    .container{
    margin: 0 auto;
    width:1440px;
    height:2000px;
    background-color: #e6e6e6;
    }
    .container2{
        position: relative;
        top:30px;
        width:1440px;
        height: 1900px;
        background: white;
    }
    .top-line{
        width:1340px;
    position: relative;
    top:70px;
        left:50px;
    border-top : 3px solid #8787bf;
    }
    .top-text{
        position: relative;
        top: 100px;
        left:50px;
        width:1340px;
        height:20px;
        text-align: end;
        color:red;
    }
    .table1{
        position: relative;
        top:100px;
        left:50px;
        width:1340px;
        height:500px;

    }
    .tr1>th{
        border: 1px solid #c1c1c1;
    }
      .table2{
        position: relative;
        top:100px;
        left:50px;
        width:1340px;
        height:150px;

    }
    .person{
        position: relative;
        top:132px;
        left:50px;
        width:1340px;
        height:100px;
        font-size: 40px;
    }
      .table3{
        position: relative;
        top:100px;
        left:50px;
        width:1340px;
        height:500px;

    }
    .thee{
         width:180px;
        background-color: gainsboro;
    }
     .thee1{
        text-align: left;
        background-color: darkgray;
    }
    .t1{
    text-align: left;

    }
    .add-btn{
        position: relative;
        top:200px;
        left:450px;
        border-style: none;
        border-radius: 5px;
        background-color: darkblue;
        width:500px;
        height:60px;
        font-size: 30px;
        color:aliceblue;
    }
    .add-btn:hover{
        color:darkgray;
        cursor:pointer;
    }
    .photo{
    height:200px;
    }
    .photo>th{
    border: 1px solid #c1c1c1;
    background: gainsboro;
    }
    .photo>td{
    border: 1px solid #c1c1c1;
    text-align:center;
    }
    .photo>td>img{
    width:600px;
    height:150px;
    }
    .imge_size>img{
        width:180px;
        height:215px;
    }


</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="main-body">
<form id="admission2" action="/Admission2" method="post" enctype="multipart/form-data">
    <div class="container">
        <div class="container2">
        <div class="top-line"></div>
            <div class="person">지원정보</div>
            <div class="top-text">*필수입력항목</div>

            <table class="table1">
                <tr class="tr1">
                    <th class="thee" rowspan="4" style="width:300px;">신편입구분</th>
                    <th style="width:300px;" id="ad"><input type="radio" name="newtranschcek" value="신입학">&ensp;신입학</th>
                    <th>고등학교 졸업(예정)및 검정고시 합격 이상인 자</th>
                </tr>
                <tr class="tr1">
                    <th><input type="radio" name="newtranschcek" value="2학년 편입">&ensp;2학년 편입</th>
                    <th>4년제 대학에서 1년 또는 2학기 이상 수료(35학점 이상 취득)</th>
                </tr>
                <tr class="tr1">
                    <th><input type="radio" name="newtranschcek" value="3학년 편입">&ensp;3학년편입</th>
                    <th >전문학사학위 소지자,4년제 대학에서 2년 또는 4학기 이상 수료(70학점 이상 취득)</th>
                </tr>
                <tr class="tr1">
                    <th><input type="radio" name="newtranschcek" value="시간제">&ensp;시간제</th>
                    <th>고등학교 졸업(예정) 및 검정고시 합격 이상인자</th>
                </tr>
                <tr class="tr1">
                    <th class="thee">모집계열및 학과</th>
                    <th class="t1" colspan="2">
                        &emsp;<select id="depart" name="CRCLM_CD">
                        
                            <option value="">선택하세요</option>
                            <option value=1>기계과</option>
                            <option value=2>컴퓨터공학과</option>
                            <option value=3>전기전자과</option>
                            <option value=4>화학공학과</option>
                            
                        </select>
                    </th>
                </tr>
                    <tr class="tr1">
                        <th class="thee">지원 구분</th>
                        <th class="t1" colspan="2">
                            &emsp;<input type="radio" name="RECRT_SCHDL_CD" value="2" id="ED">수시
                            &emsp;<input type="radio" name="RECRT_SCHDL_CD" value="1" id="SAT">정시
                    </th>
                </tr>
                <tr class="tr1">
                    <th class="thee">학교코드(수시지원시)</th>
                    <th class="t1" colspan="2">&emsp;<input type="text" id="ed" name="eb" disabled>
                    </th>
                </tr>
                <tr class="tr1">
                    <th class="thee">수험번호(정시지원시)</th>
                    <th class="t1" colspan="2">&emsp;<input type="text" id="sta" name="sat" disabled>
                    </th>
                </tr>
                <tr class="tr1">
                    <th class="thee">이메일</th>
                    <th class="t1" colspan="2">&emsp;<input type="text" id="email_1" name="email_1">@<input type="text" id="email_2" name="email_2"><br><br>
                        &emsp;비밀번호 찾기에 활용되니 정확하게 입력하셔야 합니다.
                     </th>
                </tr>

            </table>
            <div class="person">개인정보</div>
            <div class="top-text">*필수입력항목</div>
            <table class="table2">
                            <tr class="photo">
                                <th id="p_btn"><div class="imge_size" id="image_container" ></div></th>
                                <td><div class="file_div">사진파일크기는<br><h1>3x4</h1><br><b>사진파일은 jpg로 하시길 바랍니다</b><br></div><input type="file" id="image"name="image" accept="image/*" onchange="setThumbnail(event);"/></td>
                                <td class="t1" colspan="2">&emsp;<img src="./images/img3.png" alt="증명사진"></td>
                            </tr>
                            <tr class="tr1">
                            <th class="thee">성명</th>
                            <th class="t1" >&emsp;<input type="text" id="korn_flnm" name="korn_flnm"></th>
                            <th class="thee">연락처</th>
                            <th class="t1" colspan="3">&emsp;<input type="text" id="telno" name="telno"></th>
                            </tr>
                            <tr class="tr1">
                                 <th class="thee">보호자성함</th>
                                <th class="t1">&emsp;<input type="text" id="rel_n" name="rel_n"></th>
                                <th class="thee">비상연락처</th>
                                <th class="t1">&emsp;<input type="text" id="rel_telno" name="rel_telno"></th>
                            </tr>
                            <tr class="tr1">
                            <th class="thee">보호자관계</th>
                            <th class="t1">&emsp;<input type="text" id="rel_cd" name="rel_cd"></th>
                            <th class="thee">국적</th>
                            <th class="t1">
                                &emsp;<select id="nation" name="nation">
                                    <option>선택하세요</option>
                                    <option>대한민국</option>
                                    <option>일본</option>
                                    <option>중국</option>
                                    <option>미국</option>
                                </select>
                                </th>
                            </tr>
                            <tr class="tr1">
                                <th class="thee">우편번호</th>
                                <th class="t1" colspan="3">&emsp;<input type="text" id="zip" name="zip" readonly="readonly">&emsp;<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></th>
                            </tr>
                            <tr class="tr1">
                               <th class="thee">주소</th>
                               <th class="t1">&emsp;<input type="text"  id="addr" name="addr" readonly="readonly" style="width:auto;"></th>
                               <th class="thee">상세주소</th>
                               <th class="t1">&emsp;<input type="text" id="daddr" name="daddr" placeholder="직접입력" style="width:auto;"></th>
                            </tr>
                            <tr class="tr1">
                               <th class="thee">생년월일</th>
                               <th class="t1">&emsp;<input type="text" id="user_brdt" name="user_brdt" placeholder="ex)19901122" maxlength="8"></th>
                               <th class="thee">성별</th>
                               <th class="t1">&emsp;<input type="radio" name="gender_cd" value="남성">&emsp;남성&emsp;<input type="radio" name="gender_cd" value="여성">&emsp;여성</th>
                            </tr>

                        </table>
            <div class="person">학력정보</div>
            <div class="top-text">*필수입력항목</div>
            <table class="table3">
                <tr class="tr1">
                    <th class="thee" rowspan="2">고등학교 학력정보</th>
                    <th class="t1">&emsp;<input type="radio" name="s_check" value="졸업예정">&nbsp;졸업예정&nbsp;<input type="radio" name="s_check" value="졸업">&nbsp;졸업&nbsp;<input type="radio" name="s_check" value="검정고시">&nbsp;검정고시&nbsp;<input type="radio" name="s_check" value="학력인정">&nbsp;학력인정</th>

                </tr>
                <tr class="tr1">
                    <th class="t1">&emsp;학교명&emsp;<input type="text" id="s_name" name="s_name">&emsp;졸업년월&emsp;<input type="date" id="s_date" name="s_date"></th>
                </tr>
                <tr class="tr1">
                    <th class="thee" rowspan="8">최종학력</th>
                    <th class="t1">&emsp;<input type="radio" name="s_final" value="고등학교 졸업">&nbsp;고등학교 졸업</th>
                </tr>
                <tr class="tr1"><th class="t1">&emsp;<input type="radio" name="s_final" value="전문대학 졸업(예정)">&nbsp;전문대학 졸업(예정)</th></tr>
                <tr class="tr1"><th class="t1">&emsp;<input type="radio" name="s_final" value="4년제 대학교 수료(재학,재적)">&nbsp;4년제 대학교 수료(재학,재적)</th></tr>
                <tr class="tr1"><th class="t1">&emsp;<input type="radio" name="s_final" value="4년제 대학교 졸업(예정)">&nbsp;4년제 대학교 졸업(예정)</th></tr>
                <tr class="tr1"><th class="t1">&emsp;<input type="radio" name="s_final" value="대학원 석사졸업">&nbsp;대학원 석사 졸업</th></tr>
                <tr class="tr1"><th class="t1">&emsp;<input type="radio" name="s_final" value="대학원 박사졸업">&nbsp;대학원 박사 졸업</th></tr>
                <tr class="tr1"><th class="t1">&emsp;<input type="radio" name="s_final" value="학점은행제">&nbsp;학점은행제</th></tr>
                <tr>
                <th class="thee1">
                    <ul>
                        <li>고등학교 졸업(예정)증명서 1부</li>
                        <li>검정고시 합격자는 검정고시 합격증명서 1부</li>
                        <li>파일<input type="file" name="fileInput"></li>
                        </form>
                    </ul>
                </th>
                </tr>
            </table>
            <button type="button" id="add-btn" class="add-btn">지원완료</button>
        </div>
    </div>
    </form>
    </div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode;
                document.getElementById("addr").value = roadAddr;


                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';
                }
            }
        }).open();
    }
          function setThumbnail(event) {
            var reader = new FileReader();

            reader.onload = function(event) {
              var img = document.createElement("img");
              img.setAttribute("src", event.target.result);
              document.querySelector("div#image_container").appendChild(img);
            };

            reader.readAsDataURL(event.target.files[0]);
          }
</script>
</html>