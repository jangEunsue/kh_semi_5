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
		<c:set var="dto" value="${update }"/>
		<h3 id="freeContH3">${dto.getFree_writer() }님 게시글 수정 페이지</h3>
		<br>
		<br>
		
		<form method="post" action="<%=request.getContextPath() %>/free_update_ok.do">
		<input type="hidden" name="free_no" value="${dto.getFree_no() }">
		<table class="freeContTable">
			
			
			<tr>
				<th class="freeContTh">글쓴이</th>
				<td class="freeContTd"><input name="writer" class="freeInput" value="${dto.getFree_writer() }" readonly></td>
			</tr>
			
			<tr>
				<th class="freeContTh">제목</th>
				<td class="freeContTd"><input name="title" class="freeInput" value="${dto.getFree_title() }" size=98></td>
			</tr>		

			<tr>
				<th class="freeContTh">글내용</th>
				<td class="freeContTd"><textarea id="freeContText" rows="10" cols="100" name="content">${dto.getFree_cont() }</textarea>
				</td>
			</tr>

			<tr>
				<th class="freeContTh">비밀번호</th>
				<td class="freeContTd"><input type="password" class="freeInput" name="pwd"></td>
			</tr>
			
		</table>
		
				<input type="submit" class="freeContBtn" value="수정">&nbsp;&nbsp;&nbsp;
				<input type="button" class="freeContBtn" value="이전으로" onclick="location.href='free_content.do?no=${dto.getFree_no()}'">
				
		</form>
	
	
	</div>
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
