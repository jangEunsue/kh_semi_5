<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 페이지</title>
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />
<div align="center">
<br><br>
<h3>리뷰 수정</h3>
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
	<form  method="post" action="<%=request.getContextPath() %>/updateOkReview.do" enctype="multipart/form-data">
	<input type="hidden" name="pnum" value="${dto.getSales_p_no()}">
	<input type="hidden" name="SaleNo" value="${dto.getSales_no()}">
	
	<c:set var="rev" value="${review}"></c:set>
	<input type="hidden" name="old_image" value="${rev.getRimage()}">
	
	<table >
		<c:if test="${!empty rev.getRimage() }">
			<tr>
				<td>
					<img src="<%=request.getContextPath() %>/review/${rev.getRimage()}" width="40%">
				</td>
			</tr>
		</c:if>
		<tr>
			<td align="left"> 내용  </td>
		</tr>
		<tr>
			<td align="center"> <textarea rows="7" cols="25" name="cont">${rev.getReview_cont()}</textarea></td>
		</tr>
		<tr>
			<td> <input type="file" name="new_image"> </td>
		</tr>
		<tr>
			<td><br></td>
		</tr>
		<tr>
			<td align="center"> <input type="submit" value="수정 완료"> </td>
		</tr>
	</table>
	</form>
</div>
 <jsp:include page="../inc/pet_bottom.jsp" />

</body>
</html>
