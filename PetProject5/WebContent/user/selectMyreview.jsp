<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성한 리뷰</title>
<script type="text/javascript">

function check(ReviewNo,Pnum) {
	let res = confirm('정말로 삭제하겠습니까?');
	if(res){
		location.href="deleteReview.do?no="+ReviewNo;
	}
}

</script>
</head>
<body>
<%-- 구매내역에서 작성한 리뷰 확인 -> action -> --%>
<jsp:include page="../inc/pet_top.jsp" />
	<div align="center">
	<br><br>
	<h3>리뷰</h3> 
	<hr width="10%">
	<br>
		<c:set var="dto" value="${sales}"/>
	
	<table>
		<tr>
			<td rowspan="2"> 
			<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getSales_p_no()}">
				<img src="<%=request.getContextPath() %>/upload/${dto.getSales_pimage()}" width="50%" />
			</a>
			</td>
			<td>
			<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getSales_p_no()}">
			 ${dto.getSales_pname()} <br>  ${dto.getSales_price()}원
			</a> 
			</td>
		</tr>
		<tr>

		</tr>
	</table>
	<hr width="30%">
	<table>
	<c:set var="rev" value="${review}" />
		<tr>
			<td>${rev.getUserID()} &nbsp;&nbsp;|&nbsp;&nbsp;${rev.getReview_date()} </td>
		</tr>
		<tr>
		<c:if test="${rev.getRimage()!= null }">
			<td><img src="<%=request.getContextPath() %>/review/${rev.getRimage()}" width="40%"></td>
		</c:if>
		</tr>
		<tr>
			<td>${rev.getReview_cont()}</td>
		</tr>
		<tr>
			<td><input type="button" value="수정하기" onclick="location.href='updateReview.do?no=${rev.getReview_no()}&pnum=${rev.getPnum() }'"></td>
			<td><input type="button" value="삭제하기" onclick="check(${rev.getReview_no()})"></td>
		</tr>
	</table>
	</div>
	 <jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
		