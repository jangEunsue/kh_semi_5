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
		margin-right: 20%;
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
<<<<<<< HEAD
		margin-left: 20%;
=======
		margin-left: 15%;
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
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
	
<<<<<<< HEAD
=======
	.search {
		font-size: 13px;
	}
	
	#searchbtn {
		background-color: #C9DECF;
		border-radius: 1px;
		padding-left: 3px;
		padding-right: 3px;
	}
	
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>
	
	<div align="center">

		<h5 id="ptitle">상품관리</h5>
		<br>
		
<<<<<<< HEAD
		<table border="1" cellspacing="0" width="60%">
=======
		<table border="1" cellspacing="0" width="70%">
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
			<tr class="thead">
				<th>상품번호</th><th>카테고리 코드</th><th>상품명</th><!-- <th>반려동물 나이</th> -->
				<!-- <th>반려동물 품종</th><th>습건식 여부</th><th>반려동물 크기</th><th>반려동물 중성화 여부</th> -->
				<th>이미지</th> <th>상품 가격</th><!-- <th>상품 마일리지</th> --> <th>재고수량</th> <th>게시 종류</th>
				<th>제조사</th> <th>상품 등록일</th> <th>수 정&nbsp;&nbsp;|&nbsp;&nbsp;삭 제</th>
			</tr>
			
			<c:set var="list" value="${productList }"/>
			
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr class="tbody">
						<td>${dto.getP_num() }</td>
						<td>${dto.getP_category_fk() }</td>
						<td>${dto.getP_name() }</td>
						<%-- <td>${dto.getP_age() }</td> --%>
						<%-- <td>${dto.getP_kind_fk() }</td>
						<td>${dto.getP_wetdry() }</td>
						<td>${dto.getP_size() }</td>
						<td>${dto.getP_neutering() }</td> --%>
						<td><img src="<%=request.getContextPath() %>/upload/${dto.getP_image() }"
								width="60" height="60"></td>
						<td> <fmt:formatNumber value="${dto.getP_price() }" />원</td>
						<%-- <td><fmt:formatNumber value="${dto.getP_point() }" />원</td> --%>
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
						<td>&nbsp;
							<input type="button" value="수정" class="greenbtn"
								onclick="location.href='<%=request.getContextPath() %>/admin_product_update.do?p_num=${dto.getP_num() }&page=${page }'">
							<%-- <a href="<%=request.getContextPath() %>/admin_product_update.do?p_num=${dto.getP_num() }">수 정</a> --%>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="삭제" class="greenbtn"
								onclick="location.href='<%=request.getContextPath() %>/admin_product_delete.do?p_num=${dto.getP_num() }&page=${page }'">
							<%-- <a href="<%=request.getContextPath() %>/admin_product_delete.do?p_num=${dto.getP_num() }">삭 제</a> --%>
							&nbsp;
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
		
		<div class="pageNum">
			<c:if test="${page > block }">
				<a href="admin_product_list.do?page=1">&lt;&lt;</a>&nbsp;
				<a href="admin_product_list.do?page=${startBlock - 1 }">&lt;&nbsp;</a>
			</c:if>
			
			<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			
				<c:if test="${i == page }">
					<b><a href="admin_product_list.do?page=${i }">&nbsp;${i }&nbsp;</a></b>
				</c:if>
				
				<c:if test="${i != page }">
					<a href="admin_product_list.do?page=${i }">&nbsp;${i }&nbsp;</a>
				</c:if>
				
			</c:forEach>
			
			<c:if test="${endBlock < allPage }">
				<a href="admin_product_list.do?page=${endBlock + 1 }">&nbsp;&gt;</a>&nbsp;
				<a href="admin_product_list.do?page=${allPage }">&gt;&gt;</a>
			</c:if>
		</div>
		
		<br>
		
		<form method="post" 
				action="<%=request.getContextPath() %>/admin_product_search.do">
			
<<<<<<< HEAD
			<select name="search_field">
=======
			<select name="search_field" class="search">
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
				<option value="name">품명</option>
				<option value="category">상품분류코드</option>
				<option value="name_content">품명+설명</option>
				<option value="company">제조사</option>
			</select>
			
<<<<<<< HEAD
			<input name="search_keyword">
			<input type="submit" value="검색">
			
			
		</form>
=======
			<input name="search_keyword" class="search">
			<input type="submit" value="검색" class="search" id="searchbtn">
			
		</form>
		<br>
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
	</div>

	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
<<<<<<< HEAD
</html>
=======
</html>
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
