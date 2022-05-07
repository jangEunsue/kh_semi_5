<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

h3{
	margin-left: 26%;
}

</style>
</head>
<body>
<br>
<br>
	<jsp:include page="../inc/pet_top.jsp" />
	<div align="center">
		<%-- 검색 --%>
		<div align="right">
			<form method="post"
				action="<%=request.getContextPath()%>/product_search.do">
				<select name="search_field">
					<option value="pName">상품명</option>
				</select> <input name="search_keyword"> <input type="submit"
					value="검색">
			</form>
		</div>

		<%-- 상품 --%>
		<div class="product" align="center" width="80%">
			<div id="feed">
				<h3 align="left">겸색결과</h3>
				<hr width="50%">
				<table width="50%">
					<c:set var="productlist" value="${list}" />
					<c:if test="${!empty productlist}">
						<tr>
							<c:forEach var="dto" items="${productlist}">
								<c:set var="count" value="${count + 1 }" />
								<%-- count++ --%>
								<td align="center"><a
									href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
										<img
										src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
										width="120" height="120" border="0">
								</a> <br> ${dto.getP_name() }<br> <fmt:formatNumber
										value="${dto.getP_price() }" />원<br></td>
								<c:if test="${count %4 == 0}">
						</tr>
						<tr>
					</c:if>
					</c:forEach>
					</tr>
					</c:if>
					<c:if test="${empty productlist }">
						<tr>
							<td rowspan="2"></td>
						</tr>
					</c:if>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>