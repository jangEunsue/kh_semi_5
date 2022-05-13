<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
<style type="text/css">

	#list_table {
		text-align: center;
	}
	
	td {
		text-align: center;	
	}

	#btn_input {
		margin-right: 20%;
	}
	
	.tbody {
		font-size: 12px;
		height: 50px;
	}
	
	.tbody:nth-child(2n-1) {
		background-color: #F4F4F4;	
	}
	

	.thead1 {
		background-color: #E9E1D4;	
		font-size: 15px;
		text-align: center;
		height: 30px;
	}
	
	.thead2 {
		background-color: #C9DECF;	
		font-size: 13px;
		text-align: center;
		height: 30px;
	}
	
	.pageNum {
		font-size: 13px;
	}
	
	#ptitle {
		text-align: left;
		margin-left: 13%;
		line-height: 10%;
		border-style: solid; 
		border-width: 0 0 0 8px; 
		padding: 12px; 
		word-break: break-all;
		border-color: #E9E1D4;
	}
	
	.pinputtable {
		border: 1px solid #aaaaaa;  
	}
	
	a:link {
	  color : #585858;
	}
	a:visited {
	  color : #585858;
	}
	a:hover {
	  color : black;
	}
	a:active {
	  color : black;
	}
	
	#datepick {
		text-align: center;
	}
	
	input[type="date"] {
	     -webkit-align-items: center;
	     display: -webkit-inline-flex;
	     overflow: hidden;
	     font-size: 14px;
	     padding: 0;
	     -webkit-padding-start: 1px;
	}
	
	input::-webkit-datetime-edit {
	    -webkit-flex: 1;
	    -webkit-user-modify: read-only !important;
	    display: inline-block;
	    min-width: 0;
	    overflow: hidden;
	}
	
	input::-webkit-datetime-edit-fields-wrapper {
	    -webkit-user-modify: read-only !important;
	    display: inline-block;
	    padding: 1px 0;
	    white-space: pre;
	}
	
	.pinputbtn {
		background-color: #C9DECF;
		color: white;
		font-size: 14px;
		padding: 3px 6px 3px 6px;
	}
	
	.pinputsrc {
		font-size: 14px;
		border: 1px solid #dddddd;
		padding-left: 3px;
	}
	
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>
	
	<div align="center">
		<h5 id="ptitle">매출관리</h5>
		<br>
		
		<c:set var="list" value="${salesList }"/>
		<c:set var="psum" value="${psum }"/>
		<c:set var="transcostsum" value="${transcostsum }"/>
		<c:set var="sumall" value="${sumall }"/>

		<form method="post"
					action="<%=request.getContextPath() %>/admin_sales_search.do">

					<span style="font-size: 14px;">기  간 &nbsp;&nbsp;&nbsp;</span>
						<input type="date" name="searchDate_start" id="datepick" class="pinputsrc">
						&nbsp;~&nbsp;
						<input type="date" name="searchDate_end" id="datepick" class="pinputsrc">
					&nbsp;&nbsp;|&nbsp;&nbsp;

					<!-- 상 품 명 &nbsp;&nbsp;&nbsp;&nbsp;
					<input name="searchPname" class="pinputsrc"> -->
					<select name="search_field" class="pinputsrc">
						<option value="p_name">상품명</option>
						<option value="m_id">고객 ID</option>
					</select>
					
					<input name="search_keyword" class="pinputsrc">
					<input type="submit" value="검색" class="pinputbtn">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="전체" class="pinputbtn"
						onclick="location.href='admin_sales_list.do'">

		</form>	
		<br>
		<table id="list_table" class="pinputtable" border="1" cellspacing="0" width="80%" >

			<tr class="thead1">
				<th colspan="2">
					총 ${totalRecord }건
				</th>
				
				<th colspan="8">
					총 합계 : <fmt:formatNumber value="${sumall }" />원
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					상품 합계 : <fmt:formatNumber value="${psum }" />원
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					배송비 합계 : <fmt:formatNumber value="${transcostsum }" />원
				</th>
			</tr>

			<tr class="thead2">
				<th>주문날짜</th><th>주문번호</th><th>고객 ID</th><th>연락처</th><th>주 소</th><th>상품명</th>
				<th>상품가격</th><th>주문수량</th><th>금 액</th><th>배송비</th>
			</tr>

			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr class="tbody">
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
				
				<tr class="thead1">
					
					<th colspan="10">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						총 합계 : <fmt:formatNumber value="${sumall }" />원
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						상품 합계 : <fmt:formatNumber value="${psum }" />원
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						배송비 합계 : <fmt:formatNumber value="${transcostsum }" />원
					</th>
				</tr>
			</c:if>
			
			<c:if test="${empty list }">
				<tr class="tbody">
					<td colspan="10" align="center">
						<h3>검색된 주문 내역이 없습니다.</h3>
					</td>
				</tr>
			</c:if>

		</table>
		<div style="line-height: 30%;"><br></div>
		<br>
		
		<div class="pageNum">
			<c:if test="${page > block }">
				<a href="admin_sales_list.do?page=1">&lt;&lt;</a>&nbsp;
				<a href="admin_sales_list.do?page=${startBlock - 1 }">&lt;&nbsp;</a>
			</c:if>
			
			<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			
				<c:if test="${i == page }">
					<b><a href="admin_sales_list.do?page=${i }">&nbsp;${i }&nbsp;</a></b>
				</c:if>
				
				<c:if test="${i != page }">
					<a href="admin_sales_list.do?page=${i }">&nbsp;${i }&nbsp;</a>
				</c:if>
				
			</c:forEach>
			
			<c:if test="${endBlock < allPage }">
				<a href="admin_sales_list.do?page=${endBlock + 1 }">&nbsp;&gt;</a>&nbsp;
				<a href="admin_sales_list.do?page=${allPage }">&gt;&gt;</a>
			</c:if>
		</div>
		<br>
	</div>
	<br>

	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>
