<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.updateTable{

padding: 20px;
border: 1px solid #bcbcbc;
background-color:#E9E1D4;
}

th{

padding:5px;

}
textarea {
	width: 100%;
    box-sizing: border-box;
    resize: none;
    padding: 10px 16px;
    border: none;
    outline: none;
    font-family: sans-selif; 
}


</style>
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />
	<div align="center">
		<c:set var="dto" value="${update }"/>
		<h3>${dto.getFree_writer() }님 게시글 수정 페이지</h3>
		<br>
		<br>
		
		<form method="post" action="<%=request.getContextPath() %>/free_update_ok.do">
		<input type="hidden" name="free_no" value="${dto.getFree_no() }">
		<table class="updateTable" cellspacing="0">
			
			
			<tr>
				<th>글쓴이</th>
				<td><input name="writer" value="${dto.getFree_writer() }" readonly></td>
			</tr>
			
			<tr>
				<th>제목</th>
				<td><input name="title" value="${dto.getFree_title() }" size=98></td>
			</tr>		

			<tr>
				<th>글내용</th>
				<td><textarea rows="10" cols="100" name="content">${dto.getFree_cont() }</textarea>
				</td>
			</tr>

			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd"></td>
			</tr>
			
			<tr>
				<td colspan="5" align="right">
				<input type="submit" value="수정">&nbsp;&nbsp;&nbsp;
				<input type="button" value="이전으로" onclick="location.href='free_content.do?no=${dto.getFree_no()}'">
				
				</td>
			</tr>
		</table>
		</form>
	
	
	</div>
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>