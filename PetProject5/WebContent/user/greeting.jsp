<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!--  -->

</head>
<body>

	<jsp:include page="../inc/pet_top.jsp" />
    
    <div id="sub_wrap" class="webfont">
        <div id="aside">
            <div class="left_title">
                <p class="big_title">COMPANY</p>
                <p class="small_title">Greeting</p>
                <p class="bl_lt">▼</p>
            </div>
            <div class="mid_nav">
                <ul class="mid_menu">
                    <li><a href="<%=request.getContextPath() %>/greeting.jsp" class="nav_on">
                    	<i class="fa fa-caret-right"></i>인사말</a>
                    </li>
                    <li><a href="#">
                    	<i class="fa fa-caret-right"></i>오시는 길</a>
                    </li>
                </ul>
            </div>
        </div>
      
      
        <div id="section">
    
            <div class="page_count_bg"> 
                <div id="page_count" class="clearfix">
                    <ul>
                        <li><i class="fa fa-home"></i> Home</li>
                        <li><i class="fa fa-home"></i> 사이트 소개</li>
                        <li> <i class="fa fa-angle-right"></i> <strong>인사말</strong></li>
                    </ul>
                </div>
            </div>
    
            <p class="sub_title">인사말 <span class="sub_title2">Greeting</span></p>
            
            <!-- 본문 시작 -->
            <div id="sub_contents">
            
                <div id="content_wrap">
					<div class="greeting">
						<h3>우리 애완동물에게도 취미와 즐거움을!</h3>
						<h4>PREMIUM PET FOOD & PRODUCTS</h4>
						<br>
						<div id="abright">
					    	<p class="tx1">
					    		안녕하세요. (주)얌얌펫 입니다. <br>
					       	 	오랫동안 건강한 삶을 유지하기 위하여 반 동물의 단순한 먹거리가 아닌 안전하고 신뢰하는 먹거리를 공급하기 위해 노력하고 있습니다.
					      	</p>
					      	<p class="tx1">
					       		 또한, 고객의 요구를 충족시키고 소비자가 항상 믿고 구입할 수 있도록 지속적으로 양질의 제품을 찾아 공급해 나갈 것임을 약속드립니다.
					      	</p>
					      	<p class="tx1">
					         	항상 저희 (주)얌얌펫에 관심을 가져주시고 조언을 서슴없이 해주시는 모든 분들께 깊은 감사 말씀을 전해드리며,<br> 
					         	앞으로도 (주)얌얌펫의 발전을 기대해주시고 그 기대에 부응할 수 있도록 
					         	더욱 더 명철하고 지혜로운 리더의 역할을 감당하는 기업이 되도록 노력하겠습니다.
					       	</p>
					       	<p>
					         	감사합니다.
					      	</p>
					      	<div class="img_box">
					      		<img src="images/greeting.jpg" width="100%" alt=""/>
					      	</div>
					      	<p class="sign"> <span>YamYam PET</span><br> 임직원 일동</p>
					    </div>
						
					</div>
			        
			    </div>
                    
            </div>
    
        </div>
        <div class="clear"></div>
    </div sub_wrap>
    <jsp:include page="../inc/pet_bottom.jsp" />

</body>
</html>