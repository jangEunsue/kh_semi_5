<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려견 상품</title>
<%-- 반려견 품종에 따른 상품 페이지 --%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<style type="text/css">
.carousel_text{
	position: relative; 
	top: 70%;
	font-size: 1em;
}

a{
 text-decoration: none;
 color: black;
}

.select_product_kind{
	bgcolor: #C9DECF;
	margin-top: 5%;
}

h3{
	margin-left: 26%;
}

.select{
	margin-right: 10px;
}
</style>
</head>
<body>

<jsp:include page="../inc/pet_top.jsp" />
<div width="80%">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>

	<P>
	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<div align="center">
				<div class="carousel_text">
					<B>품종 특징을 고려한 영향</B>
					<br><br>엄선된 단백질과 항산화 물질로 타곤나 잠재력을 키워 줄 수 있습니다.
				</div>
					<img src="<%=request.getContextPath() %>/image/DogRun.jpg" class="d-block w-100" alt="인기상품">
				</div>
			</div>
			<div class="carousel-item">
				<div align="center">
					<b>맞춤 영양 솔루션</b>
					<br><br>
						반려 동물의 크기, 춤종, 생활방식에 따라 필요한 영향이 다름니다<br> 반려 동물의 자양한 니즈에 맞춘
						맞춤형 영양 제품을 만나보세요
				</div>
				<img src="<%=request.getContextPath() %>/image/DogwithCat.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<div align="center">
					크기별 나이별 종별 영양상태별 세밀하고 정확한 영양학적 솔루션을 제공합니다 제품을 확인하고 무료체험 해보세요!
					 <img src="<%=request.getContextPath() %>/image/DoginBowl.jpg" class="d-block w-100" alt="...">
				</div>
			</div>
		</div>
		<%-- 컨트롤러 --%>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> 
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
			<span class="sr-only"></span>
		</a> 
		<a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next">
			 <span class="carousel-control-next-icon" aria-hidden="true"></span> 
			 <span class="sr-only"></span>
		</a>
	</div>
	<p>
	<p>
	<%-- 상품 종류별 네비게이션 --%>
	<div class="select_product_kind" align="center" width="50%" >
		<a href="#feed">사료</a> &nbsp;&nbsp;&nbsp;&nbsp; 
		<a href="#stick">스틱 및 개껌</a> &nbsp;&nbsp;&nbsp;&nbsp;
		<a href="#biscuit">비스킷</a>&nbsp;&nbsp;&nbsp;&nbsp; 
		<a href="#beefJerky">육포 및 어포</a>&nbsp;&nbsp;&nbsp;&nbsp; 
		<a href="#can">캔</a>&nbsp;&nbsp;&nbsp;&nbsp; 
		<a href="#treat">트릿</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="#milk">펫 밀크</a>
		<hr color=#C9DECF width="50%">
	</div>
	
	<%-- 검색 --%>
	<div class="select" align="right">
		<form method="post"
			action="<%=request.getContextPath()%>/product_search.do">
			<select name="search_field">
				<option value="pName">상품명</option>
			</select> 
			<input name="search_keyword">
			 <input type="submit" value="검색">
		</form>
		</div>
		<%-- 상품 --%>
		<div class="product" align="center">
		<div id="feed">
			<h3 align="left">사료</h3>
			<hr width="50%" align="left">
			<table width="50%">
				<c:set var="feedlist" value="${feed}" />
				<c:if test="${!empty feedlist}">
					<tr>
						<c:forEach var="dto" items="${feedlist}">
							<c:set var="fCount" value="${fCount + 1 }" />
						<%-- count++ --%>
						<td align="center">
							<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
								<img src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
								width="120" height="120" border="0">
							</a>
						 	<br> ${dto.getP_name() }<br> 
							<fmt:formatNumber value="${dto.getP_price() }" />원<br> 
						</td>
						<c:if test="${fCount %4 == 0}">
							</tr>
							<tr>
						</c:if>
						</c:forEach>
					</tr>
				</c:if>
				<c:if test="${empty feedlist }">
				<tr>
					<td rowspan="2"></td>
				</tr>
				</c:if>
			</table>
			</div>
			<br>
			<div id="stick">
			<h3 align="left">스틱 및 개껌</h3>
			<hr width="50%">
			<table width="50%">
			<c:set var="sticklist" value="${stick}" />
			<c:if test="${!empty sticklist}"> <%-- 상품이 있다면 --%>
					<tr>
						<c:forEach var="dto" items="${sticklist}">
							<c:set var="sCount" value="${sCount + 1 }" />
						<%-- count++ --%>
						<td align="center">
							<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
								<img src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
								width="120" height="120" border="0">
							</a>
						 	<br> ${dto.getP_name() }<br> 
							<fmt:formatNumber value="${dto.getP_price() }" />원<br> 
						</td>
						<c:if test="${sCount %4 == 0}">
							</tr>
							<tr>
						</c:if>
						</c:forEach>
					</tr>
				</c:if>
				<c:if test="${empty sticklist }"> <%-- 상품이 없다면 --%>
				<tr>
					<td rowspan="2"></td>
				</tr>
				</c:if>
			</table>
			</div>
			<br>
			<div id="biscuit">
			<h3 align="left">비스킷</h3>
			<hr width="50%">
			<table width="50%">
			<c:set var="biscuitlist" value="${biscuit}" />
			<c:if test="${!empty biscuitlist}"> <%-- 상품이 있다면 --%>
					<tr>
						<c:forEach var="dto" items="${biscuitlist}">
							<c:set var="bCount" value="${bCount + 1 }" />
						<%-- count++ --%>
						<td align="center">
							<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
								<img src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
								width="120" height="120" border="0">
							</a>
						 	<br> ${dto.getP_name() }<br> 
							<fmt:formatNumber value="${dto.getP_price() }" />원<br> 
						</td>
						<c:if test="${bCount %4 == 0}">
							</tr>
							<tr>
						</c:if>
						</c:forEach>
					</tr>
				</c:if>
				<c:if test="${empty biscuitlist }"> <%-- 상품이 없다면 --%>
				<tr>
					<td rowspan="2"></td>
				</tr>
				</c:if>
			</table>
			</div>
			<p>
			<div id="beefJerky">
			<h3 align="left">육포 및 어포</h3>
			<hr width="50%">
			<table width="50%">
			<c:set var="beefJerkyList" value="${beefJerky}" />
			<c:if test="${!empty beefJerkyList}"> <%-- 상품이 있다면 --%>
					<tr>
						<c:forEach var="dto" items="${beefJerkyList}">
							<c:set var="bfCount" value="${bfCount + 1 }" />
						<%-- count++ --%>
						<td align="center">
							<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
								<img src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
								width="120" height="120" border="0">
							</a>
						 	<br> ${dto.getP_name() }<br> 
							<fmt:formatNumber value="${dto.getP_price() }" />원<br> 
						</td>
						<c:if test="${bfCount %4 == 0}">
							</tr>
							<tr>
						</c:if>
						</c:forEach>
					</tr>
				</c:if>
				<c:if test="${empty beefJerkyList }"> <%-- 상품이 없다면 --%>
				<tr>
					<td rowspan="2"></td>
				</tr>
				</c:if>
			</table>
			</div>
			<br>
			<div id="can">
			<h3 align="left">캔</h3>
			<hr width="50%">
			<table width="50%">
			<c:set var="canList" value="${can}" />
			<c:if test="${!empty canList}"> <%-- 상품이 있다면 --%>
					<tr>
						<c:forEach var="dto" items="${canList}">
							<c:set var="cCount" value="${cCount + 1 }" />
						<%-- count++ --%>
						<td align="center">
							<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
								<img src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
								width="120" height="120" border="0">
							</a>
						 	<br> ${dto.getP_name() }<br> 
							<fmt:formatNumber value="${dto.getP_price() }" />원<br> 
						</td>
						<c:if test="${cCount %4 == 0}">
							</tr>
							<tr>
						</c:if>
						</c:forEach>
					</tr>
				</c:if>
				<c:if test="${empty canList }"> <%-- 상품이 없다면 --%>
				<tr>
					<td rowspan="2"></td>
				</tr>
				</c:if>
			</table>
			</div>
			<br>
			<div id="treat">
			<h3 align="left">트릿</h3>
			<hr width="50%">
			<table width="50%"> 
			<c:set var="treatList" value="${treat}" />
			<c:if test="${!empty trearList}"> <%-- 상품이 있다면 --%>
					<tr>
						<c:forEach var="dto" items="${treatList}">
							<c:set var="tCount" value="${tCount + 1 }" />
						<%-- count++ --%>
						<td align="center">
							<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
								<img src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
								width="120" height="120" border="0">
							</a>
						 	<br> ${dto.getP_name() }<br> 
							<fmt:formatNumber value="${dto.getP_price() }" />원<br> 
						</td>
						<c:if test="${tCount %4 == 0}">
							</tr>
							<tr>
						</c:if>
						</c:forEach>
					</tr>
				</c:if>
				<c:if test="${empty treatList }"> <%-- 상품이 없다면 --%>
				<tr>
					<td rowspan="2"></td>
				</tr>
				</c:if>
			</table>
			</div>
			<br>
			<div id="milk">
			<h3 align="left">펫밀크</h3>
			<hr width="50%">
			<table width="50%">
			<c:set var="milkList" value="${milk}" />
			<c:if test="${!empty milkList}"> <%-- 상품이 있다면 --%>
					<tr>
						<c:forEach var="dto" items="${milkList}">
							<c:set var="mCount" value="${mCount + 1 }" />
						<%-- count++ --%>
						<td align="center">
							<a href="<%=request.getContextPath() %>/user_product_view.do?pnum=${dto.getP_num()}">
								<img src="<%=request.getContextPath() %>/upload/${dto.getP_image()}"
								width="120" height="120" border="0">
							</a>
						 	<br> ${dto.getP_name() }<br> 
							<fmt:formatNumber value="${dto.getP_price() }" />원<br> 
						</td>
						<c:if test="${mCount %4 == 0}">
							</tr>
							<tr>
						</c:if>
						</c:forEach>
					</tr>
				</c:if>
				<c:if test="${empty milkList }"> <%-- 상품이 없다면 --%>
				<tr>
					<td rowspan="2"></td>
				</tr>
				</c:if>
			</table>
			</div>
		</div>
</div>
	<script src="http://ajax.googlepis.com/ajax/libs/jquery/1.12.4/jquery.min.js" ></script>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js" > </script>
	<script src="js/run_prettify.js" ></script>
	
	 <jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
				

