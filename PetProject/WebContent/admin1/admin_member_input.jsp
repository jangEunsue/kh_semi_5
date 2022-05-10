<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
</head>
<body>

    <jsp:include page="../include/admin_top.jsp"/>
    
    <div align="center">
       <hr width="65%" color="blue">
       <h3>회원 등록 화면</h3>
     <hr width="65%" color="blue">
      <br>
      
      <form method="post" 
            action="<%=request.getContextPath() %>/admin_member_input_ok.do">
      
      <table border="1" cellspacing="0" width="400">
      
         <tr>
            <th>회원 아이디</th>
            <td> <input name="m_id"></td>  
         </tr>
         
         <tr>
            <th>회원 비밀번호</th>
            <td> <input name="m_pwd"></td>  
         </tr>
         
         <tr>
            <th>회원 이름</th>
            <td> <input name="m_name"></td>  
         </tr>
         
         <tr>
            <th>회원 생일</th>
            <td> <input name="m_birth"></td>  
         </tr>
         
         <tr>
            <th>회원 이메일</th>
            <td> <input name="m_email"></td>  
         </tr>
         
         <tr>
            <th>회원 연락처</th>
            <td> <input name="m_phone"></td>  
         </tr> 
         
         <tr>
            <th>회원 주소</th>
            <td> <input name="m_addr"></td>  
         </tr>
         
         <tr>
            <th>회원 마일리지</th>
            <td> <input name="m_mileage"></td>  
         </tr>

          <tr>
            <td colspan="2" align="center"> 
            <input type="submit" value="회원등록">&nbsp;&nbsp;&nbsp;
            <input type="reset"  value="다시작성">        
           </td>  
         </tr>
      </table>
      
      </form>     
      
    </div>

     <jsp:include page="../include/admin_bottom.jsp"/>
     
</body>
</html>