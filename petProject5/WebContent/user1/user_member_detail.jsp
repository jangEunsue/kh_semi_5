<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
</head>
<body>

   <jsp:include page="../include/admin_top.jsp"></jsp:include>
   <br>
   
   <div align="center">
	   <c:set var="dto" value="${memberCont }" />
	   <hr width="30%" color="blue">
	      <h3> ${dto.getM_name() } 님의 상세 내역</h3>
	   <hr width="30%" color="blue">
	   <br> <br>

      <table border="1" cellspacing="0" width="400">
       <tr>
         <th>회원번호 : </th>
         <td> ${dto.getM_num() }</td>
       </tr>

	   <tr>
         <th>회원아이디 : </th>
         <td> ${dto.getM_id() } </td>
       </tr>

	   <tr>
         <th>회원이름 : </th>
         <td> ${dto.getM_name() } </td>
       </tr>

	   <tr>
         <th>회원생일 : </th>
         <td> ${dto.getM_birth().substring(0,10) } </td>
       </tr>

	   
	   <tr>
         <th>회원이메일 : </th>
         <td> ${dto.getM_email() } </td>
       </tr>

	   <tr>
         <th>회원연락처 : </th>
         <td> ${dto.getM_phone() }</td>
       </tr>


	   
	   <tr>
         <th>회원주소 : </th>
         <td> ${dto.getM_addr() }</td>
       </tr>

       <tr>
	     <th>회원 마일리지 : </th>
	     <td>${dto.getM_mileage() }포인트</td>
	 </tr>
	 
	  <tr>
         <th>회원등록일 : </th>
         <td> ${dto.getM_regdate().substring(0,10)} </td>
       </tr>
       
      <c:if test="${empty dto }">
	         <tr>
	            <td colspan="2" align="center">
	               <h3>검색된 게시물이 없습니다.....</h3>
	            </td>
	         </tr>
	      </c:if>
	      
	      <tr>
	         <td colspan="2" align="center">
	            <input type="button" value="회원 수정"
	               onclick="location.href='admin_update.do?num=${dto.getM_num() }'">
	            <input type="button" value="회원삭제"
	               onclick="if(confirm('정말로 삭제하시겠습니까?')) {
	            	   			location.href='admin_member_delete.do?num=${dto.getM_num() }'
	               			}else{ return; }">
	            <input type="button" value="전체 회원 목록"
	               onclick="location.href='admin_member_list.do'">
	      
	         </td>
	      </tr> 
       </table>
       
       <br><br>
       <jsp:include page="../include/admin_bottom.jsp"></jsp:include>
     </tr>
   </table>
   
   </div>

</body>
</html>
