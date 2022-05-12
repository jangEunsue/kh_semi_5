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
		let res = confirm("정말로 카테고리를 삭제하시겠습니까?");
		
		if(res) {
			location.href="admin_category_delete.do?cnum="+num;
		}
	}
	
</script>
<style type="text/css">
	
	td {
		text-align: center;
	}

	#btn_input {
		margin-right: 20%;
	}
	
	.tbody {
		font-size: 13px;
		height: 30px;
	}
	
	.tbody:nth-child(2n-1) {
		background-color: #F4F4F4;	
	}
	
	.thead {
		background-color: #C9DECF;	
		font-size: 14px;
		text-align: center;
		height: 25px;
	}
	
	.greenbtn {
		background-color: #FFFFFF;
		border: 0.5px solid black;
		border-radius: 3px;
		font-size: 12px;
		padding: 2px;
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
		margin-left: 20%;
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
	
	.pinputtable {
		border: 1px solid #aaaaaa;  
	}
	
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp"/>

	<div align="center">
		<c:set var="list" value="${categoryList }" />
		<h5 id="ptitle">카테고리 목록</h5>
		<br>
		
		<table border="1" cellspacing="0" width="50%" class="pinputtable">
			<tr class="thead">
				<th>카테고리 번호</th> <th>카테고리 코드</th>
				<th>카테고리 이름</th> <th>카테고리 삭제</th>
			</tr>
			
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr class="tbody">
						<td>${dto.getCategory_num() } </td>
						<td>${dto.getCategory_code() }</td>
						<td width="40%">${dto.getCategory_name() }</td>
						<td> <input type="button" class="greenbtn" value="삭제"
								onclick="check(${dto.getCategory_num() })"></td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty list }">
				<tr class="tbody">
					<td colspan="4" align="center">
						<h3>검색된 카테고리 목록이 없습니다.</h3>
					</td>
				</tr>
			</c:if>
			
		</table>
	</div>
	<br>
	
	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>
