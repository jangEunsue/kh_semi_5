<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

th{
width:10%
}

</style>
</head>
<body>

	<div align="center">
		<c:set var="dto" value="${Cont }"/>
	<h3>${dto.getFree_writer()}님 게시글 페이지</h3>
		
		<table style="text-align: left; border:1px solid #dddddd; padding:100;" width="700">
			<tr>
				<th>글제목</th>
				<td>${dto.getFree_title() }</td>
			</tr>
			
			<tr>
				<th>글쓴이</th>
				<td>${dto.getFree_writer() }</td>
			</tr>
			
			<tr>
				<th>글내용</th>
				<td><textarea rows="7" cols="70" readonly>${dto.getFree_cont() }</textarea></td>
			</tr>
		
			<tr>
				<th>비밀번호</th>
				<td><c:if test="${!empty dto.getFree_pwd() }">
					<c:forEach begin="1" end="${dto.getFree_pwd().length() }">
					*
					</c:forEach>
				</c:if>
			</tr>
			
			<tr>
				<c:if test="${empty dto.getFree_update() }">
				<th>작성일자</th>
				<td>${dto.getFree_date() }</td>
				<td>조회 : ${dto.getFree_hit() }</td>
				</c:if>
				
				<c:if test="${!empty dto.getFree_update() }">
					<th>수정일자</th>
					<td>${dto.getFree_update() }</td>
				</c:if>
			</tr>
			
			
			<c:if test="${empty dto }">
				<tr>
					<td colspan="2" align="center">
						<h3>검색된 게시물이 없습니다</h3>
				</tr>
			</c:if>
			
			<tr>
				<td colspan="3" align="center">
				<input type="button" value="수정" onclick="location.href='free_update.do?no=${dto.getFree_no()}'">&nbsp;
				<input type="button" value="삭제" onclick="if(confirm('게시글을 삭제하시겠습니까?')){
					location.href='free_delete.do?no=${dto.getFree_no() }'
				}else {return;}">&nbsp;
				<input type="button" value="답글" onclick="location.href='free_reply.do?no=${dto.getFree_no()}'">&nbsp;
				<input type="button" value="전체목록" onclick="location.href='free_list.do'">
				</td>
			</tr>
		</table>
	
	</div>
</body>
</html>