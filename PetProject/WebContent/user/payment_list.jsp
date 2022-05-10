<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료 페이지</title>
<style type="text/css">

h3{

text-align: left;

}

#pay{

border-bottom: 1px solid lightgray;
border-left-style: hidden;
}
</style>
<script type="text/javascript">

function goMain(){
	
	document.frm.action="<%=request.getContextPath()%>/pet_main.do";
	
	document.frm.submit();
}
function goCheck(){
	
	document.frm.action="<%=request.getContextPath()%>/selectSalesList.do";
	
	document.frm.submit();
}

</script>
</head>
<body>
	<form method="post" name="frm" action="user_main.do">
	<div align="center">
		<h2>주문이 성공적으로 접수 되었습니다</h2>
		<p>
			<span>
				<c:set var="sales_serial" value="${sales_serial }"/>
				주문번호 : ${sales_serial }
			</span>
			 | 			
			<span>
				<c:set var="sales_name" value="${sales_name }"/>
				${sales_name } 고객님 감사합니다.
			</span>
		</p>	
	</div>
	
	
	<div>
		<h3>결제정보</h3>
		<table id="pay">
		
			<tr>
				<th>상품 금액</th>
				<th>배송비</th>
				<th>결제 금액</th>
			</tr>
			<tr>
				<td>
					<c:set var="sales_total" value="${sales_total }"/>
					<fmt:formatNumber value="${sales_total }" />원
				</td>
				<td>
					<c:set var="sales_transcost" value="${sales_transcost }"/>
					<fmt:formatNumber value="${sales_transcost }" />원
				</td>
				<td>
					<fmt:formatNumber value="${sales_transcost + sales_total }" />원
				</td>
			</tr>
			<tr>
				<td>
					<c:set var="total_qty" value="${total_qty }"/>
					 ${total_qty }
				</td>
				<td>
				</td>
				<td>
					<c:set var="payment" value="${payment }"/>
					${payment }
				</td>
			</tr>
		</table>
		
		<h3>배송정보</h3>
		<table id="ship">
			<tr>
				<th>받으실 분</th>
				<td>
					<c:set var="sales_name" value="${sales_name }"/>
					${sales_name }
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<c:set var="sales_addr" value="${sales_addr }"/>
					${sales_addr }
				</td>
			</tr>
			
			<tr>
				<th>휴대폰 번호</th>
				<td>
					<c:set var="sales_phone" value="${sales_phone }"/>
					${sales_phone }
				</td>
			</tr>	      
		    <tr>
		    	<td align="center">
		    	<button type="submit" value="메인으로" onclick="goMain()">메인으로</button>
				&nbsp;&nbsp;&nbsp;
				<button type="submit" value="주문내역확인" onclick="goCheck()">주문내역확인</button>
		    	</td>
		    </tr>
		</table>
	</div>
</form>
</body>
</html>