<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	#list_table {
		text-align: center;
	}

</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>
	
	<div align="center">
		<hr width="80%" color="E9E1D4">
			<h3>PET_SALES 테이블 매출 전체 리스트 페이지</h3>
		<hr width="80%" color="E9E1D4">
		<br>
		
		<c:set var="list" value="${List }"/>
		<c:set var="searchDateStart" value="${searchDateStart }"/>
		<c:set var="searchDateEnd" value="${searchDateEnd }"/>
		<c:set var="searchPname" value="${searchPname }"/>
		
		<c:set var="psum" value="${psum }"/>
		<c:set var="transcostsum" value="${transcostsum }"/>
		<c:set var="sumall" value="${sumall }"/>

		<form method="post"
					action="<%=request.getContextPath() %>/admin_sales_search.do">

					기  간 &nbsp;&nbsp;&nbsp;
					<input type="date" name="searchDate_start"
							value="${searchDateStart }">
					~
					<input type="date" name="searchDate_end"
							value="${searchDateEnd }">
					&nbsp;|&nbsp;

					상 품 명 &nbsp;&nbsp;&nbsp;&nbsp;
					<input name="searchPname" value="${searchPname }">
					&nbsp;|&nbsp;
					<input type="submit" value="검색">
					&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
					<input type="button" value="전체"
						onclick="location.href='admin_sales_list.do'">
		</form>	
		<br>
		<table id="list_table" border="1" cellspacing="0" width="80%" >

			<tr>
				<td colspan="10" align="left">
					총 ${list.size() }건
				</td>
			</tr>
			
			<tr>
			<tr bgcolor="E9E1D4">
				<th>주문날짜</th><th>주문번호</th><th>고객 ID</th><th>연락처</th><th>주 소</th><th>상품명</th>
				<th>상품가격</th><th>주문수량</th><th>금 액</th><th>배송비</th>
			</tr>

			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.getSales_date() }</td>
						<td>${dto.getSales_serial() }</td>
						<td>${dto.getSales_id() }</td>
						<td>${dto.getSales_phone() }</td>
						<td>${dto.getSales_addr() }</td>
						<td>${dto.getSales_pname() }</td>
						<td><fmt:formatNumber value="${dto.getSales_price() }" />원</td>
						<td>${dto.getSales_pqty() }</td>
						<td><fmt:formatNumber value="${dto.getSales_price() * dto.getSales_pqty() }" />원</td>
						<td><fmt:formatNumber value="${dto.getSales_transcost() }" />원</td>

					</tr>
				</c:forEach>
				
				<tr>
					<th colspan="6">합  계</th>
					<th colspan="3">
						<fmt:formatNumber value="${psum }" />원
					</th>
					<th>
						<fmt:formatNumber value="${transcostsum }" />원
					</th>
				</tr>
				
				<tr>
					<th colspan="6">총 합계</th>
					<th colspan="4">
						<fmt:formatNumber value="${sumall }" />원
					</th>
				</tr>
			</c:if>
			
			<c:if test="${empty list }">
				<tr>
					<td colspan="10" align="center">
						<h3>검색된 주문 내역이 없습니다.</h3>
					</td>
				</tr>
			</c:if>

		</table>
	</div>

	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>