<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<c:set var="dto" value="${reply}"/>
			<h3 id="freeContH3">${dto.getFree_writer() }님에 대한 답글</h3>
		<br>
		
		<form method="post" action="<%=request.getContextPath()%>/free_reply_ok.do">
		
		<input type="hidden" name="userId" value="${userId }">
		<input type="hidden" name="free_no" value="${dto.getFree_no() }">
		<input type="hidden" name="free_group" value="${dto.getFree_group() }">
		<input type="hidden" name="free_step" value="${dto.getFree_step() }">
		<input type="hidden" name="free_indent" value="${dto.getFree_indent() }">
		
		<table class="freeContTable">
			<tr>
				<th class="freeContTh">작성자</th>
				<td class="freeContTd"><input name="re_writer" class="freeInput"></td>
			</tr>
			<tr>
				<th class="freeContTh">글제목</th>
				<td class="freeContTd"><input name="re_title" class="freeInput" size=98 value="Re : ${dto.getFree_title() }"></td>
			</tr>
		
			<tr>
				<th class="freeContTh">글내용</th>
				<td class="freeContTd"><textarea id="freeContText" rows="10" name="re_content"></textarea></td>
			</tr>
		
			<tr>
				<th class="freeContTh">비밀번호</th>
				<td class="freeContTd"><input type="password" class="freeInput" name="re_pwd"></td>
			</tr>
			
		</table>
			<div>
					<input type="submit" class="freeContBtn" value="답글쓰기">&nbsp;&nbsp;&nbsp;
					<input type="button" class="freeContBtn" value="이전으로" onclick="location.href='free_content.do?no=${dto.getFree_no()}'">
			</div>	
		
		
		</form>
	</div>
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
