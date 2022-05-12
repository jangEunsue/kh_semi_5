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
	<jsp:include page="../inc/pet_top.jsp" />
    
    <div id="sub_wrap" class="webfont">
        <div id="aside">
            <div class="left_title">
                <p class="big_title">고객센터</p>
                <p class="small_title">QnA</p>
                <p class="bl_lt">▼</p>
            </div>
            <div class="mid_nav">
                <ul class="mid_menu">
                    <li><a href="#"><i class="fa fa-caret-right"></i>공지사항</a></li>
                    <li><a href="<%=request.getContextPath() %>/pet_QA.do" class="nav_on"><i class="fa fa-caret-right"></i>Q&A</a></li>
                </ul>
            </div>
        </div>
      
      
        <div id="section">
    
            <div class="page_count_bg"> 
                <div id="page_count" class="clearfix">
                    <ul>
                        <li><i class="fa fa-home"></i> Home</li>
                        <li><i class="fa fa-home"></i> 고객센터</li>
                        <li> <i class="fa fa-angle-right"></i> <strong>QnA</strong></li>
                    </ul>
                </div>
            </div>
    
            <p class="sub_title">질문과 답변<span class="sub_title2">QnA</span></p>
            
            <!-- 본문 시작 -->
            <div id="sub_contents">
            
                <div id="board_wrap">
                    <c:set var="dto" value="${Cont }"></c:set>
					<table border="0" cellspacing="0" width="100%">
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
				         	<td class="board_cont"> 
				            	<textarea readonly>${dto.getQA_cont() }</textarea>
				         	</td>
				      	</tr>

				      	<c:if test="${empty dto }">
							<tr>
								<td colspan="2">검색된 게시물이 없습니다.</td>
							</tr>
						</c:if>
						
						<tr>
							<td align="right" colspan="2" class="board_btn">
								<%
									String id = (String)session.getAttribute("sessionID");
								%>
								<input type="button" value="글쓰기"
					                   onclick="location.href='pet_QA_write.do?id=<%=id %>&page=${page }'">
								<input type="button" value="수정"
				              		onclick="location.href='pet_QA_update.do?no=${dto.getQA_no() }&page=${page }'">
				            	<input type="button" value="삭제"
				               		onclick="if(confirm('게시글을 삭제하시겠습니까?')) {
				            	   			 	location.href='pet_QA_delete.do?no=${dto.getQA_no() }&page=${page }'
				               				}else{ return; }">
							</td>
						</tr>
						<tr>
							<td align="center" colspan="2" class="board_btn">
								<input type="button" value="목록" onclick="location.href='pet_QA.do?page=${page }'">
							</td>
						</tr>
						
					</table>
					
					
					<br>
					<table border="0" cellspacing="0" width="100%">
						
					</table>
                </div>
                    
            </div>
    
        </div>
        <div class="clear"></div>
    </div sub_wrap>
    <jsp:include page="../inc/pet_bottom.jsp" />

</body>
</html>