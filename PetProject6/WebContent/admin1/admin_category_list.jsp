<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
<style type="text/css">

	table {
		text-align: center;
	}

</style>
<script type="text/javascript">

	function check(num) {
		let res = confirm("카테고리를 삭제하시겠습니까?");
		
		if(res) {
			location.href="admin_category_delete.do?cnum="+num;
		}
	}
	
</script>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>

	<div align="center">
		<c:set var="list" value="${categoryList }" />
		<hr width="65%" color="marmoon">
			<h3>카테고리 목록</h3>
		<hr width="65%" color="marmoon">
		<br>
		
		<table border="1" cellspacing="0" width="500">
			<tr bgcolor="#C9DECF">
				<th>카테고리 번호</th> <th>카테고리 코드</th>
				<th>카테고리 이름</th> <th>카테고리 삭제</th>
			</tr>
			
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.getCategory_num() } </td>
						<td>${dto.getCategory_code() }</td>
						<td>${dto.getCategory_name() }</td>
						<td> <input type="button" value="삭제"
								onclick="check(${dto.getCategory_num() })"></td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty list }">
				<tr>
					<td colspan="4" align="center">
						<h3>검색된 카테고리 목록이 없습니다.</h3>
					</td>
				</tr>
			</c:if>
			
		</table>
	</div>
	
	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>