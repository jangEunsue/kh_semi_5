<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 페이지</title>
</head>
<body>
<%-- 구매 내역 -> 버튼 클릭 -> 받은 제품 정보 출력 --%>
<jsp:include page="../inc/pet_top.jsp" />
<div align="center">
<br><br>
<h3>리뷰 작성</h3>
<hr width="30%">
<c:set var="dto" value="${sales}"/>
	
	<table>
		<tr>
			<td rowspan="2"> 
			<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getSales_p_no()}">
				<img src="<%=request.getContextPath() %>/upload/${dto.getSales_pimage()}" width="50%" />
			</a>
			</td>
			<td>
			<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getSales_p_no()}">
			 ${dto.getSales_pname()} <br>  ${dto.getSales_price()}원
			</a> 
			</td>
		</tr>
		<tr>

		</tr>
	</table>
	<form  method="post" action="<%=request.getContextPath() %>/insertReview.do" enctype="multipart/form-data">
	<input type="hidden" name="pnum" value="${dto.getSales_p_no()}">
	<input type="hidden" name="SaleNo" value="${dto.getSales_no()}">
	<input type="hidden" name="saleDate" value="${dto.getSales_date()}">
	<table >
		<tr>
			<td align="left"> 내용  </td>
		</tr>
		<tr>
			<td align="center"> <textarea rows="7" cols="25" name="cont"></textarea></td>
		</tr>
		<tr>
			<td> <input type="file" name="image"> </td>
		</tr>
		<tr>
			<td><br></td>
		</tr>
		<tr>
			<td align="center"> <input type="submit" value="작성 완료"> </td>
		</tr>
	</table>
	</form>
	
 <jsp:include page="../inc/pet_bottom.jsp" />
</div>
</body>
</html>
			
			
			
	