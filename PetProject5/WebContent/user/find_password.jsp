<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
</head>
<body>
	<jsp:include page="../inc/pet_top.jsp" />
    
    <div id="sub_wrap" class="webfont">
        <div id="aside">
            <div class="left_title">
                <p class="big_title">MEMBER</p>
                <p class="small_title">Login</p>
                <p class="bl_lt">▼</p>
            </div>
            <div class="mid_nav">
                <ul class="mid_menu">
                    <li><a href="<%=request.getContextPath() %>/pet_login.do" class="nav_on">
                    	<i class="fa fa-caret-right"></i>로그인</a>
                    </li>
                    <li><a href="<%=request.getContextPath() %>/pet_join.do">
                    	<i class="fa fa-caret-right"></i>회원가입</a>
                    </li>
                </ul>
            </div>
        </div>
      
      
        <div id="section">
    
            <div class="page_count_bg"> 
                <div id="page_count" class="clearfix">
                    <ul>
                        <li><i class="fa fa-home"></i> Home</li>
                        <li> <i class="fa fa-angle-right"></i> <strong>Login</strong></li>
                    </ul>
                </div>
            </div>
    
            <p class="sub_title">비밀번호 찾기 <span class="sub_title2">Login</span></p>
            
            <!-- 본문 시작 -->
            <div id="sub_contents">
                <div id="login_wrap">
                    <form method="post" action="<%=request.getContextPath() %>/pet_Login_find_password_ok.do">
                        <table class="login_t">
			                <tr>
			                   <th><i class="fa fa-envelope"></i></th>
			                   <td> <input type="text" class="input_box" name="user_id" placeholder="아이디를 입력하세요"> </td>
			                </tr>
			                <tr>
			                   <td class="emp"></td>
			                </tr>
			                <tr>
			                   <th><i class="fa fa-lock"></i></th>
			                   <td> <input type="text" class="input_box" name="user_email" placeholder="이메일을 입력하세요"> </td>
			                </tr>
			            </table>
			            <div id="login_menu">
			               <input type="submit" value="비밀번호 찾기" class="login_b submit_b">
			               <hr class="lm_line">
			               <input type="button" value="돌아가기" class="join_b" 
			               	onclick="location.href='<%=request.getContextPath() %>/pet_login.do'" >
			            </div>
                    </form>
                </div>
                    
            </div>
    
        </div>
        <div class="clear"></div>
    </div sub_wrap>
    <jsp:include page="../inc/pet_bottom.jsp" />

</body>
</html>