<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
th{
background-color:#F5DDAD;

}

</style>
</head>
<body>

<div align="center">
		<hr width="40%" color="lightgray">
			<h3>자유 게시판 글쓰기 페이지</h3>
		<hr width="40%" color="lightgray">
		<br>
		
		<form method="post" action="<%=request.getContextPath()%>/free_write_ok.do">
		
		<table border="1" cellspacing="0" width="800">
			<tr>
				<th>작성자</th>
				<td><input name="writer"></td>
			</tr>
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
</body>
</html>