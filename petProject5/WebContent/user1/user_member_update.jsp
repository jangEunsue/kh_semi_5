<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
</head>
<body>

  <div align="center">
      <hr width="65%" color="blue">
         <h3>테이블 제품 수정 폼 페이지</h3>
     <hr width="65%" color="blue">
    <br>
    <form method="post" 
       action="<%=request.getContextPath() %>/admin_member_update_ok.do">
     <c:set var="dto" value="${modify }"/>   
      <input type="hidden" name="m_pwd" value="${dto.getM_pwd() }">
      <input type="hidden" name="m_num" value="${dto.getM_num() }">
     <table border="1" cellspacing="0" width="300">
        
         <c:if test="${!empty dto }">
        <tr>
            <td>회원아이디</td>
            <td><input name="m_id"
                        value="${dto.getM_id() }" readonly> </td>
        </tr>
        
        <tr>
            <td>회원이름</td>
            <td><input name="m_name"
                        value="${dto.getM_name() }" readonly> </td>
        </tr>
        
        <tr>
            <td>회원생일</td>
            <td><input name="m_birth"
                        value="${dto.getM_birth().substring(0,10)}" readonly> </td>
        </tr>
        
        <tr>
            <td>회원이메일</td>
            <td><input name="m_email"
                        value="${dto.getM_email() }" > </td>
        </tr>
        
        <tr>
            <td>회원연락처</td>
            <td><input name="m_phone"
                        value="${dto.getM_phone() }"> </td>
        </tr>
        
        <tr>
            <td>회원주소</td>
            <td><input name="m_addr"
                        value="${dto.getM_addr() }" > </td>
        </tr>
        
        <tr>
            <td>회원마일리지</td>
            <td><input name="m_mileage"
                        value="${dto.getM_mileage() }" > </td>
        </tr>
        
        <tr>
            <td>회원등록일</td>
            <td><input name="m_regdate"
                        value="${dto.getM_regdate().substring(0,10) }" readonly> </td>
        </tr>
        </c:if>
        
        <c:if test="${empty dto }">
                 <tr>
                    <td colspan="2" align="center">
                    <h3>검색된  회원에 대한 정보가 없습니다.</h3>
                   </td>
                   </tr>
        </c:if>
          
         <tr>
         <td colspan="2" align="center">
            <input type="submit" value="글수정">&nbsp;&nbsp;&nbsp;
            <input type="reset" value="다시작성">
            </td>
       </tr>
         
        
     
     </table>
     
  </form>
  
  </div>



</body>
</html>
