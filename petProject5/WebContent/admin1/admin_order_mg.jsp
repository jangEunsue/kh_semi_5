
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

#htitle {
		float: left;
		margin-left: 17.5%;
		line-height: 10%;
		border-style: solid; 
		border-width: 0 0 0 8px; 
		padding: 12px; 
		word-break: break-all;
		border-color: #C9DECF;
	}
	.od_select_option{width:65%; text-align:right; margin-bottom:20px;}
	.thead{text-align :center; background : #C9DECF;}
	.thead th{padding:5px;}
	.order_cont{ text-align:center; font-size:12px;}
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>
	
		
		
		<div align="center">
			<h5 id="htitle">주문 내역</h5>
			
			<div class="od_select_option">
				<form method="post" action="<%=request.getContextPath()%>/admin_order_search.do">
					<select name="search_list">
						<option value="date">판매일</option>
						<option value="serial_no">주문일련번호</option>
						<option value="sales_name">수령자</option>
						<option value="sales_phone">연락처</option>
						<option value="sales_addr">주소</option>
					</select>
					<input name="search_option">
					<input type="submit" value="검색">
				</form>
			</div>
			
			<table border="1" cellspacing="0" width="65%" >
			<tr class="thead">
				<th>판매일</th> <th>주문일련번호</th> <th>수령자이름</th>
				<th>연락처</th> <th>주소</th> <th>상품이미지</th> <th>제품명</th>
				<th>상품수량</th> <th>결제금액</th> <th>배송상태</th> <th>결제상태</th>
			</tr>
			
			<c:if test="${!empty list }">
			<c:set var="list" value="${list }"/>
			<c:set var="o_dao" value="${o_dao }"/>
				<c:forEach items="${list }" var="dto">
					<tr class="order_cont" >
						<td>${dto.getSales_date() }</td>
						<td>${dto.getSales_serial() }</td>
						<td>${dto.getSales_name() }</td>
						<td>${dto.getSales_phone() }</td>
						<td>${dto.getSales_addr() }</td>
						<td><img src="<%=request.getContextPath()%>/upload/${dto.getSales_pimage()}"
							width="60px" height="60px"></td>
						<td>${dto.getSales_pname() }</td>
						<td>${dto.getSales_pqty() }</td>
						<td><fmt:formatNumber value="${dto.getSales_price() * dto.getSales_pqty() }"/>원</td>
						<c:if test="${o_dao.selectTrans(dto.getSales_serial()) eq 0}">
							<td>배송전</td>
						</c:if>
						<c:if test="${o_dao.selectTrans(dto.getSales_serial()) eq 1}">
							<td>배송중</td>
						</c:if>
						<c:if test="${o_dao.selectTrans(dto.getSales_serial()) eq 2}">
							<td>배송완료</td>
						</c:if>
						<c:if test="${o_dao.selectPay(dto.getSales_serial()) eq 0}">
							<td>결제전</td>
						</c:if>
						<c:if test="${o_dao.selectPay(dto.getSales_serial()) eq 1}">
							<td>결제완료</td>
						</c:if>
					</tr>
				</c:forEach>
				
			</c:if>
			
				<c:if test="${empty list }">
				<tr class="tbody">
					<td colspan="11" align="center">
						<h3>주문내역이 없습니다.</h3>
					</td>
				</tr>
			</c:if>
		</table>
		
		<div style="line-height: 30%;"><br></div>
		<br>
		
		<div class="pageNum">
			<c:if test="${page > block }">
				<a href="admin_product_list.do?page=1">&lt;&lt;</a>&nbsp;
				<a href="admin_product_list.do?page=${startBlock - 1 }">&lt;&nbsp;</a>
			</c:if>
			
			<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			
				<c:if test="${i == page }">
					<b><a href="admin_product_list.do?page=${i }">&nbsp;${i }&nbsp;</a></b>
				</c:if>
				
				<c:if test="${i != page }">
					<a href="admin_product_list.do?page=${i }">&nbsp;${i }&nbsp;</a>
				</c:if>
				
			</c:forEach>
			
			<c:if test="${endBlock < allPage }">
				<a href="admin_product_list.do?page=${endBlock + 1 }">&nbsp;&gt;</a>&nbsp;
				<a href="admin_product_list.do?page=${allPage }">&gt;&gt;</a>
			</c:if>
		</div>
			
		</div>
		
		

	<jsp:include page="../include/admin_bottom.jsp"/>
</body>
</html>