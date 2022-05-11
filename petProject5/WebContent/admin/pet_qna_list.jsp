<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
            
                <div id="table_wrap">
                    
                    <table cellspacing="0" width="100%">
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
                                    	<%-- 댓글인 경우 --%>
							 			<c:if test="${dto.getQA_indent() != 0}">
							 				<c:forEach begin="1" end="${dto.getQA_indent() }">
							 					↳
							 				</c:forEach>
							 			</c:if>
                                    	<a href="<%=request.getContextPath() %>/pet_QA_cont.do?&no=${dto.getQA_no() }&page=${page }">
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
                                <td colspan="4"><h4>게시글이 없습니다.</h4></td>
                            </tr>
                        </c:if>
                        
                        <tr>
                            <td colspan="4" align="right">
                            	 <input type="button" value="글쓰기"
                                       onclick="location.href='pet_QA_write.do?&page=${page }'">
                                
                            </td>
                        </tr>
                    </table>
        
                    <br>
                    
                    <%-- 페이징 부분! --%>
                    <c:if test="${page > block }">
                        <a href="pet_QA.do?page=1"> ◀◀ </a>
                        <a href="pet_QA.do?page=${startBlock -1 }"> &lt;<span class="page_s">이전</span> | </a>&nbsp;
                    </c:if>
                    
                    <c:forEach begin="${startBlock }" end="${endBlock }" var = "i">
                        <c:if test="${i == page }">
                            <b><a href = "pet_QA.do?page=${i }">[${i }]</a></b>
                        </c:if>
                        <c:if test="${i != page }">
                            <a href = "pet_QA.do?page=${i }">[${i }]</a>
                        </c:if>
                    </c:forEach>
                    
                    <c:if test="${endBlock < allPage }">
                        &nbsp;<a href="pet_QA.do?page=${endBlock + 1 }"> | <span class="page_s">다음</span>&gt; </a>
                        <a href="pet_QA.do?page=${allPage }"> ▶▶ </a>
                    </c:if>
                    
                    
                    
                    <%-- 검색 부분! --%>
                    <div>
                        <br>
                        <form method="post" 
                            action="<%=request.getContextPath() %>/pet_QA_search.do">
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