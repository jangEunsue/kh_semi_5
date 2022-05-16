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
	.thead{text-align :center; background : #C9DECF;}
	.thead th{padding:5px;}
	.order_cont{ text-align:center; font-size:12px;}
</style>
	
</head>
<body>
		<jsp:include page="../include/admin_top.jsp"/>
		
			<h5 id="htitle">결제 관리</h5>
			<br>
			
			
			
			<table border="1" cellspacing="0" width="65%">
				<tr class="thead">
					<th>판매일</th> <th>주문일련번호</th> <th>수령자이름</th>
					<th>연락처</th> <th>주소</th> <th>상품이미지</th> <th>제품명</th>
					<th>상품수량</th> <th>결제금액</th>  <th>결제상태</th> <th>변경</th>
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
						<c:if test="${o_dao.selectPay(dto.getSales_serial()) eq 0}">
							<td>결제전</td>
							
						</c:if>
						<c:if test="${o_dao.selectPay(dto.getSales_serial()) eq 1}">
							<td>결제완료</td>
							
						</c:if>
						<td>
								<a href="<%=request.getContextPath()%>/admin_order_sales_update.do?p_order_pay=${o_dao.selectPay(dto.getSales_serial())}">변경</a>
								 
							</td>
						
					</tr>
				</c:forEach>
				
			</c:if>
			</table>
		
		</div>
		<jsp:include page="../include/admin_bottom.jsp"/>
</body>
</html>