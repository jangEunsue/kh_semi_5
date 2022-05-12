<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>

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
		                        <li><a href="<%=request.getContextPath() %>/main.jsp">Login</a></li>
		                        <li><a href="<%=request.getContextPath() %>/pet_join.do">Join</a></li>
	                    <%  } else{ %>
	                    		<li><a href="<%=request.getContextPath() %>/pet_member_mypage.do">MyPage</a></li>
	                        	<li><a href="<%=request.getContextPath() %>/admin_logout.do">Logout</a></li>
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
                    <h1><a href="#"><img src="images/logo.png" alt="logo" border="0"></a></h1>
                </div>
            </div>
            <!--2단 메뉴-->
           
            
            <!-- // 2단 메뉴--> 
        </div>
    </header>
</head>
<body>

<div align="center">
    <hr width="30%" color="blue">
       <h3>관리자 로그인 페이지</h3>
    <hr width="30%" color="blue">
    <br>
    
    <form method="post"
          action="<%=request.getContextPath()%>/admin_login_ok.do">
          
          <table border="1" cellspacing="0" width="400">
            <tr>
              <th>관리자 아이디</th>
              <td> <input name="m_id"> </td>
           </tr>
           
           <tr>
             <th>관리자 비밀번호</th>
             <td> <input type="password" name="m_pwd"> </td>
           </tr> 
            
           <tr>
             <td colspan="2" align="center">
             <input type="submit" value="로그인">&nbsp;&nbsp;&nbsp;
             <input type="reset" value="다시작성">
             </td>
           </tr>
          
          
          </table>
    
    </form>
    </div>
</body>
</html>