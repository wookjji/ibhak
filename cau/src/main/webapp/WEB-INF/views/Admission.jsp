<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
<head>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
$(function(){
    $("#Admission2").click(function(){
        if($("#agree").is(":checked")){
        location.href = 'Admission2';
        }else{
        alert("정보제공에 동의하셔야 합니다.");
        }
    });
});
</script>
<style>
div{font-family: 'IBM Plex Sans KR', sans-serif;}
span{display: block}
body{
margin:0;
padding:0;
}
.main-image{
    width:1920px;
    height:1080px;
    background-color: #e6e6e6;
}
.container{
    margin: 0 auto;
    width:1440px;
    height:inherit;
    background-color: #e6e6e6;
}
    .container2{
        position: relative;
        top:100px;
        width:1440px;
        height: 700px;
        background: white;
    }
.agree-main{
    border:1px solid #e1e1e1;
    margin: 10px;
    position: relative;
    top: 30px;
    }
    .agree-in{
        margin: 20px;
    }
.page1-head{
    width:1440px;
    height:100px;
}
.page1-head>a{
    position:relative;
    top:30px;
    left:30px;
    font-size:30px;
}
.page1-title{
    width:auto;
    height:100px;

}
    .page1-title>a{
        margin-left: 25px;
        font-size:20px;
         color:darkblue;
        font-weight: 600;

    }
    .page1-bottom{
        margin: 20px;
        margin-top:20px;
        width:auto;
        height:20px;

    }
    .bottom-box{
        border:1px solid #e1e1e1;
        margin: 10px;
        border-radius: 3px;
        background-color:#e6e6e6;
        position: relative;
        top: 50px;
    }
    .page1-bottom>a{
        font-weight: 700;
    }
    .page1-bottom>b{
        float:right;
    }
    .page1-bottom>input[type=radio]{
        float:right;
    }
    .admission{
        position: relative;
        bottom: 70px;
        left:30%;
        border-style: none;
        border-radius: 5px;
        background-color: darkblue;
        width:500px;
        height:60px;
        font-size: 30px;
        color:aliceblue;
    }
    .admission:hover{
    color:darkgray;
    cursor:pointer;

    }
     .page1-bottom2{
        width:auto;
        height:100px;
        margin-top: 200px;
    }
 .v_line{
    position: relative;
    top:10px;
    border-top : 1px solid black;
    height : inherit;

    }
</style>
<body>
<div class="main-image">
<div class="container">
<div class="container2">
<div class="page1-head"><a>원서 작성 및 확인</a></div>

    <div class="page1-title"><a>개인정보 제공에 대한 안내 (필수항목)</a>
    <div class="agree-main">
        <div class="agree-in">
        <h3>[개인정보 제공]</h3>
        <a style="font-weight: 700">본교는 학생에 대하여 보다 질 높은 교육서비스 제공 및 관계법령에 따라 아래와같이 개인정보를 제공하고 있습니다.<br>
            본교는 개인정보의 이용 및 제공에 있어 관계법령을 엄수하여 부당하게 이용되지 않도록 노력하겠습니다.<br>
        </a>
        <ul>
            <li>제공기간 : 본교와 협력한 산업체 위탁기관 대학(교).학적조회 의회기관,교육부,한국장학재단,광역자치단체,서울북부보훈지정,대외 장학금지급기관,관학교류협력기관,풀잎문화사,스펙트라</li>
            <li>제공항목 : 이름,학과,주민번호,전공,주소,이메일 등</li>
            <li>제공근거 : 관계법령</li>
        </ul>
        </div>
    </div>
    <div class="bottom-box">
    <div class="page1-bottom"><a>위 사항에동의함.</a><input type="radio" name="chu2" id="disagree"><b>동의하지않음</b><input type="radio" name="chu2" id="agree"><b>동의함</b></div>
        </div>
    <div class="page1-bottom2" id="Admission2"><button type="button" class="admission">원서작성</button></div>
</div>
</div>
</div>
</div>
</body>
</html>