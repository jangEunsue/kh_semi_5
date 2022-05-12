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
	
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>
	
	<div align="center">
		<hr width="80%" color="E9E1D4">
			<h3>PET_PRODUCT 테이블 제품 검색 리스트 페이지</h3>
		<hr width="80%" color="E9E1D4">
		<br>
			
		<table border="1" cellspacing="0" width="80%">
			<tr bgcolor="E9E1D4">
				<th>상품번호</th><th>카테고리 코드</th><th>상품명</th>
				<th>이미지</th> <th>상품 가격</th><th>재고수량</th> <th>게시 종류</th>
				<th>제조사</th> <th>상품 등록일</th> <th>수 정&nbsp;|&nbsp;삭 제</th>
			</tr>
			
			<c:set var="list" value="${List }"/>
			
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.getP_num() }</td>
						<td>${dto.getP_category_fk() }</td>
						<td>${dto.getP_name() }</td>
						<td><img src="<%=request.getContextPath() %>/upload/${dto.getP_image() }"
								width="80" height="80"></td>
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
							<input type="button" value="수정"
								onclick="location.href='<%=request.getContextPath() %>/admin_product_update.do?p_num=${dto.getP_num() }'">
							<%-- <a href="<%=request.getContextPath() %>/admin_product_update.do?p_num=${dto.getP_num() }">수 정</a> --%>
								&nbsp;|&nbsp;
							<input type="button" value="삭제"
								onclick="location.href='<%=request.getContextPath() %>/admin_product_delete.do?p_num=${dto.getP_num() }'">
							<%-- <a href="<%=request.getContextPath() %>/admin_product_delete.do?p_num=${dto.getP_num() }">삭 제</a> --%>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty list }">
				<tr>
					<td colspan="10" align="center">
						<h3>검색된 상품 리스트가 없습니다.</h3>
					</td>
				</tr>
			</c:if>

		</table>

		<div style="line-height: 30%;"><br></div>
		<br>
		
		<%-- 검색 페이징 처리 --%>
		<c:if test="${page > block }">
			<a href="admin_product_search.do?page=1&search_field=${search_field }&search_keyword=${search_keyword}">[맨 처음]</a>&nbsp;
			<a href="admin_product_search.do?page=${startBlock - 1 }&search_field=${search_field }&search_keyword=${search_keyword}">◀</a>
		</c:if>
		
		<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
		
			<c:if test="${i == page }">
				<b><a href="admin_product_search.do?page=${i }&search_field=${search_field }&search_keyword=${search_keyword}">[${i }]</a></b>
			</c:if>
			
			<c:if test="${i != page }">
				<a href="admin_product_search.do?page=${i }&search_field=${search_field }&search_keyword=${search_keyword}">[${i }]</a>
			</c:if>
			
		</c:forEach>
		
		<c:if test="${endBlock < allPage }">
			<a href="admin_product_search.do?page=${endBlock + 1 }&search_field=${search_field }&search_keyword=${search_keyword}">▶</a>&nbsp;
			<a href="admin_product_search.do?page=${allPage }&search_field=${search_field }&search_keyword=${search_keyword}">[맨 뒤로]</a>
		</c:if>
		
		<br>
		<p id="btn_input" align="right">
			<input type="button" value="상품 등록"
				onclick="location.href='admin_product_input.do'">
		</p>
		
		<form method="post" 
				action="<%=request.getContextPath() %>/admin_product_search.do">
			
			<select name="search_field">
				<option value="name"
					<c:if test="${search_field == 'name' }">selected</c:if> >품명</option>
				<option value="category"
					<c:if test="${search_field == 'category' }">selected</c:if> >상품분류코드</option>
				<option value="name_content"
					<c:if test="${search_field == 'name_content' }">selected</c:if> >품명+설명</option>
				<option value="company"
					<c:if test="${search_field == 'company' }">selected</c:if>>제조사</option>
			</select>
			
			<input name="search_keyword" value=${search_keyword }>
			<input type="submit" value="검색">
			&nbsp;&nbsp;
			<input type="button" value="전체목록"
				onclick="location.href='admin_product_list.do'">
		</form>
	</div>

	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>