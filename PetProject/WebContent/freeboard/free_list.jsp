<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#title{

text-align: left;

}
</style>
</head>
<body>

	<div align="center">
		<h2>자유게시판</h2>
		<br>
		<br>
		<table style="text-align: center; border:1px solid #dddddd " width="650">
			<tr>
			<th style="background-color: #E9E1D4; text-align: center;">No.</th>
			<th style="background-color: #E9E1D4; text-align: center;">글제목</th>
			<th style="background-color: #E9E1D4; text-align: center;">작성자</th>
			<th style="background-color: #E9E1D4; text-align: center;">조회수</th>
			<th style="background-color: #E9E1D4; text-align: center;">작성일자</th>
			</tr>
			
			<c:set var="list" value="${List }"/>
			<c:if test="${!empty list }">
			<c:forEach items="${list }" var="dto">
			<input type="hidden" value="${dto.getFree_indent() }">
				<tr>
					<td>${dto.getFree_no() }</td>
					<td id = "title">
					<c:if test="${dto.getFree_indent() != 0 }">
					<c:forEach begin="1" end="${dto.getFree_indent()}">
						┖
					</c:forEach>
					</c:if>
	
					<a href="<%=request.getContextPath() %>/free_content.do?no=${dto.getFree_no()}">
					${dto.getFree_title() }</a>
					 
					</td>
					
					
					<td>${dto.getFree_writer() }</td>
					<td>${dto.getFree_hit() }</td>
					<td>${dto.getFree_date().substring(0, 10) }</td>
					</tr>
			</c:forEach>
			
			</c:if>
			
			<c:if test="${empty list }">
				<tr>
					<td colspan="5" align="center">
					<h3>검색된 게시물이 없습니다..</h3>
					</td>
				</tr>
			</c:if>

			<tr>
				<td colspan="5" align="right">
				<input type="button" value="글쓰기" onclick="location.href='free_write.do'">
				</td>
			</tr>	
				
			</table>
			
			<br>
		
		<c:if test="${page > block }">
			<a href="free_list.do?page=1">◀◀</a>
			<!-- 현재 페이지의 시작 블럭 -->
			<a href="free_list.do?page=${startBlock -1 }">◀</a>
		</c:if>
		
		<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			
			<c:if test="${i == page }">
				<b><a href="free_list.do?page=${i }">[${i }]</a></b>
			</c:if>
			<c:if test="${i != page }">
				<a href="free_list.do?page=${i }">[${i }]</a>
			</c:if>
		</c:forEach>
	
		<c:if test="${endBlock < allPage }">
			<a href="free_list.do?page=${endBlock +1 }">▶</a>		
			<a href="free_list.do?page=${allPage }">▶▶</a>		
		</c:if>
		<br>
		<br>
		
		<form method="post" action="<%=request.getContextPath() %>/free_search.do">
			<select name="searchField">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="title_content">제목+내용</option>
				<option value="writer">작성자</option>
			</select>
			
			<input name="searchKeyword">
			<input type="submit" value="검색">
		</form>
	</div>
</body>
</html>