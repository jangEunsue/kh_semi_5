<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
                    <li><a href="<%=request.getContextPath() %>/pet_qna_list.do" class="nav_on"><i class="fa fa-caret-right"></i>QnA</a></li>
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
                    <form method="post" action="<%=request.getContextPath() %>/pet_qna_write_ok.do">
                        <table border="0" cellspacing="0" width="100%" class="table write_table">
                            <tr>
                                <th>글제목</th>
                                <td><input class="type_text" name="title"></td>
                            </tr>
                            <%  if(session.getAttribute("sessionId")==null){ %>
                                    <tr>
                                        <th>작성자</th>
                                        <td>
                                            <input class="type_text" name="writer">
                                        </td>
                                    </tr>
                            <%  } %>
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
                                <th>비밀번호</th>
                                <td><input type="password" name="pwd"></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <input type="submit" value="글쓰기">&nbsp;&nbsp;
                                    <input type="button" value="목록" onclick="location.href='pet_qna_list.do?page=${page }'">
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