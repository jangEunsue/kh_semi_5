<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 구매내역에서 작성한 리뷰 확인 -> action -> --%>
	<div align="center">
	<h3 width="80">리뷰</h3> 
	<hr>
		<c:set var="dto" value="${cont}"></c:set>
	<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
	<table>
		<tr>
			<td rowspan="2"> 
				<img src="<%=request.getContextPath() %>/upload/${dto.getP_image()}" width="25%" />
			</td>
			<td> ${dto.getP_name()}</td>
		</tr>
		<tr>
			<td> <fmt:formatNumber value=" ${dto.getP_price()}" >원</fmt:formatNumber> </td>
		</tr>
	</table>
	</a>
	<hr>
	<table>
	<c:set var="rev" value="${review}" />
		<tr>
			<td>${rev.getUserID()} &nbsp;&nbsp;|&nbsp;&nbsp;${rev.getReview_date()} </td>
		</tr>
		<tr>
			<td><img src="<%=request.getContextPath() %>/review/${rev.getRimage()}" width="40%"></td>
		</tr>
		<tr>
			<td>${rev.setReview_cont() }</td>
		</tr>
		<tr>
			<td><input type="button" value="수정하기"></td>
		</tr>
	</table>
	</div>
</body>
</html>
		