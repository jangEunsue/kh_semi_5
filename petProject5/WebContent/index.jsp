<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
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
<script type="text/javascript">
    function loginAlert() {
        alert("사용 권한이 없습니다. 로그인 해주세요");
    }
        
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
                        <li class="hidden-xs"><a href="#">Home</a></li>
                        <%	
                        	// 로그인 안되었을 경우 - 로그인, 회원가입 버튼을 보여준다.
                            if(session.getAttribute("sessionID")==null){ 
                        %>		
		                        <li><a href="<%=request.getContextPath() %>/pet_login.do">Login</a></li>
		                        <li><a href="<%=request.getContextPath() %>/pet_join.do">Join</a></li>
	                    <%  } else{
		                    	if(session.getAttribute("sessionID") == "admin"){ %>
		                    		<li><a href="<%=request.getContextPath() %>/admin1/admin_main.jsp">관리자페이지</a></li>
		                        	<li><a href="<%=request.getContextPath() %>/pet_logout.do">Logout</a></li>
		                <% 		}else { %>
		                	   		<li><a href="<%=request.getContextPath() %>/pet_info.do?id=<%=(String)session.getAttribute("sessionID")%>">MyPage</a></li>
	                        		<li><a href="<%=request.getContextPath() %>/pet_logout.do">Logout</a></li>
		                <%   	} 		
	                   		}	%>
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
                    <li><a href="<%=request.getContextPath() %>/pet_greeting.do">사이트 소개</a>
                        <ul>
                            <li><a href="<%=request.getContextPath() %>/pet_greeting.do">인사말</a></li>
                            <li><a href="<%=request.getContextPath() %>/Direction.do">오시는 길</a></li>
                        </ul>
                    </li>
                    <li><a href="#">제품소개</a>
                        <ul>
                            <li><a href="<%=request.getContextPath()%>/user/selectPetKind.jsp">제품소개</a></li>
                        </ul>
                    </li>
                    <li><a href="#">고객센터</a>
                    	 <ul>
                    		 <li><a href="<%=request.getContextPath() %>/pet_notice.do">공지사항</a></li>
                            <li><a href="<%=request.getContextPath()%>/user/fqa.jsp">자주하는 질문</a></li>
                            <li><a href="<%=request.getContextPath()%>/pet_QA.do">Q&A</a></li>
                        </ul> 
                    </li>
                    <li><a href="#">커뮤니티</a>
                        <ul>
                            <li><a href="<%=request.getContextPath()%>/free_list.do">커뮤니티</a></li>
                        </ul>
                    </li>
                    <%	// 로그인 안되었을 경우 -
                    	if(session.getAttribute("sessionID")==null){ %>
                   			<li><a href="#" onclick="loginAlert()">마이페이지</a>
	                        	<ul>
	                          		<li><a href="#" onclick="loginAlert()">회원정보수정</a></li>
						<li><a href="#" onclick="loginAlert()"></a></li>
						<li><a href="#" onclick="loginAlert()">장바구니</a></li>
                    <%  }else {  %>
                    		<li><a href="<%=request.getContextPath() %>/pet_info.do?id=<%=(String)session.getAttribute("sessionID") %>">마이페이지</a>
	                            <ul>
	                            	<li><a href="<%=request.getContextPath() %>/pet_info.do?id=<%=(String)session.getAttribute("sessionID")%>">회원정보조회</a></li>
					<li><a href="<%=request.getContextPath() %>/selectSalesList.do">구매내역</a></li>
					<li><a href="<%=request.getContextPath() %>/cart_list.do">장바구니</a></li>    
	                             <% }%>
	                                
	                            </ul>
	                        </li>
                </ul>
            </nav>
            <!-- // 2단 메뉴--> 
        </div>
    </header>
    <!-- // 탑 끝 -->
    
    <!-- 메인 슬라이드  -->
    <section class="m_slick slider">
        <div>
            <img src="images/main_metapo01.jpg">
        </div>
        <div>
            <img src="images/main_metapo02.jpg">
        </div>
        <div>
            <img src="images/main_metapo03.jpg">
        </div>
    </section>
    <!-- // 메인 슬라이드  -->
    
    <!--사각 사진들어간 배너 화이트 배경 -->
    <section id="img_banner_bg01_a" class="clearfix"> 
        <div class="main_banner">
            <ul class="base04">
                <li class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay="0s"> 
                    <a href="#">
                        <div class="type_img"><img src="images/banner01.jpg" width="100%" alt=""/></div>
                        <div class="main_banner_title"> COMPANY</div>
                        <p class="main_banner_dec">고객님과 반려동물을 진심으로 생각하는 기업입니다 </p>
                    </a>
                </li>
                <li class="wow flipInY" data-wow-duration="1s" data-wow-delay="0.2s"> 
                    <a href="#">
                        <div class="type_img"><img src="images/banner02.jpg" width="100%" alt=""/></div>
                        <div class="main_banner_title"> PRODUCT</div>
                        <p class="main_banner_dec">사랑하는 반려동물의 전반적인 건강과 감각적인 웰빙을 지원합니다.</p>
                    </a>
                </li>
                <li class="wow flipInY" data-wow-duration="1s" data-wow-delay="0.4s"> 
                    <a href="#">
                        <div class="type_img"><img src="images/banner03.jpg" width="100%" alt=""/></div>
                        <div class="main_banner_title"> Q&A</div>
                        <p class="main_banner_dec">어떠한 궁금증도 신속하고 친절하게 상담해드리겠습니다.</p>
                    </a>
                </li>
                <li class="wow fadeInRight" data-wow-duration="1s" data-wow-delay="0.6s"> 
                    <a href="#">
                        <div class="type_img"><img src="images/banner04.jpg" width="100%" alt=""/></div>
                        <div class="main_banner_title"> SAMPLE</div>
                        <p class="main_banner_dec">반려동물의 입맛에 최적을 찾기 위해 샘플을 보내드립니다.</p>
                    </a>
                </li>
            </ul>
            <div class="clear"></div>
        </div>
    </section>
    <!--//사각 사진들어간 배너 화이트 배경 -->
    
    <!-- 메인 공지사항, 영상, 콜센터 부분 -->
    <section id="bbs04" class="margin-bottom-80">
        <div class="container-fluid wd">
            <div class="row">
                <div class="col-md-4">
                    <div class="main_bbs_list_white01"> 
                        <a href="#">
                            <span class="bbs_big_title" >공지사항</span> <span class="small_title">Notice</span> <span class="pull-right btn btn-grey btn-xs"> more + </span>
                        </a>
                        <div class="bbs_out"> </div>
                        <div class="bbs_origin hidden">공지사항 내용 </div>
                        <script src="{{$template}}/img/homepee/js/bbs/bbs_scroll.js"></script> 
                    </div>
                </div>
                <div class="col-md-4">       
                    <style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/Ty85ijlvSFk' frameborder='0' allowfullscreen></iframe></div>
                </div>
                <div class="col-md-4">
                    <div class="main_call_center_white01">
                        <div class="tel_title">Call Center</div>
                        <div class="s6 text-muted">언제나 친절한 상담을 약속 드리겠습니다</div>
                        <div class="tel_number"><i class="fa fa-phone-square" aria-hidden="true"></i> 02-1544-9970</div>
                        <div class="s6 text-muted"><i class="fa fa-fax" aria-hidden="true"></i> Fax : 02-1544-9971</div>
                        <div class="s6 text-muted"><i class="fa fa-envelope" aria-hidden="true"></i> E-mail : yampet@naver.com</div>
                        <div class="s6 text-muted"><i class="fa fa-clock-o" aria-hidden="true"></i> 상담시간 Am : 09 ~ Pm : 06</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- // 메인 공지사항, 영상, 콜센터 부분 -->
    
    <!-- 고정된 배경, 텍스트 -->
    <div id="para_banner01" class="clearfix">
        <div class="banner">
            <div class="banner-text">
                <div class="bn_txt02">"Happy Dog! Happy Cat! For A long and healthy life"</div>
                <div class="bn_txt03">YamYam PET</div>
            </div>
            <!-- end banner-text --> 
        </div>
        <!-- end banner --> 
    </div>
    <!-- // 고정된 배경, 텍스트 -->
    
    <!-- 하단 지도  -->
    <div class="map_grey">
      	<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.454195224293!2d126.9808471155959!3d37.56792117979768!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2eee632d73f%3A0x15cc2733ad91fd28!2zS0gg7KCV67O06rWQ7Jyh7JuQ!5e0!3m2!1sko!2skr!4v1651580273253!5m2!1sko!2skr" 
      	width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>
    
    <!-- 바텀 시작 -->
    <footer id="footer">
        <div class="bg_foot_menu">
            <div id="foot_menu">
                <ul class="clearfix ">
                	<li><a href="<%=request.getContextPath() %>/pet_main.do">Home</a></li>
                    <!-- 로그인 메뉴 -->
                    <%	
                        // 로그인 안되었을 경우 - 로그인, 회원가입 버튼을 보여준다.
                        if(session.getAttribute("sessionID")==null){ 
                    %>		
		                	<li><a href="<%=request.getContextPath() %>/pet_login.do">로그인</a></li>
		                    <li><a href="<%=request.getContextPath() %>/pet_join.do">회원가입</a></li>
	                <%  } else{ %>
	                    	<li><a href="<%=request.getContextPath() %>/pet_member_mypage.do">마이페이지</a></li>
	                        <li><a href="<%=request.getContextPath() %>/pet_member_logout.do">로그아웃</a></li>
	                <%	}	%>
                </ul>
                <div class="clear"></div>
            </div>
        </div>
        <div id="foot_contents">
            <div class="company_info">
                <ul>
                    <li>
                        <h5><strong>INFORMATION</strong></h5>
                    </li>
                    <li>상호명 : <strong>YamYam PET</strong> </li>
                    <li>주소 : 서울특별시 중구 남대문로 120 대일빌딩 2층, 3층 </li>
                </ul>
                <ul>
                    <li>
                        <h5><strong>&nbsp;</strong></h5>
                    </li>
                    <li>대표전화 : 02-1544-9970</li>
                    <li>팩스번호 : 02-1544-9971 </li>
                    <li>e-mail : yampet@naver.com </li>
                </ul>
                <div class="clear"></div>
            </div>
            <div id="bg_copy">
	            <div class="wd">
	                <div class="copy_year">
	                    <span class="color-red">모든 컨텐츠의 무단복제 및 재판매를 금지합니다.</span><br>
	                    Copyright(c) <span id="year">2022</span> by <strong>YamYam PET</strong> All Rights Reserved.
	                </div>
	            </div>
	        </div>
        </div>
        
    </footer>
	
</body>
</html>