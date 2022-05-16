<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
<link rel="stylesheet" type="text/css" href="css/free.css">

</head>
<body>
<jsp:include page="../inc/pet_top.jsp" />
	<div align="center">
		<c:set var="dto" value="${Cont }"/>
	<h3 id="freeContH3">${dto.getFree_writer()}님 게시글 페이지</h3>
		
		<table class="freeContTable">
			<tr>
				<th class="freeContTh">글제목</th>
				<td class="freeContTd">${dto.getFree_title() }</td>
			</tr>
			
			<tr>
				<th class="freeContTh">글쓴이</th>
				<td class="freeContTd">${dto.getFree_writer() }</td>
			</tr>
			
			<tr>
				<th class="freeContTh">글내용</th>
				<td class="freeContTd"><textarea id="freeContText" rows="10" readonly>${dto.getFree_cont() }</textarea></td>
			</tr>
		
			<tr>
				<th class="freeContTh">비밀번호</th>
				<td class="freeContTd"><c:if test="${!empty dto.getFree_pwd() }">
					<c:forEach begin="1" end="${dto.getFree_pwd().length() }">
					*
					</c:forEach>
				</c:if>
			</tr>
			
			<tr>
				<c:if test="${empty dto.getFree_update() }">
				<th class="freeContTh">작성일자</th>
				<td class="freeContTd">${dto.getFree_date() } &emsp;
				조회수 : ${dto.getFree_hit() }</td>
				</c:if>
				
				<c:if test="${!empty dto.getFree_update() }">
					<th class="freeContTh">수정일자</th>
					<td class="freeContTd">${dto.getFree_update() }</td>
				</c:if>
			</tr>
			
			
			<c:if test="${empty dto }">
				<tr>
					<td colspan="2" align="center">
						<h3>검색된 게시물이 없습니다</h3>
				</tr>
			</c:if>
		</table>
			
			<div class="freeContBtnWrap">
				<input type="button" class="freeContBtn" value="수정" onclick="location.href='free_update.do?no=${dto.getFree_no()}'">&nbsp;&nbsp;
				<input type="button" class="freeContBtn" value="삭제" onclick="if(confirm('게시글을 삭제하시겠습니까?')){
					location.href='free_delete.do?no=${dto.getFree_no() }'
				}else {return;}">&nbsp;&nbsp;
				<input type="button" class="freeContBtn" value="답글" onclick="location.href='free_reply.do?no=${dto.getFree_no()}'">&nbsp;&nbsp;
				<input type="button" class="freeContBtn" value="전체목록" onclick="location.href='free_list.do'">
			</div>
	</div>
	<jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>
