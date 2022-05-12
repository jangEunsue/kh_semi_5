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
                    <li><a href="<%=request.getContextPath() %>/pet_notice.do" class="nav_on"><i class="fa fa-caret-right"></i>공지사항</a></li>
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
            <div id="board_wrap">
                    <c:set var="dto" value="${Cont }"></c:set>
                    <table border="0" cellspacing="0" width="100%">
                        <tr>
                            <th>글제목</th>
                            <td> ${dto.getNotice_title() } </td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td> ${dto.getNotice_writer() } </td>
                        </tr>
                      
                        <tr>
                            <c:if test="${empty dto.getNotice_update() }">
                                <th>작성일자</th>
                                <td> ${dto.getNotice_date().substring(0,10) } </td>
                            </c:if>
                         
                            <c:if test="${!empty dto.getNotice_update() }">
                                <th>수정일자</th>
                                <td> ${dto.getNotice_update().substring(0,10) } </td>
                            </c:if>
                        </tr>
                        <tr>
                            <th>조회수</th>
                            <td> ${dto.getNotice_hit() } </td>
                        </tr>
                        <tr>
                            <th>글내용</th>
                            <td class="board_cont"> 
                                <textarea readonly>${dto.getNotice_cont() }</textarea>
                            </td>
                        </tr>

                        <c:if test="${empty dto }">
                            <tr>
                                <td colspan="2">검색된 게시물이 없습니다.</td>
                            </tr>
                        </c:if>
                        
                        <tr>
                            <td align="center" colspan="2" class="board_btn">
                                <input type="button" value="목록" onclick="location.href='pet_notice.do?page=${page }'">
                            </td>
                        </tr>
                        
                    </table>
                    
            
                </div>
                    
            </div>
    
        </div>
        <div class="clear"></div>
    </div sub_wrap>
    <jsp:include page="../inc/pet_bottom.jsp" />

</body>
</html>