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
                <p class="small_title">Notice</p>
                <p class="bl_lt">▼</p>
            </div>
            <div class="mid_nav">
                <ul class="mid_menu">
                    <li><a href="<%=request.getContextPath() %>/pet_notice.do"  class="nav_on"><i class="fa fa-caret-right"></i>공지사항</a></li>
                    <li><a href="<%=request.getContextPath() %>/pet_QA.do"><i class="fa fa-caret-right"></i>Q&A</a></li>
                </ul>
            </div>
        </div>
      
      
        <div id="section">
    
            <div class="page_count_bg"> 
                <div id="page_count" class="clearfix">
                    <ul>
                        <li><i class="fa fa-home"></i> Home</li>
                        <li><i class="fa fa-home"></i> 고객센터</li>
                        <li> <i class="fa fa-angle-right"></i> <strong>Notice</strong></li>
                    </ul>
                </div>
            </div>
    
            <p class="sub_title">공지사항<span class="sub_title2">Notice</span></p>
            
            <!-- 본문 시작 -->
            <div id="sub_contents">
            
                <div id="table_wrap">
                    
                    <table cellspacing="0" width="100%">
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일자</th>
                            <th>조회수</th>
                        </tr>
            
                        <c:set var="list" value="${List }" />
                        
                        <c:if test="${!empty list }">
                            <c:forEach items="${list }" var="dto">
                                <tr>
<<<<<<< HEAD
                                    <td align="center"> ${dto.getNotice_no() }</td>
                                    <td>
                                    	<a href="<%=request.getContextPath() %>/pet_notice_cont.do?no=${dto.getNotice_no() }&page=${page }">
                                            ${dto.getNotice_title() }
                                        </a>
                                    </td>
                                    <td> ${dto.getNotice_writer() }</td>
                                    <td> ${dto.getNotice_date().substring(0, 10) }</td>
                                    <td> ${dto.getNotice_hit() }</td>
=======
                                    <td align="center"> ${dto.getFree_no() }</td>
                                    <td>
                                    	<a href="<%=request.getContextPath() %>/pet_notice_cont.do?no=${dto.getFree_no() }&page=${page }">
                                            ${dto.getFree_title() }
                                        </a>
                                    </td>
                                    <td> ${dto.getFree_writer() }</td>
                                    <td> ${dto.getFree_date().substring(0, 10) }</td>
                                    <td> ${dto.getFree_hit() }</td>
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
                                </tr>
                            </c:forEach>
                        </c:if>
                        
                        <c:if test="${empty list }">
                            <tr>
                                <td colspan="5"><h4>게시글이 없습니다.</h4></td>
                            </tr>
                        </c:if>
                        
                        </tr>
                    </table>
        
                    <div class="ext_paging" style="margin-top: 20px;">
                        <%-- 페이징 부분! --%>
                        <c:if test="${page > block }">
                            <a href="pet_notice.do?page=1"> ◀◀ </a>
                            <a href="pet_notice.do?page=${startBlock -1 }"> &lt;<span class="page_s">이전</span> | </a>&nbsp;
                        </c:if>
                        
                        <c:forEach begin="${startBlock }" end="${endBlock }" var = "i">
                            <c:if test="${i == page }">
                                <b><a href = "pet_notice.do?page=${i }">[${i }]</a></b>
                            </c:if>
                            <c:if test="${i != page }">
                                <a href = "pet_notice.do?page=${i }">[${i }]</a>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${endBlock < allPage }">
                            &nbsp;<a href="pet_notice.do?page=${endBlock + 1 }"> | <span class="page_s">다음</span>&gt; </a>
                            <a href="pet_notice.do?page=${allPage }"> ▶▶ </a>
                        </c:if>
                    </div>
                    
                    <%-- 검색 부분! --%>
                    <div class="ext_search">
                        <form method="post" 
                            action="<%=request.getContextPath() %>/pet_notice_search.do">
                            <select name="search_field">
                                <option value="title">제목</option>
                                <option value="content">내용</option>
                                <option value="title_content">제목+내용</option>
                                <option value="writer">작성자</option>
                            </select>
                            <input type="text" name="search_keyword" class="search_input_text">   
                            <input type="submit" value="검색" class="search_input_btn">
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