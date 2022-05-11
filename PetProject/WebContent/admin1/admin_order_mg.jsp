<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>
		<!-- 왼쪽 상세 탭 -->
		
			
			<ul class="left_menu">
				<li class="left_tab bold"><a href="<%=request.getContextPath()%>/admin_order_mg.do">주문 내역 조회</a></li>
				<li class="left_tab"><a href="<%=request.getContextPath()%>/admin_order_sales.do">결제 관리</a></li>
				<li class="left_tab"><a href="<%=request.getContextPath()%>/admin_order_trans.do">배송 관리</a></li>
			</ul>
			
		</div>
		
		<!-- 오른쪽 내용 탭 -->
		<div class="main_right">
		
			
		
		</div>

</body>
</html>