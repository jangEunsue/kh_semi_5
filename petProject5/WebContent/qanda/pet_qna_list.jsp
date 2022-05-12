<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
h2{

margin:20;

}
 table {
        width: 70%;
        border: 1px solid #444444;
        border-collapse: collapse;
      }
      
 th, td {
   border-bottom: 1px solid #444444;
   padding: 10px;

 }
      
 th{
 
 background-color: #E9E1D4;
 text-align: center;
 
 }


#writeBtn{

margin: 0px;
float: ri;
size: 50px;

}

</style>
</head>
<body>
 <jsp:include page="../include/admin_top.jsp" />
 <div id="sub_wrap" class="webfont">
       
      
        <div align="center">
    
            
            <!-- 본문 시작 -->
            
                <div align="center">
                    
                    <table border="1" cellspacing="0" width="500">
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
                                    <td> ${dto.getQA_no() }</td>
                                    <td>
                                    	<%-- 댓글인 경우 --%>
							 			<c:if test="${dto.getQA_indent() != 0}">
							 				<c:forEach begin="1" end="${dto.getQA_indent() }">
							 					↳
							 				</c:forEach>
							               </c:if>
			                            	<a href="<%=request.getContextPath() %>/admin_pet_QA_cont.do?no=${dto.getQA_no() }">
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
                                <td colspan="4" align="center"><h4>게시글이 없습니다.</h4></td>
                            </tr>
                        </c:if>
                        
<<<<<<< HEAD
                        
=======
                        <tr>
                            <td colspan="4" align="right">
                            <input type="button" value="글쓰기" 
                                  onclick="location.href='admin_pet_QA_write.do'">        
                            </td>
                        </tr>
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
                    </table>
        
                    <br>
                    
                    <%-- 페이징 부분! --%>
                    <c:if test="${page > block }">
                        <a href="admin_pet_QA.do?page=1"> ◀◀ </a>
                        <a href="admin_pet_QA.do?page=${startBlock -1 }"> &lt;<span class="page_s">이전</span> | </a>&nbsp;
                    </c:if>
                    
                    <c:forEach begin="${startBlock }" end="${endBlock }" var = "i">
                        <c:if test="${i == page }">
                            <b><a href = "admin_pet_QA.do?page=${i }">[${i }]</a></b>
                        </c:if>
                        <c:if test="${i != page }">
                            <a href = "admin_pet_QA.do?page=${i }">[${i }]</a>
                        </c:if>
                    </c:forEach>
                    
                    <c:if test="${endBlock < allPage }">
                        &nbsp;<a href="admin_pet_QA.do?page=${endBlock + 1 }"> | <span class="page_s">다음</span>&gt; </a>
                        <a href="admin_pet_QA.do?page=${allPage }"> ▶▶ </a>
                    </c:if>
                    
                    
                    
                    <%-- 검색 부분! --%>
                    <div align="center">
                        <br>
                        <form method="post" 
                            action="<%=request.getContextPath() %>/admin_pet_QA_search.do">
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

</body>
</html>
