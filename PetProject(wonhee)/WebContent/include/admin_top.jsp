<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
     #title {
        float: right;
        margin-right: 300px;
        word-spacing: 10px;
        clear: both;
     }
     
     a {
       text-decoration: none;
     }
</style>
</head>
<body>

     <div align="center">
       <hr width="65%">
         <h2>관리자 페이지</h2>
         
          <div id="title">
             <a href="#">${adminName }관리자님 환영합니다.</a>
             <a href="<%=request.getContextPath() %>/admin_logout.do">로그아웃</a>                    
         </div>
         
         <br>
         
       <hr width="65%">
       
       <br>
       
       <table width="800">
          <tr>
            <td>
               <a href="<%=request.getContextPath() %>/admin_main.do">관리자 홈</a>
            </td>
            <td>
              <a href="<%=request.getContextPath() %>/admin_cart_input.do">카테고리 등록</a>
            </td>
            
            <td>
              <a href="<%=request.getContextPath() %>/admin_cart_list.do">카테고리 목록</a>
            </td>
            
            <td>
              <a href="<%=request.getContextPath() %>/admin_product_input.do">상품 등록</a>
            </td>
            
            <td>
              <a href="<%=request.getContextPath() %>/admin_product_list.do">상품 목록</a>
            </td>
            
            <td>
              <a href="<%=request.getContextPath() %>/admin_member_input.do">회원 등록</a>
            </td>
            <td>
              <a href="<%=request.getContextPath() %>/admin_member_list.do">회원 전체 목록</a>
            </td>
            
            <td>
              <a href="<%=request.getContextPath() %>/admin_board_list.do">게시판
               전체 목록</a>
            </td>
            
          </tr>
       </table>
     </div>

</body>
</html>