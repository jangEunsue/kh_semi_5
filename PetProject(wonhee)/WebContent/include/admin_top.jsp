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
                        <%	
                        	// 로그인 안되었을 경우 - 로그인, 회원가입 버튼을 보여준다.
                            if(session.getAttribute("sessionID")==null){ 
                        %>		
		                        <li><a href="<%=request.getContextPath() %>/admin_logout.do">logout</a></li>
		                        
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
                    <h1><a href="#"><img src="images/logo.png" alt="logo" border="0"></a></h1>
                </div>
            </div>
            <!--2단 메뉴-->
            <nav id="nav" class="clearfix">
                <ul class="menu">
                    <li><a href="admin_main.do">관라지 홈</a>
                    </li>
                    <li><a href="#">카테고리</a><!---/default/02/01.php?top=2&sub=0-->
                        <ul>
                            <li><a href="admin_cart_input.do">카테고리 등록</a></li>
                            <li><a href="admin_cart_list.do">카테고리 조회</a></li>
                        </ul>
                    </li>
                    <li><a href="#">상품</a><!--/default/03/01.php?top=3&sub=0--->
                        <ul>
                            <li><a href="admin_product_input.do">상품 등록</a></li>
                            <li><a href="admin_product_list.do">상품 조회</a></li>
                        </ul>
                    </li>
                    <li><a href="#">회원</a><!---/default/04/01.php?top=4&sub=0-->
                        <ul>
                            <li><a href="admin_member_input.do">회원 등록</a></li>
                            <li><a href="admin_member_list.do">회원 조회</a></li>
                        </ul>
                    </li>
                    <li><a href="#">게시판</a><!---/default/05/01.php?top=5&sub=0-->
                        <ul>
                            <li><a href="board_list.do">자유게시판</a></li>
                            <li><a href="boardqa_list.do">Q/A 게시판</a></li>
                            <li><a href="notice_list.do">공지사항</a></li>                           
                        </ul>
                    </li>
                </ul>
            </nav>
            
            <!-- // 2단 메뉴--> 
        </div>
    </header>

     <div align="center">
       <hr width="65%">
         <h2>관리자 페이지</h2>
     
         
       <hr width="65%">
       
       <br>
       
       
     </div>

</body>
</html>