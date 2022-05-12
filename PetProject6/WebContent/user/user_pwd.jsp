<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                	<c:set var="findPwd" value="${findPwd }" />
                    <table class="login_t">
		                <c:if test="${!empty findPwd }">
                            <c:forEach items="${findPwd }" var="dto">
                                <tr>
                                    <td align="center"> 해당하는 아이디의 비밀번호는 ${findPwd } 입니다.</td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        
                        <c:if test="${empty findPwd }">
                            <tr>
                                <td colspan=""><h4>해당하는 비밀번호가 없습니다.</h4></td>
                            </tr>
                        </c:if>
		            </table>
		            <div id="login_menu">
		               <input type="button" value="로그인하기" class="login_b"
		               	onclick="location.href='<%=request.getContextPath() %>/pet_login.do'">
		            </div>
                </div>
                    
            </div>
    
        </div>
        <div class="clear"></div>
    </div sub_wrap>
    
    <jsp:include page="../inc/pet_bottom.jsp" />

</body>
</html>