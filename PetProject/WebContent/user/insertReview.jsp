<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 페이지</title>
</head>
<body>
<%-- 구매 내역 -> 버튼 클릭 -> pnum 넘기기 -> user_product_view.do 에서 제품 상세 정보 받아오기 --%>
<jsp:include page="../inc/pet_top.jsp" />
<div align="center">
<c:set var="dto" value="${cont}"></c:set>
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
	<form  method="post" action="<%=request.getContextPath() %>/insertReview.do" enctype="multipart/form-data">
	<input type="hidden" name="pnum" value="${dto.getP_num()}">
	<input type="hidden" name="SaleNo" value="${dto.getSale_no()}">
	<table>
		<tr>
			<td align="left"> 내용  </td>
		</tr>
		<tr>
			<td> <textarea rows="7" cols="25" name="cont" /></td>
		</tr>
		<tr>
			<td> <input type="file" name="image"> </td>
		</tr>
		<tr>
			<td> <input type="submit" value="작성 완료"> </td>
		</tr>
	</table>
	</form>
	
 <jsp:include page="../inc/pet_bottom.jsp" />
</div>
</body>
</html>
			
			
			
	