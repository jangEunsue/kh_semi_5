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
	color: #C9DECF;
}
</style>
<script type="text/javascript">
	$(".btn").mouseover(function() {
		var btn =${".btn"};
		btn.style.backgroundColor = '#F1BCAE ';
	});

	$(function() {

		$("#review").on("click", function() {

			let p_num = $("#p_num").val();

			$.ajax({
				type : "post",
				url : "selectReviewCont.jsp",
				data : {
					pnum : p_num
				},
				datatype : "jsp",
				success : function(data) {
					document.span.innerHTML = data; //id= cont안에 해당 내역을 넣기
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
				type : "post",
				url : "selectdetailCont.jsp",
				data : {
					pnum : p_num
				},
				datatype : "jsp",
				success : function(data) {
					document.span.innerHTML = data; //id= cont안에 해당 내역을 넣기
					alert("통신 성공");
				},
				error : function(data) {
					alert("통신 오류 입니다.");
				}
			});
		});

		$("#detail").on("click", cont());

		cont();
	});
	
	function cart(num) {
		let res = confirm("장바구니로 이동하시겠습니까?");
		let pqty =$("#pqty").val();
		if(pqty){
			location.href = "addCart.do?no="+num+"&qty="+pqty+"&location="+res;
		}
	}
	
	function goSales(){
		document.frm.action="<%=request.getContextPath()%>/sales_add.do";
		
		document.frm.submit();
	}
	
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
				<input type="hidden" name="p_num" value="${dto.getP_num() }"
					id="p_num">
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
						<td colspan="2" align="center">${dto.getP_name()}<br>
							&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;가격 : ${dto.getP_price()}원 <br>
							<br> 수량 &nbsp;<input type="number" id="pqty" value="1"
							min="1" width="30px">
						</td>
					</tr>
					<tr>
						<td align="center">
							<button value="장바구니" class="btn"
								onclick="cart(${dto.getP_num()})">장바구니</button> &nbsp; &nbsp;
							&nbsp; &nbsp;
							<button value="결제하기" class="btn" onclick="goSales()">결제하기</button>
						</td>
					</tr>
				</table>
				<br>
				<br>

				<br>
				<br>
				<input type="button" value="상세정보" onclick="" id="detail"> &nbsp; &nbsp; &nbsp; &nbsp;
				<input type="button" value="리뷰" onclick="review()" id="review">
				<span></span>
				<span id="detail">

					<table>
						<tr>
							<td>추천 나이</td>
							<td>${dto.getP_age() }</td>
						</tr>
						<tr>
							<td>품종</td>
							<td>${dto.getP_kind_fk() }</td>
						</tr>
						<tr>
							<td>사료 유형</td>
							<td>${dto.getP_wetdry() }</td>
						</tr>
						<tr>
							<td>추천 크기</td>
							<td>${dto.getP_size() }</td>
						</tr>
						<tr>
							<td>중성화 여부</td>
							<td>${dto.getP_neutering() }</td>
						</tr>
						<tr>
							<td>제조사</td>
							<td>${dto.getP_company() }</td>
						</tr>
						<tr>
							<td>상품 스펙</td>
							<td>${dto.getP_spec() }</td>
						</tr>
						<tr>
							<td>상품 설명</td>
							<td>${dto.getP_content() }</td>
						</tr>
						<tr>
							<td>포인트</td>
							<td>${dto.getP_point() }포인트</td>
						</tr>
					</table>

				</span>

				<span id="review"> <%-- 제품 리스트에서 보여지는 리뷰 --%>

					<div align="center">
						<h3 width="80">리뷰</h3>
						<hr>
						<c:set var="dto" value="${cont}"></c:set>
						<a
							href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
							<table>
								<tr>
									<td rowspan="2"><img
										src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
										width="25%" /></td>
									<td>${dto.getP_name()}</td>
								</tr>
								<tr>
									<td>${dto.getP_price()}원</td>
								</tr>
							</table>
						</a>
						<hr>
						<table>
							<c:set var="reviewList" value="${review}" />
							<c:if test="${!empty reviewList}">
								<c:forEach items="reviewList" var="rev">
									<tr>
										<td>${rev.getUserID()}
											&nbsp;&nbsp;|&nbsp;&nbsp;${rev.getReview_date()}</td>
									</tr>
									<tr>
										<c:if test="${rev.getRimage() != null }">
											<td><img
												src="<%=request.getContextPath() %>/review/${rev.getRimage()}"
												width="40%"></td>
										</c:if>
									</tr>
									<tr>
										<td>${rev.setReview_cont() }</td>
									</tr>
									<tr>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty reviewList }">
								<tr>
									<td>아직 해당 상품의 리뷰가 없습니다.<br>첫 리뷰가 되어주세요!
									</td>
								</tr>
							</c:if>
						</table>
					</div>
				</span>
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



