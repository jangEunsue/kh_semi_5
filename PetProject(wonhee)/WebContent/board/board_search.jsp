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
	   <hr width="30%" color="red">
	      <h3>게시물 검색 리스트 페이지</h3>
	   <hr width="30%" color="red">
	   <br>
	   
	   <table border="1" cellspacing="0" width="400">
	      <tr>
	         <th>글번호</th> <th>글제목</th>
	         <th>조회수</th> <th>작성일자</th>
	      </tr>
	      
	      <c:set var="list" value="${List }" />
	      <c:if test="${!empty list }">
	         <c:forEach items="${list }" var="dto">
	            <tr>
	               <td> ${dto.getFree_no() } </td>
	               <td> ${dto.getFree_title() } </td>
	               <td> ${dto.getFree_hit() } </td>
	               <td> ${dto.getFree_date().substring(0, 10) } </td>
	         	</tr>
	         </c:forEach>
	      </c:if>
	      
	      <c:if test="${empty list }">
	         <tr>
	            <td colspan="4" align="center">
	               <h3>검색된 게시물 리스트가 없습니다.....</h3>
	            </td>
	         </tr>
	      </c:if>
	      
	   </table>
	   
	   <br>
	   
	   <%-- 검색 페이징 처리 --%>
	   <c:if test="${page > block }">
	      <a href="board_search.do?page=1&search_field=${search_field }&search_keyword=${search_keyword}">[맨처음]</a>
	      <a href="board_search.do?page=${startBlock -1 }&search_field=${search_field }&search_keyword=${search_keyword}">◀</a>
	   </c:if>
	   
	   <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
	   
	      <c:if test="${i == page }">
	         <b><a href="board_search.do?page=${i }&search_field=${search_field }&search_keyword=${search_keyword}">[${i }]</a></b>
	      </c:if>
	      
	      <c:if test="${i != page }">
	         <a href="board_search.do?page=${i }&search_field=${search_field }&search_keyword=${search_keyword}">[${i }]</a>
	      </c:if>
	      
	   </c:forEach>
	   
	   <c:if test="${endBlock < allPage }">
	      <a href="board_search.do?page=${endBlock + 1 }&search_field=${search_field }&search_keyword=${search_keyword}">▶</a>
	      <a href="board_search.do?page=${allPage }&search_field=${search_field }&search_keyword=${search_keyword}">[마지막]</a>
	   </c:if>
	   
	   <br> <br>
	   
	   <input type="button" value="전체목록"
	      onclick="location.href='board_list.do?page=1'">
	   
	</div>

</body>
</html>