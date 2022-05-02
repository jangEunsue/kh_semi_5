<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<c:set var="dto" value="${cont}"></c:set>
	<h3>${dto.getP_name()}</h3>
	<br>
	
	<table>
		<tr>
			<td rowspan="2"> 
				<img src="<%=request.getContextPath() %>/upload/${dto.getP_image()}" width="25%" />
			</td>
			<td>가격 : </td>
			<td>  <fmt:formatNumber value=" ${dto.getP_price()}" >원</fmt:formatNumber> </td>
		</tr>
		<tr>
			<td colspan="2"  align="center">
				
			</td>
		</tr>
	</table>
	<br>
	<br>
	리뷰
	<hr width="20%">
	
	 
	상세 정보 
	<hr width="20%">
	<table>
		<tr>
			<td>  </td>
			<td>  </td>
		</tr>
		
	</table>


</div>
</body>
</html>
			
			