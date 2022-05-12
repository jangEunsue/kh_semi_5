<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
     #title {
        float: right;
        margin-right: 300px;
        word-spacing: 10px;
        clear: both;
     }
     
     a {
       text-decoration: none;
     }
 
</style>

<style type="text/css">
	/*헤더 css*/
	ul li {list-style : none;}
	.main_header{padding-left:40px; background:#c9decf;  line-height:50px;}
	.main_mode{float:left; margin:0 50px 0 10px; }
	.main_h_area{height:50px;}
	.main_h_title{width:100px; cursor:pointer; line-height:45px; float:left; text-align: center; height:50px; }
	.main_h_title::after{border-right:1px solid #888;}
	.main_h_title:hover{background:#F1BCAE; transition:all 0.3s;}
	.main_h_title:hover.main_h_title a{font-weight:600; transition:all 0.3s;}
	.main_h_title a {width:100%;height:100%; vertical-align: middle; text-decoration: none; font-size:14px; }
	/*헤더 css end*/
	
	/* 전체 기본 틀 적용css*/	
	*{margin:0; padding:0;}
	html,body{width:100%; height:100%;}
	a{color:#000000; text-decoration:none;}
	a:hover{text-decoration: none;}
	/* 전체 기본 틀 적용css end*/
	
	/* 메인페이지 css */
	.adminid_box{width: 200px;padding:50px; text-align: left;}
	.ad_id{font-size: 16px; color:black;}
	.logout{ margin-top : 10px;font-size:12px;  }
	.logout a{color:#888;}
	.main_box{width:450px; height:120px; float:left; margin:40px;}
	.box_table {margin-top :20px; width:450px; padding:20px; border:1px solid #222222;}
	.menu_direct{font-size:12px; color:#444444; float:right; line-height:0;}
	/* 메인페이지 css end*/
	
	/*왼쪽 탭 css*/
	.main_left{ float:left;width:25%; }
	.left_menu{padding:50px;width:200px; text-align: left; }
	.left_tab{margin-bottom:10px;} 
	.left_tab.bold{font_weight:bold;}
	/*왼쪽 탭 css end*/
	
	/*오른쪽 탭 내용 css*/
	.main_right{float:center; width:75%; text-align: center; margin:40px auto;}
	
	#toptitle {
		margin-left: 20%;
		
	}
</style>

<script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js"></script>
<!-- Animate.css -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.0/animate.min.css" rel="stylesheet" type="text/css">
<!-- Awesome.css -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="css/basic.css">
<link rel="stylesheet" type="text/css" href="css/design.css">
<!-- 메인스타일 -->
<link rel="stylesheet" type="text/css" href="css/main.css">

<link rel="stylesheet" type="text/css" href="slick/slick.css">
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css">
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.0.2/wow.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<script src="slick/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="slick/slick.min.js"></script>
<script type="text/javascript">
    $(document).on('ready', function() {
      $(".m_slick").slick({
        dots: true,
        autoplay: true,
        autoplaySpeed: 2000,
      });
    });
</script>
<!-- homepee.com pageJsfile -->
<script src="js/myjs.js"></script>
</head>
<body>
		<!-- 팁 시작 -->
	<header id="header">
        <div class="top_header_bg">
            <div id="top_header" class="clearfix">
                <div id="g_nav">
                    <ul class="clearfix">
                     <a href="#">${adminName }관리자님 환영합니다.</a>
                        <li class="hidden-xs"><a href="admin_main.do">Home</a></li>
                        <li><a href="<%=request.getContextPath() %>/pet_logout.do">logout</a></li>
                        <%	
                        	// 로그인 안되었을 경우 - 로그인, 회원가입 버튼을 보여준다.
                            if(session.getAttribute("sessionID")==null){ 
                        %>		
		                        
		                        
	                    <%  }  %>
	                    		
                    </ul>
                    <div class="clear"></div>
                </div>

            </div>
        </div>
        <!-- ---------------------------------------------------------------------------------------------------------- -->
        <div id="navwrap_bg" class="clearfix">
            <div id="navwrap">
                <div id="logo">
                    <h1><a href="admin_main.do"><img src="images/logo.png" alt="logo" border="0"></a></h1>
                </div>
            </div>
            <!--2단 메뉴-->
            <nav id="nav" class="clearfix">
                <ul class="menu">
                    <li><a href="#">주문관리</a><!---/default/02/01.php?top=1&sub=0-->
                        <ul>
                            <li><a href="<%=request.getContextPath() %>/admin_order_mg.do">주문 내역</a></li>
                            <li><a href="#">결제 관리</a></li>
                            <li><a href="#">배송 관리</a></li>
                        </ul>
                    </li>

                    <li><a href="#">상품</a><!--/default/03/01.php?top=3&sub=0--->
                        <ul>
                            <li><a href="<%=request.getContextPath() %>/admin_product_list.do">상품 관리</a></li>
                            <li><a href="<%=request.getContextPath() %>/admin_product_input.do">상품 등록</a></li>
                            <li><a href="<%=request.getContextPath() %>/admin_category_list.do">카테고리 관리</a></li>
                            <li><a href="<%=request.getContextPath() %>/admin_category_input.do">카테고리 등록</a></li>
                        </ul>
                    </li>
                    
                    <li><a href="<%=request.getContextPath() %>/admin_sales_list.do">매출관리</a><!---/default/02/01.php?top=2&sub=0-->
                        <!-- <ul>
                            <li><a href="admin_cart_input.do">카테고리 조회</a></li>
                            <li><a href="admin_cart_list.do">카테고리 등록</a></li>
                        </ul> -->
                    </li>
                    <li><a href="#">회원</a><!---/default/04/01.php?top=4&sub=0-->
                        <ul>
                            <li><a href="admin_member_input.do">회원 등록</a></li>
                            <li><a href="admin_member_list.do">회원 조회</a></li>
                        </ul>
                    </li>
                    <li><a href="#">게시판</a><!---/default/05/01.php?top=5&sub=0-->
                        <ul>
                            <li><a href="admin_board_list.do">자유게시판</a></li>
                            <li><a href="admin_boardqa_list.do">Q/A 게시판</a></li>
                            <li><a href="admin_notice_list.do">공지사항</a></li>                           
                        </ul>
                    </li>
                </ul>
            </nav>
            
            <!-- // 2단 메뉴--> 
        </div>
    </header>

     <div align="center">
       <br>
         <h4 id="toptitle" align="left">관리자 모드</h4>
     
         
       <hr width="65%">
       
       <br>
       
       
     </div>

</body>
</html>
