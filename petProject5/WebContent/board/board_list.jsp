<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
<style type="text/css">
h2{

margin:20;

}
 table {
        width: 70%;
        border: 1px solid #444444;
        border-collapse: collapse;
      }
      
 th, td {
   border-bottom: 1px solid #444444;
   padding: 10px;

 }
      
 th{
 
 background-color: #E9E1D4;
 text-align: center;
 
 }


#writeBtn{

margin: 0px;
float: ri;
size: 50px;

}

</style>
</head>
<body>
  
   <jsp:include page="../include/admin_top.jsp" />

  <div align="center">
	   <br>
	   
	   <table border="1" cellspacing="0" width="650">
	      <tr>
			<th width="10%">No.</th>
			<th width="40%">글제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="20%">작성일자</th>
			</tr>
	      
	      <c:set var="list" value="${List }" />
	      <c:if test="${!empty list }">
	         <c:forEach items="${list }" var="dto">
	            <tr>
	               <td> ${dto.getFree_no() } </td>
	               <td> 
	                  <%-- 댓글인 경우 --%>
	                  <c:if test="${dto.getFree_indent() != 0 }">
	                     <c:forEach begin="1" end="${dto.getFree_indent() }">
	                     		☞
	                     </c:forEach>
	                  </c:if>
	                  
	                  <a href="<%=request.getContextPath() %>/admin_free_content.do?no=${dto.getFree_no() }">
	               				${dto.getFree_title() } </a>
	               </td>
	               <td> ${dto.getFree_writer() } </td>
	               <td> ${dto.getFree_hit() } </td>
	               <td> ${dto.getFree_date().substring(0, 10) } </td>
	            </tr>
	         </c:forEach>
	      </c:if>
	      
	      <c:if test="${empty list }">
	         <tr>
	            <td colspan="7" align="center">
	               <h3>검색된 게시물이 없습니다.....</h3>
	         	</td>
	         </tr>
	      </c:if>
	      
	      </table>
	      <div id="writeBtn">
	         <td colspan="7" align="right">
	            <input type="button" value="글쓰기"
	               onclick="location.href='admin_free_write.do'">
	      	 </td>
	      </div>
	   
	   
	   <br>

	   
	   <c:if test="${page > block }">
	      <a href="admin_board_list.do?page=1">◀◀</a>
	      <a href="admin_board_list.do?page=${startBlock -1 }">◀</a>
	   </c:if>
	   
	   <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
	   
	      <c:if test="${i == page }">
	         <b><a href="admin_board_list.do?page=${i }">[${i }]</a></b>
	      </c:if>
	      
	      <c:if test="${i != page }">
	         <a href="admin_board_list.do?page=${i }">[${i }]</a>
	      </c:if>
	      
	   </c:forEach>
	   
	   <c:if test="${endBlock < allPage }">
	      <a href="admin_board_list.do?page=${endBlock + 1 }">▶</a>
	      <a href="admin_board_list.do?page=${allPage }">▶▶</a>
	   </c:if>
	   
	   <br> <br>
	   
	   
	    <form method="post"
	      action="<%=request.getContextPath() %>/admin_board_search.do">
	      
	      <select name="search_field">
	         <option value="title">제목</option>
	         <option value="content">내용</option>
	         <option value="title_content">제목+내용</option>
	         <option value="writer">작성자</option>	      
	      </select>
	      
	      <input name="search_keyword">
	      <input type="submit" value="검색">
	   
	   </form>
	   
	</div>
	
 <jsp:include page="../include/admin_bottom.jsp" />

</body>
</html>
