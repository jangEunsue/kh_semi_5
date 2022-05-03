<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div align="center">
		<h2>주문/결제</h2>
		<br>
		
		<table style="text-align:center; border:1px solid #dddddd" width="800">
			<tr>
				<th width="10%">이미지</th><th width="20%">상품명</th>
				<th width="10%">수량</th><th width="20%">상품금액</th>
			</tr>
			
			<c:set var="list" value="${salesList }"/>
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
				<tr>
				<td class="center">
				<img src="<%=request.getContextPath() %>/upload/${dto.getSales_pimage() }"
	                         width="50" height="50">
	            </td>
	            
	            <td class="center">${dto.getSales_pname() }</td>
	            
	            <td class="center">${dto.getSales_pqty() }</td>
	            
	            <td class="center">${dto.getSales_price() }</td>
				
				</c:forEach>
			</c:if>
			<hr>
		</table>
			<div>
			<tr>
			
			<hr width="40%">
				<h3>결제수단</h3>
			<hr width="40%">					
				<td><input type="radio" name="payment" id="payment">무통장입금</td>
				<td><input type="radio" name="payment" id="payment">신용카드</td>
				<td><input type="radio" name="payment" id="payment">휴대폰결제</td>
				
			</tr>
			</div>
			
			<hr width="40%">
			<div>
			<h3>배송지 정보</h3>
			<table style="border:1px solid #dddddd" width="800">
			<tr>
			<th>수령인 : </th>
			<td>이름</td>
			</tr>
			
			<tr>
			<th>연락처 : </th> 
			<td>${dto.getM_name() }</td>
			</tr>
			
			<tr>
			<th>주 소 : </th> 
			<td>${dto.getM_addr } </td>
			</tr>
						
			<tr>
				<th>배송 메모 : </th>
				<td>
					<select name="sales_message">
						<option value="none" selected>배송 메시지 선택</option>
						<option value="front" >경비실에 보관해주세요.</option>
						<option value="door" >부재 시 현관문 앞에 배송해주세요.</option>
						<option value="speed" >빠른 배송 부탁드립니다.</option>
					</select>
				</td>
			</tr>
			
			</table>
			
			</div>
			<form method="post" action="<%=request.getContextPath() %>/user_sales_ok.do">
			
			<input type="submit" value="결제하기">
			<input type="button" value="뒤로가기">
			
			</form>
	</div>
		
		
</body>
</html>