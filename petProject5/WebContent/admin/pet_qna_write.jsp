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
    
            <p class="sub_title">질문과 답변 글쓰기 <span class="sub_title2">QnA</span></p>
            
            <!-- 본문 시작 -->
            <div id="sub_contents">
            
                <div id="board_wrap">
                	<c:set var="dto" value="${Info }" />
                    <form method="post" action="<%=request.getContextPath() %>/pet_QA_write_ok.do" >
                    	<input type="hidden" name="userID" value="${dto.getM_id() }">
                    	<input type="hidden" name="page" value="${page }">
                        <table border="1" cellspacing="0" width="100%" class="table write_table">
                            <tr>
								<th>작성자</th>
								<td>
									<input type="text" name="writer" 
										value="${dto.getM_name() }" readonly>
								</td>
							</tr>
                            <tr>
                                <th>글제목</th>
                                <td><input class="type_text" name="title"></td>
                            </tr>
                            <tr>
                                <td colspan="2" class="emp"></td>
                            </tr>
                            <tr>
                                <th>글내용</th>
                                <td>
                                    <textarea name="content"></textarea>
                                </td>
                            </tr>

                            <tr>
                                <td align="center" colspan="2">
                                    <input type="submit" value="글쓰기">&nbsp;&nbsp;
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