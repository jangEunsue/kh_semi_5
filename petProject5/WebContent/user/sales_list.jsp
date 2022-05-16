<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/결제</title>
<link rel="stylesheet" type="text/css" href="css/sales.css">
</head>
<body>
	<jsp:include page="../inc/pet_top.jsp" />

	<div class="wrapper">
	<form method="post" name="frm" action="payment_ok.do" onsubmit="return billCheck();">
		<h2 id="orderH2">주문/결제</h2>
		<c:set var="type" value="${type }" />
		<c:set var="cartIds" value="${cartIds }"/>
		<input type="hidden" value="${type }" name="type" />
		<input type="hidden" value="${cartIds }" name="cart_ids" />
	<div align="center">
		<br>
		
		<table class="salesTable1">
			<tr>
				<th class="salesTh1">이미지</th>
				<th class="salesTh1">상품명</th>
				<th class="salesTh1">수량</th>
				<th class="salesTh1">상품금액</th>
				<th class="salesTh1">상품 총금액</th>
			</tr>
			
			<c:set var="list" value="${salesList }"/>
			<c:if test="${!empty list }">
			<c:forEach items="${list }" var="dto">
			<tr>
				<td class="center">
					<img src="<%=request.getContextPath() %>/upload/${dto.getCart_pimage() }"
	                         width="50" height="50">
	            </td>
	            
	            <td class="center">${dto.getCart_pname() }</td>
	            <td class="center">${dto.getCart_pqty() }</td>
	            <td class="center">
	            	<fmt:formatNumber value="${dto.getCart_price() }"/> 원
	            
	            	 <!-- 카트 정보를 지우기위해 cart no 을 넘겨야한다. -->
				     <input type="hidden" name="sales_no" value="${dto.getCart_no() }">
				     <!-- product no 을 이용해서 구매정보를 등록하기 위함 -->
				     <input type="hidden" name="sales_pno" value="${dto.getCart_pno() }">
				     <!-- 수량은 유동적이므로 따로 보내야 한다.(cart는 상관없지만 바로 구매버튼 클릭시 필요) -->
				     <input type="hidden" name="sales_qty" value="${dto.getCart_pqty() }">
	            	
	            </td>
				
				<td class="center">
					 <c:set var="price" value="${dto.getCart_price() }" />
			         <c:set var="amount" value="${dto.getCart_pqty() }" />
					 <fmt:formatNumber value="${price * amount }" />원
				</td>	 
			</tr>
			</c:forEach>
			<tr>
		        <td colspan="5" class="salesCalc">
		            <c:set var="total" value="${total }" />
		            <c:set var="trans" value="${transcost }"/>
		            <c:set var="point" value="${point }"/>
		            <input type="hidden" name="transcost" value="${trans }"/>
				    <input type="hidden" name="mileage" value="${point }"/>
				    <input type="hidden" name="total" value="${total }"/>
		            <b><font color="gray" >장바구니 총액 : 
		            <span id="total" ><fmt:formatNumber value="${total }" /></span> 원</font></b>
		            <br>
		            <b><font color="gray" >적립예정 마일리지 : 
		            <span id="point"><fmt:formatNumber value="${point }" /></span> 원</font></b>
		           	<br>
		           	<font color="gray"> 배송비 총액 : 
			           	<span id="trans">
			           		<fmt:formatNumber value="${trans }" />
		           		</span> 원
	           		</font>
		           		
		       </td>
	        </tr>
			</c:if>
		</table>

			<table class="salesTable2">
				<tr>
				<th class="salesTh1">총 상품금액</th>
				<th class="salesTh1">총 배송비</th>
				<th class="salesTh1">총 결제금액</th>
				</tr>
				<tr>
				<td class="salesTd1">${total }원</td>
				<td class="salesTd1">${trans }원</td>
				<td class="salesTd1">${total+trans }원</td>
				</tr>
			</table>
	        <p id="deliveryInfo">- 배송정보 : 50,000원 미만시 3,000원 부과</p>
			
			<br>
			<br>
			<c:set var="member" value="${memberInfo }"/>
			
			
			<h2 id="orderH2">구매자 정보</h2>
			<table class="salesTable3">
			<tr>
			<th width="10%" class="salesTh2">구매자 : </th>
			<td class="salesTd2">
				<span id="sales_name">${member.getM_name() }</span>
			</td>
			</tr>
			
			<tr>
			<th width="10%" class="salesTh2">연락처 : </th>
			<td class="salesTd2">
				<span id="sales_phone">${member.getM_phone() }</span>
			</td>
			</tr>
			
			
			<tr>
			<th width="10%" class="salesTh2">주 소 : </th>
			<td class="salesTd2">
				<span id="sales_addr">${member.getM_addr() }</span>
			</td>
			</tr>
			</table>
			
			
			<h2 id="orderH2">배송지 정보</h2>
			
			<div class="salesBtn1">	
					<button id="sameBuyer">구매자 정보와 동일</button>
					<button id="resetBtn" type="reset">새로운 배송지</button>
			</div>
			
			<table border="1" cellspacing="0" width="650" id="salesInvoice" class="salesTable3">
			
			<tr>
				<th class="buyer" class="salesTh2">수령인<span style="color:red">*</span></th>
				<td><input name="name" id="name" placeholder="수령인" class="input_border"></td>
			</tr>	
			
			<tr>
				<th class="buyer" class="salesTh2">연락처<span style="color:red">*</span></th>
				<td><input name="phone" id="phone" placeholder="연락처" class="input_border"></td>
			</tr>
			
			 <tr>
                 <th class="salesTh2"><i class="fa fa-map-marker"></i>주소<span style="color:red">*</span></th>
                 <td class="left">
                     <input id="sample6_postcode" placeholder="우편번호" class="input_border" name="user_addr_no">
			<input type="button" class="input_btn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			<input id="sample6_address" placeholder="주소" style="width:75%;" class="input_border" name="user_addr1">
			<input id="sample6_extraAddress" placeholder="참고항목" style="width:20%;" class="input_border" size="5" name="user_addr3">
			<br>
			<input id="sample6_detailAddress" placeholder="상세주소" class="input_border" name="user_addr2">
			
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
			    function sample6_execDaumPostcode() {
			        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("sample6_extraAddress").value = extraAddr;
		                
		                } else {
		                    document.getElementById("sample6_extraAddress").value = '';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('sample6_postcode').value = data.zonecode;
		                document.getElementById("sample6_address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("sample6_detailAddress").focus();
		            }
		        }).open();
		    }
			</script>
                 </td>
             </tr>
		
			<tr>
				<th class="salesTh2">배송 메모</th>
				<td><input name="comments" class="input_border"></td>
			</tr>
			</table>
			
			<h2 id="orderH2">결제 수단</h2>
			<br>
			<table class="salesTable4">
			<tr>
				<th class="salesTh3">
				<input type="radio" name="payment" value="account">무통장입금
				</th>
				<td class="salesTd3">
					<p id="payerP">입금자명 :</p><input name="payer" size=10;>
					<select id="userListSB" name="bankName">
					
					<option value="">계좌를 선택하세요.</option>
					<option value="woori">우리 526-101</option>
					<option value="shinhan">신한 110-335</option>
					<option value="kakao">카카오 3333-17</option>
					</select>
				</td>
			</tr>
			<tr>
				<th class="salesTh3">
				<input type="radio" name="payment" value="credit">신용카드
				</th>
				
				<td class="salesTd3">
				<p class="payInfo">- 결제방식별 할인은 결제시에 반영됩니다.</p>
				</td>
			</tr>
			<tr>
				<th class="salesTh3">
				<input type="radio" name="payment" value="phone">휴대폰결제
				</th>
				<td class="salesTd3">
				<p class="payInfo">- 결제후, 휴대폰 요금청구서에 '소액결제'로 표기됩니다.
				<br>- 결제후, 결제건의 취소는 해당 달에만 가능합니다.
				<br>- 결제방식별 할인은 결제시에 반영됩니다.</p>
				</td>
			</tr>
			</table>
			</div>
				
				
			<div class="salesBtn2">
			<button type="submit" value="결제하기" class="submitBtn">결제하기</button>
			&nbsp;&nbsp;&nbsp;
			<button type="submit" value="계속쇼핑" onclick="goMain()" class="submitBtn">계속쇼핑</button>
			</div>
	</form>
	</div>
	
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>

