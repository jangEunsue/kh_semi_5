<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    font-family: sans-selif; 
}


</style>
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />
<div align="center">
		<hr width="40%" color="lightgray">
			<h3>자유 게시판 글쓰기 페이지</h3>
		<hr width="40%" color="lightgray">
		<br>
		
		<form method="post" action="<%=request.getContextPath()%>/free_write_ok.do">
		
		<input type="hidden" name="userId" value="userId">
		<table border="1" cellspacing="0" width="800">
		<c:set var="pm" value="${memberList }"/>
			
			<tr>
				<th>작성자</th>
				<td>
				<input name="writer" value="${pm.getM_name() }" readonly>
				
				</td>
			
			<tr>
				<th>글제목</th>
				<td><input name="title" size=98></td>
			</tr>
		
			<tr>
				<th>글내용</th>
				<td><textarea rows="10" cols="100" name="content"></textarea></td>
			</tr>
		
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd"></td>
			</tr>
			

			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="글쓰기">&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시작성">
				</td>
			</tr>
		
		</table>
		
		</form>
	</div>
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>