<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 <jsp:include page="../include/admin_top.jsp" />

   <div align="center">
     <c:set var="dto" value="${modify }" />
	   <hr width="30%" color="gray">
	      <h3> ${dto.getFree_writer() } 님 게시물 수정 폼 페이지</h3>
	   <hr width="30%" color="gray">
	   <br>
      
      <form method="post"
	      action="<%=request.getContextPath() %>/admin_free_update_ok.do">
	      
	      <input type="hidden" name="free_no" value="${dto.getFree_no() }">
	      <table border="1" cellspacing="0" width="400">
	         <tr>
	            <th>작성자</th>
	            <td> <input name="writer"
	                     value="${dto.getFree_writer() }" readonly> </td>
	         </tr>
	         
	         <tr>
	            <th>글제목</th>
	            <td> <input name="title"
	                      value="${dto.getFree_title() }"> </td>
	         </tr>
	         
	         <tr>
	            <th>글내용</th>
	            <td>
	               <textarea rows="7" cols="30" name="content">${dto.getFree_cont() }</textarea>
	            </td>
	         </tr>
	         
	         <tr>
	         	<th>비밀번호</th>
	         	<td> <input type="password" name="pwd"> </td>
	         </tr>
	         
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
