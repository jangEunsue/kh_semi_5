<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
 
 ul li {
  list-style: none;
  text-align: center;
 }
 
</style>
</head>
<body>

   <jsp:include page="../include/admin_top.jsp" />

  <div align="center">
     
     <ul>
        <li> <a href="<%=request.getContextPath() %>/admin_cart_input.do">상품 카테고리 등록</a>
        <li> <a href="<%=request.getContextPath() %>/admin_cart_list.do">상품 카테고리 목록</a>
        <li> <a href="<%=request.getContextPath() %>/admin_product_input.do">상품 등록</a>
        <li> <a href="<%=request.getContextPath() %>/admin_product_input.do">상품 리스트</a>
     
     </ul>
     
     <ul>
        <li> <a href="<%=request.getContextPath() %>/admin_board_list.do"> 자유 게시판</a>
        <li> <a href="<%=request.getContextPath() %>/boardqa_list.do"> Q/A 게시판</a>
        <li> <a href="<%=request.getContextPath() %>/notice_list.do"> 공지사항 게시판</a>
    </ul>
     
     <ul>
         <li> <a href="<%=request.getContextPath() %>/admin_member_input.do">회원 등록</a>
         <li> <a href="<%=request.getContextPath() %>/admin_member_list.do">회원 전체 목록</a>
         
     
     </ul>
  
  
  </div>
   <jsp:include page="../include/admin_bottom.jsp" />
</body>
</html>