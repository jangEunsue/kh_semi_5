<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
<style type="text/css">
 
 ul li {
  list-style: none;
  text-align: center;
 }
 
</style>
</head>
<body>

   <jsp:include page="../include/admin_top.jsp" />

<div class="main_right">
	
		<div class="main_box">
			<h3>주문관리</h3><span class="menu_direct"><a href="<%=request.getContextPath()%>/admin_order_mg.do">바로가기</a></span>
			<table class="order box_table">
			
				<tr>
					<th>배송전</th> <th>배송중</th> <th>배송완료</th> <th>결제전</th> <th>결제완료</th>
				</tr>
				<tr>
					<td>${del_b}</td><td>${del_i}</td><td>${del_a}</td>
					<td>${pay_b}</td><td>${pay_a}</td>
				</tr> 
			
			</table>

		</div>
		
		
		
		<div class="main_box">
			<h3>상품관리</h3><span class="menu_direct"><a href="<%=request.getContextPath()%>/admin_product_list.do">바로가기</a></span>
			<table class="order box_table">
			
				<tr>
					<th>재고관리</th> <th></th>
				</tr>
				<tr>
					<td></td>
				</tr> 
			
			</table>

		</div>
		
		<div class="main_box">
			<h3>게시글관리</h3><span class="menu_direct"><a href="<%=request.getContextPath()%>/admin_board_list.do">바로가기</a></span>
			<table class="order box_table">
			
				<tr>
					<th>자유게시판</th> <th>Q&A</th>
				</tr>
				<tr>
					<td></td>
				</tr> 
			
			</table>

		</div>
		
		<div class="main_box">
			<h3>매출관리</h3><span class="menu_direct"><a href="<%=request.getContextPath()%>/admin_sales_list.do">바로가기</a></span>
			<table class="order box_table">
			
				<tr>
					<th>총매출</th> <th></th>
				</tr>
				<tr>
					<td></td>
				</tr> 
			
			</table>

		</div>
			
	</div>
  
   <jsp:include page="../include/admin_bottom.jsp" />
   
</body>
</html>