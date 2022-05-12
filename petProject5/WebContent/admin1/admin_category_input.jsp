<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
</head>
<body>

<jsp:include page="../include/admin_top.jsp"/>

	<div align="center">
		<hr width="70%" color="E9E1D4">
			<h3>카테고리 등록 폼 페이지</h3>
		<hr width="70%" color="E9E1D4">
		<br>
		
		<form method="post" action="<%=request.getContextPath() %>/admin_category_input_ok.do">
			
			<table border="1" cellspacing="0" width="500">
			
				<tr>
					<th>카테고리 코드[8자리]</th>
					<td><input name="cart_code"></td>
				</tr>
				<tr></tr>
				<tr>
					<th>카테고리 이름</th>
					<td><input name="cart_name"></td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="등록">&nbsp;&nbsp;&nbsp;
						<input type="button" value="취소"
								onclick="history.back()">
					</td>
				</tr>
			
			</table>
		</form>
	</div>
	
	<jsp:include page="../include/admin_bottom.jsp"/>


</body>
</html>
