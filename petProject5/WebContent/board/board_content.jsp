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
	   <c:set var="dto" value="${Cont }" />
	   <hr width="30%" color="marmoon">
	      <h3>${dto.getFree_writer() } 님 자유게시판 상세 내역</h3>
	   <hr width="30%" color="marmoon">
	   <br>
	   
	   <table border="1" cellspacing="0" width="400">
	      <tr>
	         <th>작성자</th>
	      	 <td> ${dto.getFree_writer() } </td>
	      </tr>
	      
	      <tr>
	         <th>글제목</th>
	      	 <td> ${dto.getFree_title() } </td>
	      </tr>
	      
	      <tr>
	         <th>글내용</th>
	      	 <td>
	      	    <textarea rows="7" cols="25" readonly>${dto.getFree_cont() }</textarea>
	         </td>
	      </tr>
	      
	      <tr>
	         <th>비밀번호</th>
	         <td>
	            <c:if test="${!empty dto.getFree_pwd() }">
	               <c:forEach begin="1" end="${dto.getFree_pwd().length() }">
	               				*
	               </c:forEach>
	            </c:if>
	         </td>
	      </tr>
	   
	   	  <tr>
	         <th>조회수</th>
	      	 <td> ${dto.getFree_hit() } </td>
	      </tr>
	      
	      <tr>
	         <c:if test="${empty dto.getFree_update() }">
	            <th>작성일자</th>
	            <td> ${dto.getFree_date().substring(0,10) } </td>
	         </c:if>
	      
	         <c:if test="${!empty dto.getFree_update() }">
	            <th>수정일자</th>
	            <td> ${dto.getFree_update().substring(0,10) } </td>
	         </c:if>
	      </tr>
	      
	      <c:if test="${empty dto }">
	         <tr>
	            <td colspan="2" align="center">
	               <h3>검섹된 게시물이 없습니다.....</h3>
	            </td>
	         </tr>
	      </c:if>
	      
	      <tr>
	         <td colspan="2" align="center">
	            <input type="button" value="글수정"
	               onclick="location.href='admin_board_update.do?no=${dto.getFree_no()}'">
	      
	            <input type="button" value="글삭제"
	               onclick="if(confirm('게시글을 삭제하시겠습니까?')) {
	            	   			location.href='admin_board_delete.do?no=${dto.getFree_no()}'
	               			}else {  return;  }">
	      
	            <input type="button" value="답변글"
	               onclick="location.href='admin_board_reply.do?no=${dto.getFree_no()}'">
	      
	      		<input type="button" value="전체목록"
	               onclick="location.href='admin_board_list.do'">
	         </td>
	      </tr>
	   </table>
	
	</div>
	<br>
 <jsp:include page="../include/admin_bottom.jsp" />
</body>
</html>
