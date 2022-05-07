<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                    <li><a href="<%=request.getContextPath() %>/pet_login.do" class="nav_on"><i class="fa fa-caret-right"></i>로그인</a></li>
                    <li><a href="<%=request.getContextPath() %>/pet_join.do"><i class="fa fa-caret-right"></i>회원가입</a></li>
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
            
                <div id="table_wrap">
                    
                    <table border="1" cellspacing="0" width="400">
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일자</th>
                        </tr>
            
                        <c:set var="list" value="${List }" />
                        
                        <c:if test="${!empty list }">
                            <c:forEach items="${list }" var="dto">
                                <tr>
                                    <td align="center"> ${dto.getQA_no() }</td>
                                    <td>
                                        <a href="<%=request.getContextPath() %>/board_cont.do?no=${dto.getQA_no() }&page=${page }">
                                            ${dto.getQA_title() }
                                        </a>
                                    </td>
                                    <td> ${dto.getQA_writer() }</td>
                                    <td> ${dto.getQA_date().substring(0, 10) }</td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        
                        <c:if test="${empty list }">
                            <tr>
                                <td colspan="54"><h4>게시글이 없습니다.</h4></td>
                            </tr>
                        </c:if>
                        
                        <tr>
                            <td colspan="5" align="right">
                                <input type="button" value="글쓰기"
                                       onclick="location.href='board_write.do?page=${page }'">
                            </td>
                        </tr>
                    </table>
        
                    <br>
                    
                    <%-- 페이징 부분! --%>
                    <c:if test="${page > block }">
                        <a href="board_list.do?page=1"> ◀◀ </a>
                        <a href="board_list.do?page=${startBlock -1 }"> &lt;<span class="page_s">이전</span> | </a>&nbsp;
                    </c:if>
                    
                    <c:forEach begin="${startBlock }" end="${endBlock }" var = "i">
                        <c:if test="${i == page }">
                            <b><a href = "board_list.do?page=${i }">[${i }]</a></b>
                        </c:if>
                        <c:if test="${i != page }">
                            <a href = "board_list.do?page=${i }">[${i }]</a>
                        </c:if>
                    </c:forEach>
                    
                    <c:if test="${endBlock < allPage }">
                        &nbsp;<a href="board_list.do?page=${endBlock + 1 }"> | <span class="page_s">다음</span>&gt; </a>
                        <a href="board_list.do?page=${allPage }"> ▶▶ </a>
                    </c:if>
                    
                    
                    
                    <%-- 검색 부분! --%>
                    <div>
                        <br>
                        <form method="post" 
                            action="<%=request.getContextPath() %>/board_search.do">
                            <select name="search_field">
                                <option value="title">제목</option>
                                <option value="conten">내용</option>
                                <option value="title_content">제목+내용</option>
                                <option value="writer">작성자</option>
                            </select>
                            <input type="text" name="search_keyword">   
                            <input type="submit" value="검색">
                        </form>
                    </div>
                </div>
                    
            </div>
    
        </div>
        <div class="clear"></div>
    </div sub_wrap>
    <jsp:include page="../inc/pet_bottom.jsp" />

</body>
</html>