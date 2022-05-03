<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

function goSales(){
	
	document.frm.action="<%=request.getContextPath()%>/sales_add.do";
	
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
		
		if(total < 5000000){
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
<style type="text/css">

	.center {
		text-align: center;
	}

</style>
</head>
<body>

	
	 <form method="post" name="frm">
	<table border="1" cellspacing="0" width="650" align="center">
	   <tr>
	      <td colspan="7" class="center">
	         <h3>장바구니 보기</h3>
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
	            <td class="center"><input type="checkbox" id="${dto.getCart_no() }check" name="check" 
	            onchange="toggleCheck(this)" checked data-price="${dto.getCart_price() }"
	            data-amount="${dto.getCart_pqty() }"></td>
	            
	            <td class="center"> 
	               <img src="<%=request.getContextPath() %>/upload/${dto.getCart_pimage() }"
	                         width="50" height="50"></td>
	            <td class="center"> ${dto.getCart_pname() } </td>
	            
	           <td class="center">
				<input type="number" name="pqty" min="1" max="100" size=2 value = "${dto.getCart_pqty() }" 
				onchange="updatePqty(this,'${dto.getCart_no() }modify')">
					
					<br>
					
					<a id="${dto.getCart_no() }modify"
					href="<%=request.getContextPath() %>/user_cart_update.do?no=${dto.getCart_no() }
					&pqty=${dto.getCart_pqty()}">[수 정]</a>
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
	               <a href="<%=request.getContextPath() %>/user_cart_delete.do?no=${dto.getCart_no() }">[삭 제]</a>
	            </td>
	            
	            <c:set var="total" value="${total + (price * amount) }" />
	            <c:set var="point" value="${total * 0.01 }"/>
	            
	         </tr>
	      </c:forEach>
	   
	         <tr>
	            <td colspan="7" align="right">
	               <b><font color="red" >장바구니 총액 : 
	               <span id="total"><fmt:formatNumber value="${total }" /></span> 원</font></b>
	               <br>
	               <b><font color="red" >적립예정 마일리지 : 
	               <span id="point"><fmt:formatNumber value="${point }" /></span> 원</font></b>
	           		<br>
	           		<font color="red"> 배송비 총액 : 
	           		<span id="trans"><fmt:formatNumber value="${trans }"/></span> 원</font>
	            </td>
	            <td colspan="3" class="center">
	               	<a href="javascript:goSales()">[결제하기]</a>&nbsp;&nbsp;&nbsp;
	               <a href="javascript:history.go(-2);">[계속 쇼핑]</a>
	            </td>
	         </tr>
	   </c:if>
	   
	   <c:if test="${empty list }">
	      <tr>
	         <td colspan="7" class="center">
	            <h3>장바구니가 비어 있습니다.....</h3>
	         </td>
	      </tr>
	   </c:if>
	</table>
	   </form>      
	
	
</body>
</html>