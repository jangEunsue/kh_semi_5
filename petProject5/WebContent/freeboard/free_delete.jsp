<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<br>
			<h3 id="freeDeleteH2">게시글 비밀번호 확인</h3>
		<br>
		
		<form method="post" action="<%=request.getContextPath() %>/free_delete_ok.do">
		<input type="hidden" name="free_no" value="${param.no }">
		<table class="freeDeleteTable">
			<tr>
			<th id="freeDeleteTh" >삭제할 게시글 비밀번호</th>
			<td class="freeContTd"><input type="password" name="pwd" class="freeInput" ></td>
			</tr>
		</table>

				<input type="submit" class="freeDeleteBtn"value="글삭제">&nbsp;&nbsp;&nbsp;
				<input type="reset"class="freeDeleteBtn" value="취소" onclick="location.href='free_list.do'" >
	</form>
	
	</div>
	
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
