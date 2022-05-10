<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
textarea {
	width: 100%;
    box-sizing: border-box;
    resize: none;
    padding: 10px 16px;
    border: none;
    outline: none;
    font-family: Noto Sans, sans-selif; 
}


</style>
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />
<div align="center">
		<c:set var="dto" value="${reply}"/>
			<h3>${dto.getFree_writer() }님에 대한 답글</h3>
		<br>
		
		<form method="post" action="<%=request.getContextPath()%>/free_reply_ok.do">
		
		<input type="hidden" name="userId" value="${userId }">
		<input type="hidden" name="free_no" value="${dto.getFree_no() }">
		<input type="hidden" name="free_group" value="${dto.getFree_group() }">
		<input type="hidden" name="free_step" value="${dto.getFree_step() }">
		<input type="hidden" name="free_indent" value="${dto.getFree_indent() }">
		
		<table border="1" cellspacing="0" width="800">
			<tr>
				<th>작성자</th>
				<td><input name="re_writer"></td>
			</tr>
			<tr>
				<th>글제목</th>
				<td><input name="re_title" size=98 value="Re : ${dto.getFree_title() }"></td>
			</tr>
		
			<tr>
				<th>글내용</th>
				<td><textarea rows="10" cols="100" name="re_content"></textarea></td>
			</tr>
		
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="re_pwd"></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="답글쓰기">&nbsp;&nbsp;&nbsp;
					<input type="button" value="이전으로" onclick="location.href='free_content.do?no=${dto.getFree_no()}'">
				</td>
			</tr>
		
		</table>
		
		</form>
	</div>
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>