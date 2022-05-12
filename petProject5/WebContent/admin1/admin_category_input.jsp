<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
<style type="text/css">

	th {
		padding: 8px;
	}
	
	#ptitle {
		text-align: left;
		margin-left: 20%;
		line-height: 10%;
		border-style: solid; 
		border-width: 0 0 0 8px; 
		padding: 12px; 
		word-break: break-all;
		border-color: #F1BCAE;
	}

	.pinputbtn {
		background-color: #F1BCAE;
		color: white;
		font-size: 15px;
		margin: 10px 20px 15px 0px;
		padding: 5px 10px 5px 10px;
	}
	
	.pinputtable {
		border: 1px solid #dddddd;  
		font-size: 15px;
	}
	
	.pinputsrc {
		border: 1px solid #dddddd;
		padding-left: 3px;
	}
	
	#pinputcont {
		margin-top: 7px;
		margin-bottom: 7px;
	}
	
</style>
</head>
<body>

<jsp:include page="../include/admin_top.jsp"/>

	<div align="center">
		<h5 id="ptitle">카테고리 등록</h5>
		<br>
		
		<form method="post" action="<%=request.getContextPath() %>/admin_category_input_ok.do">
			
			<table border="1" cellspacing="0" width="400" class="pinputtable">
			
				<tr>
					<th>카테고리 코드[8자리]</th>
					<td><input name="cart_code" class="pinputsrc"></td>
				</tr>
				<tr></tr>
				<tr>
					<th>카테고리 이름</th>
					<td><input name="cart_name" class="pinputsrc"></td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="등 록" class="pinputbtn">&nbsp;&nbsp;&nbsp;
						<input type="button" value="취 소" class="pinputbtn"
								onclick="history.back()">
					</td>
				</tr>
			
			</table>
		</form>
	</div>
	<br>
	
	<jsp:include page="../include/admin_bottom.jsp"/>


</body>
</html>
