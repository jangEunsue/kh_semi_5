<%@page import="com.pet.model.ProductDTO"%>
<%@page import="com.pet.model.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    	int no = Integer.parseInt(request.getParameter("pnum").trim());
    	
    	ProductDAO dao = ProductDAO.getInstance();
    	
    	ProductDTO dto = dao.selectProductcont(no);
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div align="center"">
	<c:if test="${dto.getP_name() != null }">
		<table>
			<tr>
				<td>추천 나이</td>
				<td>${dto.getP_age() }</td>
			</tr>
			<tr>
				<td>품종</td>
				<td>${dto.getP_kind_fk() }</td>
			</tr>
			<tr>
				<td>사료 유형</td>
				<td>${dto.getP_wetdry() }</td>
			</tr>
			<tr>
				<td>추천 크기</td>
				<td>${dto.getP_size() }</td>
			</tr>
			<tr>
				<td>중성화 여부</td>
				<td>${dto.getP_neutering() }</td>
			</tr>
			<tr>
				<td>제조사</td>
				<td>${dto.getP_company() }</td>
			</tr>
			<tr>
				<td>상품 스펙</td>
				<td>${dto.getP_spec() }</td>
			</tr>
			<tr>
				<td>상품 설명</td>
				<td>${dto.getP_content() }</td>
			</tr>
			<tr>
				<td>포인트</td>
				<td>${dto.getP_point() } 포인트</td>
			</tr>
		</table>
	</c:if>


</div>
</body>
</html>
				
				