<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	a {
		text-decoration: none;
	}

</style>
</head>
<body>

	<div align="center">
		<hr width="65%" color="gray">
			<h3>펫 상점 메인 페이지</h3>
		<hr width="65%" color="gray">
		<br>
		
		<a href="<%=request.getContextPath() %>/member_login.do">[회원 로그인]</a>
		<br>
		<a href="<%=request.getContextPath() %>/admin_login.do">[관리자 로그인]</a>
		<br>
		<a href="<%=request.getContextPath() %>/admin_product_list.do">[상품관리]</a>
		<br>
		<a href="<%=request.getContextPath() %>/admin_sales_list.do">[매출관리]</a>
		<br>
		
	</div>
	

</body>
</html>