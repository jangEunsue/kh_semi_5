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
      <hr width="30%" color="blue">
         <h3> 전체 회원 리스트</h3>
      <hr width="30%" color="blue">
      <br>
      
      <table border="1" cellspacing="0" width="450">
         <tr>
             <th>회원번호</th> <th>회원 아이디</th>
             <th>회원명</th> <th>가입일자</th>         
         </tr>
      
           <c:set var="list" value="${memberList }" />
           
           <c:if test="${!empty list }">
            <c:forEach items="${list }" var="dto">
               <tr>
                 <td> 
                 <a href="<%=request.getContextPath() %>/member_contend.do?num=${dto.getM_num() }">
                 ${dto.getM_num() }</a></td>
                 <td> ${dto.getM_id() }</td>
                 <td> ${dto.getM_name() }</td>
                 <td> ${dto.getM_regdate().substring(0,10) }</td>
               </tr>
            </c:forEach>
           </c:if>
           
       <c:if test="${empty list }">
         <tr> 
            <td colspan="4" align="center">
                <h3>검색된 회원이  없습니다....</h3>
            <td>  
         </tr>
       </c:if> 
       
       <tr>
          <td colspan="4" align="right">
              <input type="button"  value="회원등록"
                 onclick="location.href='admin_member_input.do'">
                
         </td>
       </tr>
      </table>
    
    </div>
    
     <jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>