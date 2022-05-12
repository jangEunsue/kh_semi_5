<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	                        <li><a href="<%=request.getContextPath() %>/pet_logout.do">로그아웃</a></li>
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
