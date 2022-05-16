<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료 페이지</title>
<link rel="stylesheet" type="text/css" href="css/payment.css">

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
<jsp:include page="../inc/pet_top.jsp" />
	<form method="post" name="frm" action="pet_main.do">


	<div align="center">
		<h2 id="paymentH2">주문이 성공적으로 접수 되었습니다</h2>
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


	<div align="center" >
	<div id="h3Wrap">
		<h3 align="center" id="paymentH3">결제정보</h3>
	</div>
		<table class="payOkTable1">
		<thead>
			<tr>
				<th class="payOkTh1">상품 금액</th>
				<th class="payOkTh1">배송비</th>
				<th class="payOkTh1">총 결제 금액</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td class="payOkTd1">
					<c:set var="sales_total" value="${sales_total }"/>
					<fmt:formatNumber value="${sales_total }" />원
				</td>
				<td  class="payOkTd1">
					<c:set var="sales_transcost" value="${sales_transcost }"/>
					<fmt:formatNumber value="${sales_transcost }" />원
				</td >
				<td  class="payOkTd1">
					<fmt:formatNumber value="${sales_transcost + sales_total }" />원
				</td>
			</tr>


			<tr>
				<td class="payOkTd1-1">
					<c:set var="total_qty" value="${total_qty }"/>
					 <p class="payOkP">결제 수량 : ${total_qty }</p>
				</td>
				<td class="payOkTd1-1">
				</td>
				<td class="payOkTd1-1">
					<c:set var="payment" value="${payment }"/>
					<p class="payOkP">결제수단 : ${payment }</p>
				</td>
			</tr>
			</tbody>
		</table>

		<div align="center">
		<h3 align="center" id="paymentH3">배송정보</h3>
		<table class="payOkTable2">
			<tr>
				<th class="payOkTh2">받으실 분</th>
				<td class="payOkTd2">
					<c:set var="sales_name" value="${sales_name }"/>
					${sales_name }
				</td>
			</tr>
			<tr>
				<th class="payOkTh2">주소</th>
				<td class="payOkTd2">
					<c:set var="sales_addr" value="${sales_addr }"/>
					${sales_addr }
				</td>
			</tr>

			<tr>
				<th class="payOkTh2">휴대폰 번호</th>
				<td class="payOkTd2">
					<c:set var="sales_phone" value="${sales_phone }"/>
					${sales_phone }
				</td>
			</tr>	      
			<tr>
				<th class="payOkTh2">배송 메시지</th>
				<td class="payOkTd2">
					<c:set var="sales_comments" value="${sales_comments }"/>
					${sales_comments }
			</tr>
		</table>


				<div id="SubmitBtnWrap">
			<button type="submit" value="메인으로" onclick="goMain()" id="SubmitBtn1">메인으로</button>
				&nbsp;&nbsp;&nbsp;
				<button type="submit" value="주문내역확인" onclick="goCheck()" id="SubmitBtn2">주문내역확인</button>
			</div>
		</div>
	</div>
	</form>

<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
