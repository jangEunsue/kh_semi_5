<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	
	<jsp:include page="../include/admin_top.jsp"/>

	<div align="center">
		<c:set var="productList" value="${ProductCategory }" />
		<c:set var="kindList" value="${KindCategory }" />
		<hr width="70%" color="E9E1D4">
			<h3>상품 등록 폼 페이지</h3>
		<hr width="70%" color="E9E1D4">
		<br>
		
		<form method="post" enctype="multipart/form-data"
			action="<%=request.getContextPath() %>/admin_product_input_ok.do">
			
			<table border="1" cellspacing="0" width="400">
				<tr>
					<th>상품분류</th>
					<td>
						<select name="product_category">
							<c:if test="${empty productList }">
								<option value="">:::카테고리 코드 없음:::</option>
							</c:if>
						
							<c:if test="${!empty productList }">
								<c:forEach items="${productList }" var="dto">
									<option value="${dto.getCategory_code() }">
										${dto.getCategory_name() } [${dto.getCategory_code() }]
									</option>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>상품명</th>
					<td><input name="p_name"></td>
				</tr>
				
				<tr>
					<th>상품 이미지</th>
					<td><input type="file" name="p_image"></td>
				</tr>
				
				<tr>
					<th>상품 가격</th>
					<td> <input name="p_price" maxlength="10"></td>
				</tr>
				
				<tr>
					<th>상품 마일리지</th>
					<td><input name="p_point"></td>
				</tr>	
				
				<tr>
					<th>재고 수량</th>
					<td>
						<input type="number" name="p_qty"
							min="1" max="99999" value="1">
					</td>
				</tr>
				
				<%-- '습식','건식' --%>
				<tr>
					<th>습건식 여부</th>
					<td>
						<select name="p_wetdry">
							<option value="전체">전체</option>							
							<option value="습식">습식</option>							
							<option value="건식">건식</option>
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
								<c:forEach items="${kindList }" var="dto">
									<option value="${dto.getCategory_code() }">
										${dto.getCategory_name() } [${dto.getCategory_code() }]
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
							<option value="전연령">전체</option>
							<option value="퍼피">퍼피</option>
							<option value="어덜트">어덜트</option>
							<option value="시니어">시니어</option>
						</select>
					</td>
				</tr>
				
				<%-- '초소형','소형','중형','대형','초대형' --%>
				<tr>
					<th>반려동물 크기</th>
					<td>
						<select name="p_size">
							<option value="전체">전체</option>
							<option value="초소형">초소형</option>
							<option value="소형">소형</option>
							<option value="중형">중형</option>
							<option value="대형">대형</option>
							<option value="초대형">초대형</option>
						</select>
					</td>
				</tr>
				
				<%-- 'O','X' --%>
				<tr>
					<th>반려동물 중성화 여부</th>
					<td>
						<select name="p_neutering">
							<option value="전체">전체</option>
							<option value="true">중성화 O</option>
							<option value="false">중성화 X</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>상품 소개</th>
					<td>
						<textarea rows="7" cols="30" name="p_content"></textarea>
					</td>
				</tr>
						
				<tr>
					<th>제조사</th>
					<td><input name="p_company"></td>
				</tr>
				
				<tr>
					<th>게시 종류</th>
					<td>
						<select name="p_spec">
							<option value="none" >일반</option>
							<option value="hit" >인기</option>
							<option value="new" >최신</option>
							<option value="recommend" >추천</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="상품등록">&nbsp;&nbsp;&nbsp;
						<input type="reset" value="다시작성">
					</td>				
				</tr>
			
			</table>
		</form>
	</div>
	
	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>