<script type="text/javascript">

var sameBuyer = document.querySelector("#sameBuyer")

sameBuyer.addEventListener("click", function (ev) {
	ev.preventDefault();
	console.log("buyer clicked");
	
	var sales_name = document.querySelector("#sales_name")
	var sales_phone = document.querySelector("#sales_phone")
	
	document.frm.name.value = sales_name.innerText
	document.frm.phone.value = sales_phone.innerText
})

function goMain(){
	
	document.frm.action="<%=request.getContextPath()%>/pet_main.do";
	
	document.frm.submit();
}

function billCheck(){
	
	var name = document.querySelector("#name");
	var phone = document.querySelector("#phone");
	var sample6_postcode = document.querySelector("#sample6_postcode");
	var sample6_address = document.querySelector("#sample6_address");
	var sample6_detailAddress = document.querySelector("#sample6_detailAddress");
	
	if(!name.value){
		alert("수령인을 입력해주세요");
		name.focus();
		return false;
	};
	
	if(!phone.value){
		alert("배송지 연락처를 입력해주세요");
		phone.focus();
		return false;
	};
	
	if(!sample6_postcode.value){
		alert("우편번호를 입력해주세요");
		sample6_postcode.focus();
		return false;
	};
	if(!sample6_address.value){
		alert("배송지 주소를 입력해주세요");
		sample6_address.focus();
		return false;
	};
	if(!sample6_detailAddress.value){
		alert("상세 주소를 입력해주세요");
		sample6_detailAddress.focus();
		return false;
	};
	
	 ev.target.submit();
}

</script>
</html>
