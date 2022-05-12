<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<style type="text/css">
.center {
	text-align: center;
}
</style>

<script type="text/javascript">
function goSales(){
	
	document.frm.action="<%=request.getContextPath()%>/cart_to_sales.do";
	
	document.frm.submit();
}
function updatePqty(obj,id){
	
	//업데이트가 되어야 하는 기존 값..
	let url = document.getElementById(id).href
	console.log(obj.value, url);
	
	//기존값. 업데이트 하고싶은 벨류값임..
	let newvalue = obj.value;
	
	let splitresult = url.split("pqty=")
	console.log(splitresult)
	//pqty 를 기준으로 0번째 ->console.log 참고.
	
	let newlink = splitresult[0]+"pqty="+newvalue
	console.log(newlink)
	
	document.getElementById(id).setAttribute('href', newlink)
	
}
function toggleAllCheck(obj){
	
	let cbValue = document.getElementById("allCheck").checked
	console.log(obj.value, cbValue);
	
 	let cbValues = document.getElementsByName("check")
	console.log(cbValues);	
 	
 	for(let i =0; i<cbValues.length; i++){
 		cbValues[i].checked=cbValue
 	}
 	
 	if(cbValue==false){
 		document.getElementById("total").textContent="0"
 	}else{
 		updateTotal()
 	}
}
function toggleCheck(obj){
	let tcValue = obj.checked
	console.log(tcValue);
	
	updateTotal()
	if(tcValue==false){
		document.getElementById("allCheck").checked = false
	}else{
		
		let tcValues = document.getElementsByName("check")
		
		for(let i=0; i<tcValues.length; i++){
			console.log(tcValues[i].checked)
			if(tcValues[i].checked==false){
				return;
			}
		}
		document.getElementById("allCheck").checked=true
	}
}
function updateTotal(){
	
	let tcValues = document.getElementsByName("check")
	
	let total = 0
	let point = 0
	let trans = 0
	
	for(let i=0; i<tcValues.length; i++){
		console.log(tcValues[i].checked)
		if(tcValues[i].checked==false){
			continue;
		}
		let price = tcValues[i].dataset.price
		console.log(tcValues[i].dataset.price)
		
		tcValues[i].dataset.amount
		let amount = tcValues[i].dataset.amount
		
		total = total+price*amount
		
		point = total*0.01
		
		if(total < 50000){
			trans=3000
		}else{
			trans=0
		}
	}
		document.getElementById("total").textContent=total.toLocaleString('en-US');
		document.getElementById("point").textContent=point.toLocaleString('en-US');
		document.getElementById("trans").textContent=trans.toLocaleString('en-US');
}
</script>
</head>
<body>

	<!-- top -->
	<jsp:include page="../inc/pet_top.jsp"/>
	
	 <form method="post" name="frm" action="cart_to_sales.do">
	         <h3 align="center">장바구니 보기</h3>
	<table>
	<br>
	   <tr>
	      <td colspan="7" class="center">
	      </td>
	   </tr>
	   <tr>
	      <th width="10%">
	      <input type="checkbox" id="allCheck" name="allcheck" onchange="toggleAllCheck(this)" checked></th>
	      <th width="10%">이미지</th>
	      <th width="15%">상품명</th> <th width="12%">수 량</th>
	      <th width="15%">단 가</th> <th width="15%">합계액</th>
	      <th width="10%">삭 제</th>   
	   </tr>
	    
	   <c:set var="list" value="${cartList }" />
	   <c:if test="${!empty list }">
	      <c:forEach items="${list }" var="dto">
	         <tr>
	            <td class="center">
	            	<input type="checkbox" id="${dto.getCart_no() }check" name="check" 
	            	onchange="toggleCheck(this)" checked data-price="${dto.getCart_price() }"
	            	data-amount="${dto.getCart_pqty() }" value="${dto.getCart_no() }">
	            </td>
	            
	            <td class="center"> 
	               <img src="<%=request.getContextPath() %>/upload/${dto.getCart_pimage() }"
	                         width="50" height="50">

	            </td>
	            
	            <td class="center"> ${dto.getCart_pname() } </td>
	            
	            <td class="center">
					<input type="number" name="pqty" min="1" max="100" size=2 value = "${dto.getCart_pqty() }" 
					onchange="updatePqty(this,'${dto.getCart_no() }modify')">
					<br>
					<a id="${dto.getCart_no() }modify"
					href="<%=request.getContextPath() %>/cart_update.do?no=${dto.getCart_no() }
					&pqty=${dto.getCart_pqty()}">
					<button type="button"class="modiBtn">수 정</button></a>
					</td>
					
	            <td class="center">
				   <fmt:formatNumber value="${dto.getCart_price() }" />원
				</td>
	            <td class="center">
	               <c:set var="price" value="${dto.getCart_price() }" />
	               <c:set var="amount" value="${dto.getCart_pqty() }" />
	               <fmt:formatNumber value="${price * amount }" />원
	            </td>
	            
	            <td class="center"> 
	               <a href="<%=request.getContextPath() %>/cart_delete.do?no=${dto.getCart_no() }">
					<button type="button"class="modiBtn">삭 제</button></a>
				</td>
	            
	            <c:set var="total" value="${total + (price * amount) }" />
	            <c:set var="point" value="${total * 0.01 }"/>
	            <c:set var="trans" value="${total < 50000 ? 3000 : 0 }"></c:set>
	         </tr>
	      </c:forEach>
	        </c:if>
		
		 <c:if test="${empty list }">
	      	 <tr>
	         	<td colspan="7" class="center">
	            	<h3>장바구니가 비어 있습니다.....</h3>
	         	</td>
	     	 </tr>
	   	</c:if>
		   </table>
		   
		   
	       	  <div id="calcWrap">
	               <b><font color="red" >장바구니 총액 : 
	               <span id="total"><fmt:formatNumber value="${total }" /></span> 원</font></b>
	               <br>
	               <b><font color="red" >적립예정 마일리지 : 
	               <span id="point"><fmt:formatNumber value="${point }" /></span> 원</font></b>
	           		<br>
	           		<font color="red"> 배송비 총액 : 
	           		<span id="trans"><fmt:formatNumber value="${trans }"/></span> 원</font>
	            </div>
	            
	         	 <div id="submitBtnwrap">
	            	<button type="submit" id="CartToBuyBtn">결제하기</button>
	               
	               	<!--  <a href="javascript:goSales()">[결제하기]</a>-->&nbsp;&nbsp;&nbsp;
	               <a href="javascript:history.go(-2);">
	               <button type="button"id="CartToBuyBtn">계속쇼핑</button></a>
				
				</div>
	 
	   
	  
	
	</form>      
	
	<!-- bottom -->
	
	<jsp:include page="../inc/pet_bottom.jsp"/>
	
</body>
</html>