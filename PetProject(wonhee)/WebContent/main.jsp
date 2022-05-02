<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

    <div align="center">
      <hr width="65%" color="gray">
         <h3>쇼핑몰 메인 페이지</h3>
      <hr width="65%" color="gray">
      <br>
      
      <a href="<%=request.getContextPath() %>/member_login.do">[회원 로그인]</a>
      &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
      <a href="<%=request.getContextPath() %>/admin_login.do">[관리자 로그인]</a>
      
    
    </div>

</body>
</html>