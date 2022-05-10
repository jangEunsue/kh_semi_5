<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

   <jsp:include page="../include/user_top.jsp"/>

   <div align="center">
   
   <ul>
        <li> <a href="<%=request.getContextPath() %>/admin_cart_input.do">상품 카테고리 등록</a>
        <li> <a href="<%=request.getContextPath() %>/admin_cart_list.do">상품 카테고리 목록</a>
        <li> <a href="<%=request.getContextPath() %>/admin_product_input.do">상품 등록</a>
        <li> <a href="<%=request.getContextPath() %>/admin_product_input.do">상품 리스트</a>
     
     </ul>
     
     <ul>
         <li> <a href="<%=request.getContextPath() %>/admin_member_input.do">회원 등록</a>
         <li> <a href="<%=request.getContextPath() %>/admin_member_list.do">회원 전체 목록</a>
         
     
     </ul>
   
   
   </div>
</body>
</html>