<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/icon?family=Material+Icons');

.dropdown-label {
	font-size: 12px;
	margin: 10px;
	font-weight: bold;
	color: rgb(50, 50, 50);
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropbtn_icon {
	font-family: 'Material Icons';
}

.dropbtn {
	display: block;
	border: 2px solid rgb(94, 94, 94);
	border-radius: 4px;
	background-color: #fcfcfc;
	font-weight: 400;
	color: rgb(124, 124, 124);
	padding: 12px;
	width: 240px;
	text-align: left;
	cursor: pointer;
	font-size: 12px;
	z-index: 1;
	position: relative;
}

.dropdown-content {
	display: none;
	font-weight: 400;
	background-color: #fcfcfc;
	min-width: 240px;
	border-radius: 8px;
	height: 160px;
	overflow: scroll;
	box-shadow: 0px 0px 10px 3px rgba(190, 190, 190, 0.6);
}

.dropdown-content::-webkit-scrollbar {
	width: 5px;
	height: 10px;
}

.dropdown-content::-webkit-scrollbar-thumb {
	border-radius: 2px;
	background-color: rgb(194, 194, 194)
}

.dropdown-content div {
	display: block;
	text-decoration: none;
	color: rgb(37, 37, 37);
	font-size: 12px;
	padding: 12px 20px;
}

.dropdown-content div:hover {
	background-color: rgb(226, 226, 226);
}

.dropdown-content.show {
	display: block;
}

h3{
	margin-left: 26%;
}


</style>
<script type="text/javascript">
window.onload(){
    document.querySelector('.dropbtn_click').onclick (){
      dropdown();
    }
    document.getElementsByClassName('fastfood').onclick (){
      showMenu(value);
    };
    dropdown ()  {
      var v = document.querySelector('.dropdown-content');
      var dropbtn = document.querySelector('.dropbtn')
      v.classList.toggle('show');
      dropbtn.style.borderColor = 'rgb(94, 94, 94)';
    }

    showMenu(value){
      var dropbtn_icon = document.querySelector('.dropbtn_icon');
      var dropbtn_content = document.querySelector('.dropbtn_content');
      var dropbtn_click = document.querySelector('.dropbtn_click');
      var dropbtn = document.querySelector('.dropbtn');

      dropbtn_icon.innerText = '';
      dropbtn_content.innerText = value;
      dropbtn_content.style.color = '#252525';
      dropbtn.style.borderColor = '#3992a8';
    }
  }
  window.onclick (e){
    if(!e.target.matches('.dropbtn_click')){
      var dropdowns = document.getElementsByClassName("dropdown-content");

      var dropbtn_icon = document.querySelector('.dropbtn_icon');
      var dropbtn_content = document.querySelector('.dropbtn_content');
      var dropbtn_click = document.querySelector('.dropbtn_click');
      var dropbtn = document.querySelector('.dropbtn');

      var i;
      for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }
</script>
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />

	<div align="center">
	<%-- 
		<-- 필터 -->
		<div class="dropdown-label">
			상세 필터 <span style="font-family: Material Icons;">restaurant</span>
		</div>
		<div class="dropdown">
			<button class="dropbtn">
				<span class="dropbtn_icon">more_horiz</span> <span
					class="dropbtn_content">크기</span> <span class="dropbtn_click"
					style="font-family: Material Icons; font-size: 16px; color: #3b3b3b; float: right;"
					onclick="dropdown()">전체</span>
			</button>
			<div class="dropdown-content">
				<div class="fastfood" onclick="showMenu(this.innerText)">초소형</div>
				<div class="fastfood" onclick="showMenu(this.innerText)">소형</div>
				<div class="fastfood" onclick="showMenu(this.innerText)">중형</div>
				<div class="fastfood" onclick="showMenu(this.innerText)">대형</div>
				<div class="fastfood" onclick="showMenu(this.innerText)">초대형</div>
			</div>
		</div> --%>
		<p>
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
		<div align="right">
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
			<hr width="50%">
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
			<div id="trear">
			<h3 align="left">트릿</h3>
			<hr width="50%">
			<table width="50%">
			<c:set var="trearList" value="${trear}" />
			<c:if test="${!empty trearList}"> <%-- 상품이 있다면 --%>
					<tr>
						<c:forEach var="dto" items="${trearList}">
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
				<c:if test="${empty trearList }"> <%-- 상품이 없다면 --%>
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
 <jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
					
					
