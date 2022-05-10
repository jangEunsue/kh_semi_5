<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

a {
	text-decoration: none;
	color: black;
}

table tr td {
	text-indent: 3em;
}

.btn {
    background-color: #c9decf; 
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    font-family: sans-serif;
    font-weight: bold;
    cursor:pointer;
}

</style>

<script type="text/javascript">
	
	function goCart(){
	
		document.frm.action="<%=request.getContextPath()%>/cart_add.do";
		
		document.frm.submit();
	}
	
	function goSales(){
		document.frm.action="<%=request.getContextPath()%>/sales_add.do";
		
		document.frm.submit();
	}

	
</script>
<script type="text/javascript">
	$(".btn").mouseover(function() {
	var btn = document.getElementByClass("btn");
	btn.style.backgroundColor = '#F1BCAE ';
	});
	
	$(function() {

		$("#review").on("click",function() {
		
		let p_num = $("#p_num").val();
		
		$.ajax({
			type: "post",
			url : "selectReviewCont.jsp",
			data : {pnum : p_num },
			datatype : "jsp",
			success :  function(data) {
				document.p.innerHTML = data;  //id= cont안에 해당 내역을 넣기
				alert("통신 성공");
			},
			error : function(data) {
				alert("통신 오류 입니다.");
			}
		});
		});
		
		$(function cont() {
			
			let p_num = $("#p_num").val();
			
			$.ajax({
				type: "post",
				url : "selectdetailCont.jsp",
				data : {pnum : p_num },
				datatype : "jsp",
				success :  function(data) {
					document.p.innerHTML = data;  //id= cont안에 해당 내역을 넣기
					alert("통신 성공");
				},
				error : function(data) {
					alert("통신 오류 입니다.");
				}
			});
		});
		
		$("#detail").on("click",cont());
		
		cont();
	});
</script>
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />
	<div align="center">
	<form method="post" name="frm">
		<c:set var="dto" value="${cont}"></c:set>
		<c:if test="${dto.getP_name() != null}">
			<br>
			<hr width="30%" color="#C9DECF ">
			<h3>${dto.getP_name()}</h3>
			<hr width="30%" color="#C9DECF ">
			<br>
			
			<input type="hidden" name="p_num" value="${dto.getP_num() }" id="p_num">
			<input type="hidden" name="p_price" value="${dto.getP_price() }">
			<input type="hidden" name="p_image" value="${dto.getP_image() }">
			<input type="hidden" name="p_spec" value="${dto.getP_spec() }">
			<input type="hidden" name="m_id" value="${m_id }">
			<input type="hidden" name="p_point" value="${dto.getP_point() }">
			<input type="hidden" name="p_name" value="${dto.getP_name() }">
			
			<table>
				<tr>
					<td rowspan="4" align="left"><img
						src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
						width="85%" /></td>
					<td></td>
				</tr>
				<tr>
				<td>
				</td>
				</tr>
				<tr>
					<td colspan="2" align="center">${dto.getP_name()}<br>
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;가격 : ${dto.getP_price()}원
						<br>
						<br>
						수량 &nbsp;<input type="number" name="pqty" value="1" min="1" width="30px">
					</td>
				</tr>
				<tr>
				<td>
				<button value="장바구니" class="btn" onclick="goCart()">장바구니</button> &nbsp; &nbsp; &nbsp; &nbsp;
				<button type="submit" value="결제하기" class="btn" onclick="goSales()">결제하기</button>
				</td>
				</tr>
			</table>
			<br>
			<br>
			
			<br>
			<br>
			<input type="button" value="상세정보" onclick="" id="detail"> &nbsp; &nbsp; &nbsp; &nbsp;
	<input type="button" value="리뷰" onclick="review()" id="review">
			<p></p>
		</c:if>
		<c:if test="${dto.getP_name() == null }">
			<h3>조회된 상품이 없습니다</h3>
		</c:if>
		<a href="<%=request.getContextPath()%>/allProductList.do">[전체 상품
			목록]</a> &nbsp; &nbsp; | &nbsp; &nbsp; <a
			href="<%=request.getContextPath()%>/dokindList.do">[품종 선택]</a>

	</form>
	</div>
	 <jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>



