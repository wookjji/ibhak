<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
   crossorigin="anonymous">   
  

    <title>중앙대학교 - 학사관리페이지</title>
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
   
    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    
    
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"></script>
      <!-- jquery CDN -->

<!-- grid  -->

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>

       

    
    
<style type="text/css">

span{
display: block;
}
.box{
width: calc(100% - 225px;);
height: auto;
}
.menubar{
width: auto;
height: 30px;
padding-left:20px;
text-align:center;
line-height: 30px;
background-color: #4D72DF;
font-size: 12px;
}
.barmenu {
	display: block;
   float: left;
   color: white;
   
}
.closebtn {
   float: left;
   background-color: #4D72DF;
   border: none;
   color: white;
   height: 30px;
   text-align: center;
   line-height: 30px;
   margin-right: 5px;
   border-top-right-radius: 5px;
}

.contentbox{
padding-top: 20px;
width: 100%;
height:90vh;
position: relative;
background-color: white;
}
.testcontent{
width: inherit;
height: 90vh;
position: absolute;
background-color: white;
overflow: scroll;
}
.on1{
border-top-left-radius: 5px;
background-color: white;
color: black;
}
.on2{
background-color: white;
color: black;
}

#close{
float: right;
}

</style>    
<script type="text/javascript">
$(function() {
	
	
    if($("#menubar").children().length < 11){
    $(".collapse-item").click(function() {
                   var divid = $(this).attr('id');	
                   var btnid = "btn" + divid;
                   var menuid = "menu" + divid;
                   var contentid = "content" + divid;
                   var btn = "<div class='tap'><span class='barmenu'"+"id="+menuid+"></span><input class='closebtn' type='button' value='x'"+"id="+btnid+"></div>";
                   var content = "<div class='testcontent'"+"id="+contentid+"></div>";
                   var close = '<input type="button" value="x" id="close">';
                   $(".collapse").css("z-index", "200");
                   if($("#"+contentid).length){
    					$("#"+contentid).css("z-index", "100");
          			  $("#"+contentid).siblings().css("z-index", "10");
    				}else{
                      $.ajax({
                            url : "/tester",
                            type : "post",
                            cache : false,
                            dataType : "html",
                            data : {id : divid},
                            success : function(good) {
                            	$(document).ready(function(){
                                    $("#" + contentid).load(good);
                                    $("#"+contentid).css("z-index", "100");
                                    $("#"+contentid).prevAll().css("z-index", "10");
                                                                     	
                            	});
                            }
                         });
                   
                   $("#contentbox").append(content);
    }


                   if ($("#close").length) {
                   } else {
                     $("#menubar").append(close);
                   }
                   
                   $(document).on('click', '#close',function(){
                	   $("#menubar").empty();
                	   $("#contentbox").empty();
                   });
                                     
                      if ($("#" + menuid).length) {
                    	  $("#"+menuid).attr('class','barmenu on1');
                          $("#"+menuid).next().attr('class','closebtn on2');
                          $("#"+menuid).parent().prevAll().children('span').attr('class','barmenu');
                          $("#"+menuid).parent().prevAll().children('input').attr('class','closebtn');
                          $("#"+menuid).parent().nextAll().children('span').attr('class','barmenu');
                          $("#"+menuid).parent().nextAll().children('input').attr('class','closebtn');
                      } else {
                         $("#menubar").append(btn);
                         $("#" + menuid).text($(this).text());
                        	 $("#"+menuid).attr('class','barmenu on1');
                             $("#"+menuid).next().attr('class','closebtn on2');
                             $("#"+menuid).parent().prevAll().children('span').attr('class','barmenu');
                             $("#"+menuid).parent().prevAll().children('input').attr('class','closebtn');
                     }
                      $("#"+menuid).click(function() {
                    	  $("#"+menuid).attr('class','barmenu on1');
                          $("#"+menuid).next().attr('class','closebtn on2');
                          $(this).parent().prevAll().children('span').attr('class','barmenu');
                          $(this).parent().prevAll().children('input').attr('class','closebtn');
                          $(this).parent().nextAll().children('span').attr('class','barmenu');
                          $(this).parent().nextAll().children('input').attr('class','closebtn');
                          $("#"+contentid).css("z-index", "100");
                          $("#"+contentid).siblings().css("z-index", "10");
                                       
                         
                      });
                      $(document).on("click", "#"+btnid, function() {
                               $(this).parent().remove();
                                $("#" + contentid).remove();
                               
                               if($("#menubar").children().length <= 1){
                            	   $("#menubar").empty();
                               }
                            });
                      
                });
    $(document).on("click", ".on2", function(){
  	  if($(this).parent().prev().val() == "x"){
  			$(this).parent().next().children('span').trigger('click');
  		}else if($(this).parent().prev().val() == ""){
  			$(this).parent().prev().children('span').trigger('click');
  		}else{
  			
  		} 
    });
    
    }else{
    	alert("메뉴를 더 이상 추가할 수 없습니다.");
    }
    
    
 });
