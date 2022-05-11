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
    
            <p class="sub_title">질문과 답변 글 수정하기 <span class="sub_title2">QnA</span></p>
            
            <!-- 본문 시작 -->
            <div id="sub_contents">
                <div id="board_wrap">
                	<c:set var="dto" value="${modify }" />
					<form method="post" action="<%=request.getContextPath() %>/pet_QA_update_ok.do">
						<input type="hidden" name="userId" value="${dto.getQA_userID() }">
					 	<input type="hidden" name="QA_no" value="${dto.getQA_no() }">
					 	<input type="hidden" name="page" value="${page }">
					 	
						<table border="0" cellspacing="0" width="100%">
							<tr>
					         	<th>글 번호</th>
					         	<td> ${dto.getQA_no() } </td>
					      	</tr>
							<tr>
								<th>작성자</th>
								<td>
									<input type="text" name="writer" 
										value="${dto.getQA_writer() }" readonly>
								</td>
							</tr>
							<tr>
								<th>글제목</th>
								<td>
									<input type="text" name="title" 
										value="${dto.getQA_title() }">
								</td>
							</tr>
							<tr>
								<th>글내용</th>
								<td>
									<textarea name="content">
										${dto.getQA_cont() }
									</textarea>
								</td>
							</tr>

							<c:if test="${empty dto }">
								<tr>
									<td colspan="2">
										게시물을 불러올 수 없습니다.
									</td>
								</tr>
							</c:if>
							
							<tr>
								<td align="center" colspan="2" class="board_btn">
									<input type="submit" value="수정">&nbsp;&nbsp;
									<input type="button" value="목록" onclick="location.href='pet_QA.do?page=${page }'">
								</td>
							</tr>
						
						</table>
					
					</form>
                </div>
                    
            </div>
    
        </div>
        <div class="clear"></div>
    </div sub_wrap>
    <jsp:include page="../inc/pet_bottom.jsp" />
</body>
</html>