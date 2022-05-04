<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 구매내역 확인 --%>
<jsp:include page="../inc/pet_top.jsp" />
<div align="center">
		<h3 width="80">리뷰</h3>
		<hr>
		<c:set var="salesList" value="${sales}" />
		<table>
		<c:if test="${!empty salesList}">
		

			<c:forEach items="salesList" var="dto">
				<tr>
					<td rowspan="2"><img
						src="<%=request.getContextPath() %>/upload/${dto.getSales_pimage()}"
						width="25%" /></td>
					<td>${dto.getSales_name()}</td>
				</tr>
				<tr>
					<td><fmt:formatNumber value=" ${dto.getSales_price()}">원</fmt:formatNumber>
					</td>
				</tr>
				<tr>
					<td>${dto.getSales_pqty()}</td>
				</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty salesList }">
				<tr>
					<td>아직 구매내역이 없습니다.<br>얌얌펫의 제품을 이용해보세요!
					</td>
				</tr>
			</c:if>
		</table>
	</div>


 <jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>