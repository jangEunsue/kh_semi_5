<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

table{
  margin: auto;
}

table, td, th {
    border-collapse: collapse;
    border : 1px soild black;
}

</style>
</head>
<body>

 <jsp:include page="../include/admin_top.jsp" />
        <div align="center">
    
            <div class="page_count_bg"> 
                <div id="page_count" class="clearfix">
                   
                </div>
            </div>  
        
        <div >
	    <div >
	   <c:set var="dto" value="${Cont }" />

	   <table border="1" cellspacing="0" width="850">
	                    <tr align="center">
                            <th>글제목</th>
                            <td> ${dto.getNotice_title() } </td>
                        </tr>
                        <tr align="center">
                            <th>작성자</th>
                            <td> ${dto.getNotice_writer() } </td>
                        </tr>
                      
                        <tr align="center">
                            <c:if test="${empty dto.getNotice_update() }">
                                <th>작성일자</th>
                                <td> ${dto.getNotice_date().substring(0,10) } </td>
                            </c:if>
                         
                            <c:if test="${!empty dto.getNotice_update() }">
                                <th>수정일자</th>
                                <td> ${dto.getNotice_update().substring(0,10) } </td>
                            </c:if>
                        </tr>
                        <tr align="center">
                            <th>조회수</th>
                            <td> ${dto.getNotice_hit() } </td>
                        </tr>
                        <tr align="center">
                            <th>글내용</th>
                            <td class="board_cont"> 
                                <textarea rows="7" cols="50" readonly>${dto.getNotice_cont() }</textarea>
                            </td>
                        </tr>
	      
	      <c:if test="${empty dto }">
	         <tr>
	            <td colspan="2" align="center">
	               <h3>검섹된 게시물이 없습니다.....</h3>
	            </td>
	         </tr>
	      </c:if>
	      
	      
	   </table>
	   <br>
	   <tr>
	         <td colspan="2" align="center">
	            <input type="button" value="글수정"
	               onclick="location.href='admin_notice_update.do?no=${dto.getNotice_no()}'">
	      
	            <input type="button" value="글삭제"
	               onclick="if(confirm('게시글을 삭제하시겠습니까?')) {
	            	   			location.href='admin_notice_delete.do?no=${dto.getNotice_no()}'
	               			}else {  return;  }">
	      
	            <input type="button" value="답변글"
	               onclick="location.href='admin_notice_reply.do?no=${dto.getNotice_no()}'">
	      
	      		<input type="button" value="전체목록"
	               onclick="location.href='admin_notice_list.do'">
	         </td>
	      </tr>
	   </div>
	</div>
	</div>
	<br>
        <jsp:include page="../include/admin_bottom.jsp" />
</body>
</html>
