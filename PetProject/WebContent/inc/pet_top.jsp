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
<!-- 부트스트랩  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<!-- 스타일 적용 -->
<link rel="stylesheet" type="text/css" href="css/basic.css">
<link rel="stylesheet" type="text/css" href="css/design.css">
<!-- 서브 스타일 -->
<link rel="stylesheet" type="text/css" href="css/sub_st.css">
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.0.2/wow.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<!-- slick 적용 -->
<link rel="stylesheet" type="text/css" href="slick/slick.css">
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css">
<script src="slick/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="slick/slick.min.js"></script>
<script type="text/javascript">
    $(document).on('ready', function() {
      $(".m_slick").slick({
        dots: true,
        autoplay: true,
        autoplaySpeed: 3000,
      });
    });
</script>
<!-- homepee.com pageJsfile -->
<script src="js/myjs.js"></script>
</head>
<body>
	<!-- 탑 시작 -->
	<header id="header">
        <div class="top_header_bg">
            <div id="top_header" class="clearfix">
                <div id="g_nav">
                    <ul class="clearfix">
                        <li class="hidden-xs"><a href="<%=request.getContextPath() %>/pet_main.do">Home</a></li>
                        <%	
                        	// 로그인 안되었을 경우 - 로그인, 회원가입 버튼을 보여준다.
                            if(session.getAttribute("sessionID")==null){ 
                        %>		
		                        <li><a href="<%=request.getContextPath() %>/pet_login.do">Login</a></li>
		                        <li><a href="<%=request.getContextPath() %>/pet_join.do">Join</a></li>
	                    <%  } else{ %>
	                    		<li><a href="<%=request.getContextPath() %>/pet_member_mypage.do">MyPage</a></li>
	                        	<li><a href="<%=request.getContextPath() %>/pet_member_logout.do">Logout</a></li>
	                    <%	}	%>
                    </ul>
                    <div class="clear"></div>
                </div>

            </div>
        </div>
        <!-- ---------------------------------------------------------------------------------------------------------- -->
        <div id="navwrap_bg" class="clearfix">
            <div id="navwrap">
                <div id="logo">
                    <h1><a href="<%=request.getContextPath() %>/pet_main.do"><img src="images/logo.png" alt="logo" border="0"></a></h1>
                </div>
            </div>
            <!--2단 메뉴-->
            <nav id="nav" class="clearfix">
                <ul class="menu">
                    <li><a href="#">사이트 소개</a>
                        <ul>
                            <li><a href="#">인사말</a></li>
                            <li><a href="#">오시는 길</a></li>
                        </ul>
                    </li>
                    <li><a href="#">제품소개</a>
                        <ul>
                            <li><a href="<%=request.getContextPath()%>/user/selectPetKind.jsp">제품소개</a></li>
                        </ul>
                    </li>
                    <li><a href="#">고객센터</a>
                    	<ul>
                            <li><a href="<%=request.getContextPath()%>/user/fqa.jsp">자주하는 질문</a></li>
                        	<li><a href="<%=request.getContextPath() %>/pet_QA.do">Q&A</a></li>
                        </ul>
                    </li>
                    <li><a href="#">커뮤니티</a>
                        <ul>
                            <li><a href="<%=request.getContextPath() %>/free_list.do">커뮤니티</a></li>
                        </ul>
                    </li>
                     <%	// 로그인 안되었을 경우 -
                    	if(session.getAttribute("sessionID")==null){ %>
                   			<li><a href="#" onclick="loginAlert()">마이페이지</a>
	                        	<ul>
	                          		<li><a href="#" onclick="loginAlert()">회원정보조회</a></li>
	                             	<li><a href="#" onclick="loginAlert()">구매내역</a></li>
	                          	</ul>
	                      	</li> 
                    <%  }else { %>
                    		<li><a href="<%=request.getContextPath()%>/pet_modify.do">마이페이지</a>
	                            <ul>
	                            	<li><a href="<%=request.getContextPath() %>/pet_info.do?id=<%=(String)session.getAttribute("sessionID") %>">회원정보수정</a></li>
	                                <li><a href="<%=request.getContextPath() %>/selectSalesList.do">구매내역</a></li>
	                            </ul>
	                        </li>
                    <% }%>
                </ul>
            </nav>
            <!-- // 2단 메뉴--> 
        </div>
    </header>
    <!-- // 탑 끝 -->
    
    <!-- 서브 슬라이드  -->
    <section class="m_slick s_slick slider">
        <div>
            <img src="images/sub_metapo01.jpg">
        </div>
        <div>
            <img src="images/sub_metapo02.jpg">
        </div>
        <div>
            <img src="images/sub_metapo03.jpg">
        </div>
    </section>
    <!-- // 서브 슬라이드  -->

</body>
</html>