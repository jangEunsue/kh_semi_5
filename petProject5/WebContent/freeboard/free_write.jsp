<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/free.css">
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />
	
	
	<div align="center">
		<h3 id="freeContH3">자유 게시판 글쓰기 페이지</h3>
		<br>
		
		<form method="post" action="<%=request.getContextPath()%>/free_write_ok.do">
		
		<input type="hidden" name="userId" value="userId">
		
		<table class="freeContTable">
		<c:set var="pm" value="${memberList }"/>
			
			<tr>
				<th class="freeContTh">작성자</th>
				<td class="freeContTd">
				<input name="writer" value="${pm.getM_name() }" class="freeInput" readonly>
				
				</td>
			
			<tr>
				<th class="freeContTh">글제목</th>
				<td class="freeContTd"><input name="title" class="freeInput" size=98></td>
			</tr>
		
			<tr>
				<th class="freeContTh">글내용</th>
				<td class="freeContTd"><textarea id="freeContText" rows="10" name="content"></textarea></td>
			</tr>
		
			<tr>
				<th class="freeContTh">비밀번호</th>
				<td class="freeContTd"><input type="password" class="freeInput" name="pwd"></td>
			</tr>
			
		</table>

			<div class="freeContBtnWrap">
				<input type="submit" class="freeContBtn" value="글쓰기">&nbsp;&nbsp;&nbsp;
				<input type="reset" class="freeContBtn" value="다시작성">&nbsp;&nbsp;&nbsp;
				<input type="button" class="freeContBtn" value="전체목록" onclick="location.href='free_list.do'">
			</div>
		
		</form>
	</div>
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
