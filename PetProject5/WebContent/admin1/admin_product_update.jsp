<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>
	
	<div align="center">
		<hr width="70%" color="E9E1D4">
			<h3>PET_PRODUCT 테이블 제품 수정 폼 페이지</h3>
		<hr width="70%" color="E9E1D4">
		<br>
		
		<form method="post" enctype="multipart/form-data"
				action="<%=request.getContextPath() %>/admin_product_update_ok.do">
				
			<c:set var="dto" value="${productCont }" />
			<c:set var="kindList" value="${KindCategory }" />
			
			<input type="hidden" name="p_num" value="${dto.getP_num() }">
			<input type="hidden" name="page" value="${page }">
			<table border="1" cellspacing="0" width="600">
				<tr>
					<th>상품분류코드</th>
					<td> 
						<input name="p_category"
							value="${dto.getP_category_fk() }" readonly>
					</td>
				</tr>
			
				<tr>
					<th>상품명</th>
					<td> <input name="p_name"
								value="${dto.getP_name() }" readonly> </td>
				</tr>
				
				<tr>
					<th>상품 이미지</th>
					<td>
						<img src="<%=request.getContextPath() %>/upload/${dto.getP_image() }"
								width="80" height="80">
						<input type="file" name="p_image_new">
						
						<%-- 이미지를 수정하지 않고 그대로 제품수정 버튼을 누를 경우
							  상품 등록 시 입력한 이미지를 그대로 사용하여 "hidden"으로 넘겨주는 코드. --%>
						<input type="hidden" name="p_image_old"
								value="${dto.getP_image() }">
					</td>
				</tr>
				
				<tr>
					<th>상품 가격</th>
					<td>
						<input name="p_price" maxlength="10"
							value="${dto.getP_price() }">
					</td>
				</tr>
				
				<tr>
					<th>상품 마일리지</th>
					<td>
						<input name="p_point" value="${dto.getP_point() }">
					</td>
				</tr>
				
				<tr>
					<th>재고 수량</th>
					<td>
						<input type="number" name="p_qty"
							min="1" max="99999" value="${dto.getP_qty() }">
					</td>
				</tr>
				
				<tr>
					<th>습건식 여부</th>
					<td>
						<select name="p_wetdry">
							<option value="전체"
								<c:if test="${dto.getP_wetdry() eq '전체'}">selected</c:if>>전체</option>							
							<option value="습식"
								<c:if test="${dto.getP_wetdry() eq '습식'}">selected</c:if>>습식</option>							
							<option value="건식"
								<c:if test="${dto.getP_wetdry() eq '건식'}">selected</c:if>>건식</option>							
						</select>
					</td>
				</tr>
				
				<tr>
					<th>반려동물 품종</th>
					<td>
						<select name="kind_category">
							<c:if test="${empty kindList }">
								<option value="">:::카테고리 코드 없음:::</option>
							</c:if>
						
							<c:if test="${!empty kindList }">
								<c:forEach items="${kindList }" var="kindlist">
									<option value="${kindlist.getCategory_code() }"
										<c:if test="${dto.getP_kind_fk() eq kindlist.getCategory_code() }">selected</c:if>>
										${kindlist.getCategory_name() } [${kindlist.getCategory_code() }]
									</option>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>반려동물 나이</th>
					<td>
						<select name="p_age">
							<option value="전연령"
								<c:if test="${dto.getP_age() eq '전연령'}">selected</c:if>>전연령</option>
							<option value="퍼피"
								<c:if test="${dto.getP_age() eq '퍼피'}">selected</c:if>>퍼피</option>
							<option value="어덜트"
								<c:if test="${dto.getP_age() eq '어덜트'}">selected</c:if>>어덜트</option>
							<option value="시니어"
								<c:if test="${dto.getP_age() eq '시니어'}">selected</c:if>>시니어</option>
						</select>
					</td>
				</tr>
				
				<%-- '초소형','소형','중형','대형','초대형' --%>
				<tr>
					<th>반려동물 크기</th>
					<td>
						<select name="p_size">
							<option value="전체"
								<c:if test="${dto.getP_size() eq '전체'}">selected</c:if>>전체</option>
							<option value="초소형"
								<c:if test="${dto.getP_size() eq '초소형'}">selected</c:if>>초소형</option>
							<option value="소형"
								<c:if test="${dto.getP_size() eq '소형'}">selected</c:if>>소형</option>
							<option value="중형"
								<c:if test="${dto.getP_size() eq '중형'}">selected</c:if>>중형</option>
							<option value="대형"
								<c:if test="${dto.getP_size() eq '대형'}">selected</c:if>>대형</option>
							<option value="초대형"
								<c:if test="${dto.getP_size() eq '초대형'}">selected</c:if>>초대형</option>
						</select>
					</td>
				</tr>
				
				<%-- 'O','X' --%>
				<tr>
					<th>반려동물 중성화 여부</th>
					<td>
						<select name="p_neutering">
							<option value="전체"
								<c:if test="${dto.getP_neutering() eq '전체'}">selected</c:if>>전체</option>
							<option value="true"
								<c:if test="${dto.getP_neutering() eq 'true'}">selected</c:if>>중성화 O</option>
							<option value="false"
								<c:if test="${dto.getP_neutering() eq 'false'}">selected</c:if>>중성화 X</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>상품 소개</th>
					<td>
						<textarea rows="7" cols="30" name="p_content">${dto.getP_content() }</textarea>
					</td>
				</tr>
				
				<tr>
					<th>제조사</th>
					<td> <input name="p_company"
								value="${dto.getP_company() }" readonly> </td>
				</tr>
				
				<tr>
					<th>게시 종류</th>
					<td>
						<select name="p_spec">
								<option value="none"
									<c:if test="${dto.getP_spec() == 'none' }"> selected </c:if>>일반</option>
								<option value="hit"
									<c:if test="${dto.getP_spec() == 'hit' }"> selected </c:if>>인기</option>
								<option value="new"
									<c:if test="${dto.getP_spec() == 'new' }"> selected </c:if>>최신</option>
								<option value="recommend"
									<c:if test="${dto.getP_spec() == 'recommend' }"> selected </c:if>>추천</option>
						</select>
			
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="제품수정">&nbsp;&nbsp;&nbsp;
						<input type="button" value="취소"
								onclick="history.back()">					
					</td>
				</tr>
			
			</table>
		</form>
	</div>
	
	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>