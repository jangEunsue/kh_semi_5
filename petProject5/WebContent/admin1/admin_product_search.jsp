<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
<style type="text/css">

	td {
		text-align: center;
	}

	#btn_input {
		margin-right: 170px;
	}
		
	.tbody {
		font-size: 12px;
	}
	
	.tbody:nth-child(2n-1) {
		background-color: #F4F4F4;	
	}
	
	.thead {
		background-color: #C9DECF;	
		font-size: 13px;
		text-align: center;
	}
	
	.greenbtn {
		background-color: #FFFFFF;
		border: 0.5px solid black;
		border-radius: 3px;
		font-size: 12px;
		padding: 3px;
	}
	
	.greenbtn:hover {
		font-weight: bold;
		cursor: pointer;
	}
	
	.greenbtn:active {
		background-color: #F2F2F2;
	}
	
	.pageNum {
		font-size: 13px;
	}
	
	#ptitle {
		text-align: left;
		margin-left: 15%;
		line-height: 10%;
		border-style: solid; 
		border-width: 0 0 0 8px; 
		padding: 12px; 
		word-break: break-all;
		border-color: #C9DECF;
	}
	
	a:link {
	  color : #585858;
	}
	a:visited {
	  color : #585858;
	}
	a:hover {
	  color : black;
	}
	a:active {
	  color : black;
	}
	
	.search {
		font-size: 13px;
	}
	
	#searchbtn {
		background-color: #C9DECF;
		border-radius: 1px;
		padding-left: 3px;
		padding-right: 3px;
	}
	
	#listbtn {
		background-color: #C9DECF;
		border-radius: 1px;
		padding-left: 3px;
		padding-right: 3px;
	}
	
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>
	
	<div align="center">
		<h5 id="ptitle">상품관리</h5>
		<br>
			
		<table border="1" cellspacing="0" width="70%">
			<tr bgcolor="E9E1D4" class="thead">
				<th>상품번호</th><th>카테고리 코드</th><th>상품명</th>
				<th>이미지</th> <th>상품 가격</th><th>재고수량</th> <th>게시 종류</th>
				<th>제조사</th> <th>상품 등록일</th> <th>수 정&nbsp;|&nbsp;삭 제</th>
			</tr>
			
			<c:set var="list" value="${List }"/>
			
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr class="tbody">
						<td>${dto.getP_num() }</td>
						<td>${dto.getP_category_fk() }</td>
						<td>${dto.getP_name() }</td>
						<td><img src="<%=request.getContextPath() %>/upload/${dto.getP_image() }"
								width="60" height="60"></td>
						<td> <fmt:formatNumber value="${dto.getP_price() }" />원</td>
						<td>${dto.getP_qty() }</td>
						<c:if test="${dto.getP_spec() eq 'none'}">
							<td>일반</td>
						</c:if>
						<c:if test="${dto.getP_spec() eq 'hit'}">
							<td>인기</td>
						</c:if>
						<c:if test="${dto.getP_spec() eq 'new'}">
							<td>최신</td>
						</c:if>
						<c:if test="${dto.getP_spec() eq 'recommend'}">
							<td>추천</td>
						</c:if>
						
						<td>${dto.getP_company() }</td>
						<td>${dto.getP_inputdate().substring(0, 10) }</td>
						<td>
							<input type="button" value="수정" class="greenbtn"
								onclick="location.href='<%=request.getContextPath() %>/admin_product_update.do?p_num=${dto.getP_num() }'">
							<%-- <a href="<%=request.getContextPath() %>/admin_product_update.do?p_num=${dto.getP_num() }">수 정</a> --%>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="삭제" class="greenbtn"
								onclick="location.href='<%=request.getContextPath() %>/admin_product_delete.do?p_num=${dto.getP_num() }'">
							<%-- <a href="<%=request.getContextPath() %>/admin_product_delete.do?p_num=${dto.getP_num() }">삭 제</a> --%>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty list }">
				<tr class="tbody">
					<td colspan="10" align="center">
						<h3>검색된 상품 리스트가 없습니다.</h3>
					</td>
				</tr>
			</c:if>

		</table>

		<div style="line-height: 30%;"><br></div>
		<br>
		
		<%-- 검색 페이징 처리 --%>
		<div class="pageNum">
			<c:if test="${page > block }">
				<a href="admin_product_search.do?page=1&search_field=${search_field }&search_keyword=${search_keyword}">&lt;&lt;</a>&nbsp;
				<a href="admin_product_search.do?page=${startBlock - 1 }&search_field=${search_field }&search_keyword=${search_keyword}">&lt;&nbsp;</a>
			</c:if>
			
			<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			
				<c:if test="${i == page }">
					<b><a href="admin_product_search.do?page=${i }&search_field=${search_field }&search_keyword=${search_keyword}">&nbsp;${i }&nbsp;</a></b>
				</c:if>
				
				<c:if test="${i != page }">
					<a href="admin_product_search.do?page=${i }&search_field=${search_field }&search_keyword=${search_keyword}">&nbsp;${i }&nbsp;</a>
				</c:if>
				
			</c:forEach>
			
			<c:if test="${endBlock < allPage }">
				<a href="admin_product_search.do?page=${endBlock + 1 }&search_field=${search_field }&search_keyword=${search_keyword}">&nbsp;&gt;</a>&nbsp;
				<a href="admin_product_search.do?page=${allPage }&search_field=${search_field }&search_keyword=${search_keyword}">&gt;&gt;</a>
			</c:if>
		</div>
		
		<br>
		
		<form method="post" 
				action="<%=request.getContextPath() %>/admin_product_search.do">
			
			<select name="search_field" class="search">
				<option value="name"
					<c:if test="${search_field == 'name' }">selected</c:if> >품명</option>
				<option value="category"
					<c:if test="${search_field == 'category' }">selected</c:if> >상품분류코드</option>
				<option value="name_content"
					<c:if test="${search_field == 'name_content' }">selected</c:if> >품명+설명</option>
				<option value="company"
					<c:if test="${search_field == 'company' }">selected</c:if>>제조사</option>
			</select>
			
			<input name="search_keyword" class="search" value=${search_keyword }>
			<input type="submit" value="검색" class="search" id="searchbtn">
			&nbsp;&nbsp;
			<input type="button" value="전체목록" class="search" id="listbtn"
				onclick="location.href='admin_product_list.do'">
		</form>
	</div>
	<br>

	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>
