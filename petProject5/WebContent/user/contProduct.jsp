<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세정보</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
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
	cursor: pointer;
}
</style>
<script type="text/javascript">

function goCart(){
	
	let id = $("mId").val();
	if(id == null){
		location.href = "pet_login.do";
	}else{
	   if(confirm("장바구니에 추가하시겠습니까?") == true ){
			let data = $("form").serialize();
	       $.ajax({
	           url: "cart_add.do",
	           type: "POST",
	           data: data,
	           success: function(tableData){
	              if(confirm("장바구니로 이동하시겠습니까?")==true){
	                  location.replace("cart_list.do");
	              }
	           }
	       });
	    }
	}
	
	}
	function goSales(){
		let id = $("mId").val();
		if(id == null){
			location.href = "pet_login.do";
		}else{
			document.frm.action="<%=request.getContextPath()%>/sales_add.do";

			document.frm.submit();
		}
	}

	
</script>
<script type="text/javascript">
	$(".btn").mouseover(function() {
	var btn = document.getElementByClass("btn");
	btn.style.backgroundColor = '#F1BCAE ';
	});
	
 	$(function () {
		$("#detail").on("click",cont());
		
		cont();
		
	
 		$("#reviewCont").hide( );
 		
 		
		$("#detail").on("click",function(){
			$("#review").hide();
			$("#detailCont").show();
			
		});
		
		$("#review").on("click",function(){
			$("#reviewCont").show();
			$("#detailCont").hide();
			
		});
	});
		
		

</script>
</head>
<body>
	<jsp:include page="../inc/pet_top.jsp" />
	<div align="center">
		<form method="post" name="frm" onsubmit="return false">
			<c:set var="dto" value="${cont}"></c:set>
			<c:if test="${dto.getP_name() != null}">
				<br>
				<hr width="30%" color="#C9DECF ">
				<h3>${dto.getP_name()}</h3>
				<hr width="30%" color="#C9DECF ">
				<br>
				
				<table>
					<tr>
						<td rowspan="4" align="left"><img
							src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
							width="85%" /></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td colspan="2" align="center">${dto.getP_name()}<br>
							&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;가격 : ${dto.getP_price()}원 <br>
							<br> 수량 &nbsp;<input type="number" name="pqty" value="1"
							min="1" width="30px">
						</td>
					</tr>
					<tr>
						<td>
							<button value="장바구니" class="btn" onclick="goCart(event)">장바구니</button>
							&nbsp; &nbsp; &nbsp; &nbsp;
							<button type="submit" value="결제하기" class="btn"
								onclick="goSales()">결제하기</button>
						</td>
					</tr>
					
				</table>
				<input type="hidden" name="p_num" value="${dto.getP_num() }"
					id="p_num">
				<input type="hidden" name="p_price" value="${dto.getP_price() }">
				<input type="hidden" name="p_image" value="${dto.getP_image() }">
				<input type="hidden" name="p_spec" value="${dto.getP_spec() }">
				<input type="hidden" name="m_id" value="<%=(String)session.getAttribute("sessionID")%>" id="mId">
				<input type="hidden" name="p_point" value="${dto.getP_point() }">
				<input type="hidden" name="p_name" value="${dto.getP_name() }">
				<br>
				<br>
					
				<br>
				<br>
				 <div id="sub_wrap" class="webfont">
      	   <div id="aside">
           
            <div class="mid_nav">
                <ul class="mid_menu">
                    <li><a href="#%>" class="nav_on">
                    	<i class="fa fa-caret-right" id="detail"></i>상제정보</a>
                    </li>
                    <li><a href="#">
                    	<i class="fa fa-caret-right" id="review"></i>리뷰</a>
                    </li>
                </ul>
            </div>
        </div>
				
				<span id="detailCont">

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

				<span id="reviewCont"> <%-- 제품 리스트에서 보여지는 리뷰 --%>

					<div align="center">
						<h3 width="80">리뷰</h3>
						<hr>
						<table>
							<c:set var="reviewList" value="${review}" />
							<c:if test="${!empty reviewList}">
								<c:forEach items="${reviewList}" var="rev">
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
										<td>${rev.getReview_cont() }</td>
									</tr>
									<tr>
										<td><font>--------------------------------------------------------------</font></td>
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



