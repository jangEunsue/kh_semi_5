<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려견 상품</title>
<style type="text/css">
	hr{
		color: #C9DECF;
	}
	
	table tr td a{
		text-decoration: none;
		color: black;
	}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	
	<div align="center">
		<hr width="40%" color="#C9DECF">
		<h3>CHOOSE YOUR FAMILY</h3>
		<hr width="40%">
	
	<!-- 페이징 처리 -->
		<!-- 전페이지로 이동하는 버튼 -->
		<c:if test="${page > block}">
			<a href="board_list.do?page=1">◀◀</a>
			<!-- 1페이지로 이동 -->
			<a href="board_list.do?page=${startBlock -1 }">◀</a>
			<!-- 이전페이지로 이공 -->
		</c:if>

		<div class="petKind">
			<table width="90%">
			<tr>
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/allProductList.do"><img alt="전체" src="../image/dogs.jpg" width="90%"><br>전체</a>
				</td>
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/selectProductList.do?petKind=01"><img alt="닥스훈트" src="../image/foxhound.jpg" width="90%"><br>닥스훈트</a>
				</td>
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/selectProductList.do?petKind=02"><img alt="말티즈" src="../image/maltese.jpg" width="90%"><br>말티즈</a>
				</td>
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/selectProductList.do?petKind=03"><img alt="슈나우저" src="../image/schnauzer.jpg" width="90%"><br>슈나우저</a>
				</td>
			</tr>
			<tr>
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/selectProductList.do?petKind=04"><img alt="비숑프리제" src="../image/bichon.jpg" width="90%"><br>비숑프리제</a>
				</td>
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/selectProductList.do?petKind=05"><img alt="시츄" src="../image/shih.jpg" width="90%"><br>시츄</a>
				</td>
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/selectProductList.do?petKind=06"><img alt="요크셔 테리어" src="../image/yorkshire.jpg" width="90%"><br>요크셔 테리어</a>
				</td>
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/selectProductList.do?petKind=07"><img alt="포메라니안" src="../image/pomeranian.jpg" width="90%"><br>포메라니안</a>
				</td>
			</tr>
			<tr align="left">
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/selectProductList.do?petKind=08"><img alt="푸들" src="../image/poodle.jpg" width="90%"><br>푸들</a>
				</td>
				<td align="center" width="20%">
					<a href="<%=request.getContextPath()%>/selectProductList.do?petKind=09"><img alt="프렌치 불록" src="../image/french.jpg" width="90%" height="110%"><br>프렌치 블록</a>
				</td>
			</tr>
			</table>
		
		</div>

		<!-- 다음 페이지로 이동 -->
		<c:if test="${endBlock < allPage }">
			<a href="board_list.do?page=${endBlock + 1}">▶</a>
			<a href="board_list.do?page=${allPage}">▶▶</a>
		</c:if>
		<br>
		<br>
		
	 <jsp:include page="../inc/pet_bottom.jsp" />
  
</div>
</body>
</html>