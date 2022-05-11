<%@page import="com.pet.model.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.pet.model.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
		

	int no = Integer.parseInt(request.getParameter("pnum").trim());

	ReviewDAO dao = ReviewDAO.getInstance();
	List<ReviewDTO> review = dao.selectReview(no);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%-- 제품 리스트에서 보여지는 리뷰 --%>

	<div align="center">
		<h3 width="80">리뷰</h3>
		<hr>
		<c:set var="dto" value="${cont}"></c:set>
		<a
			href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
			<table>
				<tr>
					<td rowspan="2"><img
						src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
						width="25%" /></td>
					<td>${dto.getP_name()}</td>
				</tr>
				<tr>
					<td><fmt:formatNumber value=" ${dto.getP_price()}">원</fmt:formatNumber>
					</td>
				</tr>
			</table>
		</a>
		<hr>
		<table>
			<c:set var="reviewList" value="${review}" />
			<c:if test="${!empty reviewList}">
				<c:forEach items="reviewList" var="rev">
					<tr>
						<td>${rev.getUserID()}
							&nbsp;&nbsp;|&nbsp;&nbsp;${rev.getReview_date()}</td>
					</tr>
					<tr>
						<c:if test="${rev.getRimage() != null }">
							<td><img
								src="<%=request.getContextPath() %>/review/${rev.getRimage()}"
								width="40%"></td>
						</c:if>
					</tr>
					<tr>
						<td>${rev.setReview_cont() }</td>
					</tr>
					<tr>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty reviewList }">
				<tr>
					<td>아직 해당 상품의 리뷰가 없습니다.<br>첫 리뷰가 되어주세요!
					</td>
				</tr>
			</c:if>
		</table>
	</div>

</body>
</html>
