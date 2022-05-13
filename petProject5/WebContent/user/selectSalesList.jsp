0<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
<style type="text/css">
font {
	size: 5em;
}

h4 {
	margin-left: 40%;
	color: #F1BCAE;
}

hr {
	color: #C9DECF;
}
</style>
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />

<div id="aside">
            <div class="left_title">
                <p class="big_title">MEMBER</p>
                <p class="small_title">MyPage</p>
                <p class="bl_lt">▼</p>
            </div>
            <div class="mid_nav">
                <ul class="mid_menu">
                    <li><a href="<%=request.getContextPath() %>/pet_info.do?id=<%=(String)session.getAttribute("sessionID") %>" class="nav_on">
                    	<i class="fa fa-caret-right"></i>회원정보조회</a>
                    </li>
                    <li><a href="<%=request.getContextPath() %>/selectSalesList.do">
                    	<i class="fa fa-caret-right"></i>구매내역확인</a>
                    </li>
                </ul>
            </div>
        </div>
      
	<%-- 구매내역 확인 --%>
	
	<div align="center">
		<br>
		<br>
		<h3>구매내역</h3>
		<hr width="80">
		<c:set var="salesList" value="${sales}" />
		<c:set var="dateList" value="${date }"></c:set>

		<c:if test="${!empty salesList}">
			<c:forEach items="${dateList}" var="date">
				<h4 align="left">${date.getSales_date().substring(0,8)}</h4>
				<hr width="20%">
				<c:forEach items="${salesList}" var="dto">
					
					<c:if test="${ date.getSales_date() == dto.getSales_date() }">
						<table>
							<tr>
								<td rowspan="3"><img
									src="<%=request.getContextPath() %>/upload/${dto.getSales_pimage()}"
									width="50%" /></td>
								<td></td>
							</tr>
							<tr>
								<td align="center">${dto.getSales_pname()}<br>
									${dto.getSales_price()}원 <br>수량 : ${dto.getSales_pqty()}
								</td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td colspan="2" align="center"><input type="button"
									value="상품보기"
									onclick="location.href='<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getSales_p_no()}'">
									<input type="button" value="리뷰"
									onclick="location.href='<%=request.getContextPath() %>/selectMyReview.do?no=${dto.getSales_no()}&pno=${dto.getSales_p_no()}'">
								</td>
							</tr>
						</table>
					</c:if>
				</c:forEach>
			</c:forEach>
		</c:if>
		<c:if test="${empty salesList }">
			<font>아직 구매내역이 없습니다.<br>얌얌펫의 제품을 이용해보세요!
			</font>
		</c:if>

		<br>
		<br>
	</div>


	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
