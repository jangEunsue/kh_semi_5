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
	<jsp:include page="../include/admin_top.jsp" />

            <div id="sub_contents" align="center">
            
                <div id="board_wrap">
                    <c:set var="dto" value="${Cont }"></c:set>
					<table border="" cellspacing="0" width="550">
						<tr>
				        	<th>글제목</th>
				        	<td> ${dto.getQA_title() } </td>
				      	</tr>
						<tr>
				         	<th>작성자</th>
				         	<td> ${dto.getQA_writer() } </td>
				      	</tr>
				      
				      	<tr>
				         	<c:if test="${empty dto.getQA_update() }">
				            	<th>작성일자</th>
				         		<td> ${dto.getQA_date().substring(0,10) } </td>
				         	</c:if>
				         
				         	<c:if test="${!empty dto.getQA_update() }">
				            	<th>수정일자</th>
				         		<td> ${dto.getQA_update() } </td>
				         	</c:if>
				      	</tr>
				      
				      	<tr>
				         	<th>글내용</th>
				         	<td> 
				            	<textarea readonly>${dto.getQA_cont() }</textarea>
				         	</td>
				      	</tr>

				      	<c:if test="${empty dto }">
							<tr>
								<td colspan="2">검색된 게시물이 없습니다.</td>
							</tr>
						</c:if>
					</table>
					
					
					<br>
					<table border="0" cellspacing="0" width="100%">
						<tr>
							<td  align="center">
								<%
									String id = (String)session.getAttribute("sessionID");
								%>				
				                <input type="button" value="답변글"
	                                 onclick="location.href='pet_QA_reply.do?no=${dto.getQA_no()}'">
				            	<input type="button" value="삭제"
				               		onclick="if(confirm('게시글을 삭제하시겠습니까?')) {
				            	   			 	location.href='pet_QA_delete.do?no=${dto.getQA_no() }&page=${page }'
				               				}else{ return; }">
				               	<input type="button" value="목록" onclick="location.href='boardqa_list.do'">			
							</td>
						</tr>
					</table>
                </div>
                    
            </div>

</body>
</html>