</script>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index">
              <img src="img/WW.png" width="50px" height="50px">
                <div class="sidebar-brand-icon rotate-n-15">
                </div>
                <div class="sidebar-brand-text mx-3" style="margin-left:40px; margin-top: 10px; ">CAU</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
<!--             <li class="nav-item active"> -->
<!--                 <a class="nav-link" href="index"> -->
<!--                     <i class="fas fa-fw fa-tachometer-alt"></i> -->
<!--                     <span>목록</span></a> -->
<!--             </li> -->

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Interface
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
                                       <c:if test="${not empty userRole and userRole == 'ADMIN'}">
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>관리자관리</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded" >
                        <h6 class="collapse-header">관리자관리</h6>
                        <a class="collapse-item"  id="1-1">코드관리</a>
                        <a class="collapse-item" href="cards" id="1-2">사용자정보 관리</a>
                    </div>
                </div>
            </li>
                        </c:if>
            <!-- Nav Item - Utilities Collapse Menu -->
                           <c:if test="${not empty userRole and userRole == 'ADMIN'}">
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fas fa-fw fa-users"></i>
                    <span id="plz">학생관리</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">학생관리</h6>
                        <span class="collapse-item" id="2-1">합격자 조회</span>
                        <span class="collapse-item" id="2-2">학적부여관리</span>
                        <span class="collapse-item" id="2-3">입학정원관리</span>
                        <span class="collapse-item" id="2-4">개인신상조회</span>
                        <span class="collapse-item" id="2-5">학생아이디추가생성</span>
                    </div>
                </div>
            </li>
                        </c:if>
               
              <!-- Nav Item - Utilities Collapse Menu -->
<c:if test="${not empty userRole and userRole == 'STUDENT'}">
            <li class="nav-item" >
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseStudents" aria-expanded="true" aria-controls="collapseStudents">
                    <i class="fas fa-fw fa-user"></i>
                    <span>학생메뉴</span>
                </a>
                <div id="collapseStudents" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">학생메뉴</h6>
                        <span class="collapse-item" id="3-1">개인정보 조회 및 수정</span>
                        <span class="collapse-item" id="3-2">수강신청</span>
                        <span class="collapse-item" id="3-3">수강 강좌 조회</span>
                        <span class="collapse-item" id="3-4">비밀번호변경</span>
                    </div>
                </div>
            </li>
</c:if>
              <!-- Nav Item - Utilities Collapse Menu -->
              <c:if test="${not empty userRole and userRole == 'PROFESSOR'}">
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseProfessor" aria-expanded="true" aria-controls="collapseProfessor">
                    <i class="fas fa-fw fa-mortar-board"></i>
                    <span>교수메뉴</span>
                </a>
                <div id="collapseProfessor" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">교수메뉴</h6>
                        <span class="collapse-item" id="4-1">개인정보 조회 및 수정</span>
                        
                                    <c:if test="${endstNo == '1'}">
                        <span class="collapse-item" id="4-2">면접평가</span>
                                    </c:if>
                                    
                        <span class="collapse-item" id="4-3">강좌 개설</span>
                        <span class="collapse-item" id="4-4">학과 관리</span>
                        <span class="collapse-item" id="3-4">비밀번호변경</span>
                        
                    </div>
                </div>
            </li>
            </c:if>
            <!-- Nav Item - Pages Collapse Menu -->
               <c:if test="${not empty userRole and userRole == 'ADMIN'}">
            
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages" style="z-index: 200;">
                    <i class="fas fa-fw fa-check-square"></i>
                    <span>입시관리</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded" style="z-index: 200;">
                        <h6 class="collapse-header">입시관리</h6>
                        <a class="collapse-item" id="5-1">수시 지원자 관리</a>
                        <a class="collapse-item" id="5-2">정시 지원자 관리</a>
                        <a class="collapse-item" id="5-3">모집요강</a>
                        
                    </div>
                </div>
            </li>
</c:if>

          
            
  <c:if test="${not empty userRole and userRole == 'ADMIN'}">
             <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseProfessoredit" aria-expanded="true" aria-controls="collapseProfessoredit">
                    <i class="fas fa-fw fa-sitemap"></i>
                    <span>교직관리</span>
                </a>
                <div id="collapseProfessoredit" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">교직관리</h6>
                        <span class="collapse-item" id="6-1">교수 관리</span>
                        <span class="collapse-item" id="6-2">교수 권한</span>
                    </div>
                </div>
            </li>
</c:if>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>


        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${kornFlnm}</span>
                                <img class="img-profile rounded-circle"
                                    src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                             
                                  
                               <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
<!--    			 </form> -->
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->

                    <div class="box">
                       <div class="menubar" id="menubar"></div>
                       <div class="contentbox" id="contentbox"></div>
                    </div>

                
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2023</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

<!--     Logout Modal -->
  
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">X</button>
                </div>
                <div class="modal-body">정말로 로그아웃을 하시겠습니까?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <form action="/logout" method="post">
                    <a><button type="submit" class="btn btn-primary" >Logout</button></a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>





</body>
</html>