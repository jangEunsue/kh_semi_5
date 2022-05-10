<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />
	<div align="center">
	<br>
			<h3>비밀번호 확인</h3>
		<br>
		
		<form method="post" action="<%=request.getContextPath() %>/free_delete_ok.do">
		<input type="hidden" name="free_no" value="${param.no }">
		<table border="1" cellspacing="0" width="400">
			<tr>
			<th>삭제할 게시글 비밀번호</th>
			<td><input type="password" name="pwd"></td>
			</tr>
			
			<tr>
			<td colspan="2" align="center">
				<input type="submit" value="글삭제">&nbsp;&nbsp;&nbsp;
				<input type="reset" value="취소">
			</tr>
		</table>
	</form>
	
	</div>
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>