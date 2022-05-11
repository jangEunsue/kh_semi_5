<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	int birthyy = (int)request.getAttribute("birthyy");
	int birthmm = (int)request.getAttribute("birthmm");
	int birthdd = (int)request.getAttribute("birthdd");
	
	int phone1 = (int)request.getAttribute("phone1");
	int phone2 = (int)request.getAttribute("phone2");
	int phone3 = (int)request.getAttribute("phone3");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
        // 회원가입 화면의 입력값들을 검사한다.
        function checkValue()
        {
            var form = document.userInfo;
        
            if(!form.user_pwd.value){
                alert("정보를 수정하시려면 비밀번호를 입력하세요.");
                return false;
            }    
        }
        
   </script>
</head>
<body>

	<jsp:include page="../inc/pet_top.jsp" />
    
    <div id="sub_wrap" class="webfont">
        <div id="aside">
            <div class="left_title">
                <p class="big_title">MEMBER</p>
                <p class="small_title">MyPage</p>
                <p class="bl_lt">▼</p>
            </div>
            <div class="mid_nav">
                <ul class="mid_menu">
                    <li><a href="<%=request.getContextPath() %>/pet_info.do?id=<%=(String)session.getAttribute("sessionID") %>" class="nav_on">
                    	<i class="fa fa-caret-right"></i>회원정보조회</a>
                    </li>
                    <li><a href="<%=request.getContextPath() %>/selectSalesList.do">
                    	<i class="fa fa-caret-right"></i>구매내역확인</a>
                    </li>
                </ul>
            </div>
        </div>
      
      
        <div id="section">
    
            <div class="page_count_bg"> 
                <div id="page_count" class="clearfix">
                    <ul>
                        <li><i class="fa fa-home"></i> Home</li>
                        <li> <i class="fa fa-angle-right"></i> <strong>MyPage</strong></li>
                    </ul>
                </div>
            </div>
    
            <p class="sub_title">회원정보조회 <span class="sub_title2">MyPage</span></p>
            
            <!-- 본문 시작 -->
            <div id="sub_contents">
            
                <div id="login_wrap">
                	<c:set var="dto" value="${Info }"></c:set>
			        <fieldset class="j_info">
			            <legend>${dto.getM_id() } 님 환영합니다.</legend>
			            <form method="post" name="userInfo" onsubmit="return checkValue()"
			            	action="<%=request.getContextPath() %>/pet_modify.do?num=${dto.getM_num()}">
			            	<input type="hidden" name="db_pwd" value="${dto.getM_pwd() }">
			            	<table class="login_t">
			                	<tr>
			                       	<th><i class="fa fa-user-circle"></i></th>
			                       	<td> <input class="input_box" name="user_name" value="${dto.getM_name() }" readonly> </td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-lock"></i></th>
			                       	<td> <input type="password" class="input_box" name="user_pwd" value=""> </td>
			                    </tr>
								<tr>
			                       	<th><i class="fa fa-birthday-cake"></i></th>
			                       	<td class="left">
			                       		<span class="text_lb">생년월일</span>
			                       		<input class="input_box2" name="user_name" value="${dto.getM_birth() }" readonly> 
			                       	</td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-envelope"></i></th>
			                       	<td> <input class="input_box" name="user_email" value="${dto.getM_email() }" readonly> </td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-mobile"></i></th>
			                       	<td class="left">
			                       		<input class="input_box" name="user_name" value="${dto.getM_phone() }" readonly>
			                       	</td>
			                    </tr>
			                    <tr>
				                    <th><i class="fa fa-map-marker"></i></th>
				                    <td class="left">
				                    	<div class="fl_w" id="originAddr">
				                    		<input class="input_box" name="user_addr" value="${dto.getM_addr() }" readonly>
				                    	</div>
				                    </td>
				                </tr>
			                </table>
			                <div id="login_menu">
					            <input type="submit" value="정보수정" class="login_b submit_b">
					        </div>
			            </form>
			            
			            
			        </fieldset>			
			        
			    </div>
                    
            </div>
    
        </div>
        <div class="clear"></div>
    </div sub_wrap>
    <jsp:include page="../inc/pet_bottom.jsp" />

</body>
</html>