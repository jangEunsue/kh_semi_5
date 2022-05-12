<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<<<<<<< HEAD
<style type="text/css">

table{
  margin: auto;
}

table, td, th {
    border-collapse: collapse;
    border : 1px soild black;
}

</style>
=======
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
</head>
<body>

 <jsp:include page="../include/admin_top.jsp" />
<<<<<<< HEAD
        <div align="center">
    
            <div class="page_count_bg"> 
                <div id="page_count" class="clearfix">
                   
                </div>
            </div>  
        
        <div >
	    <div >
	   <c:set var="dto" value="${Cont }" />

	   <table border="1" cellspacing="0" width="100%">
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
                                <textarea readonly>${dto.getNotice_cont() }</textarea>
                            </td>
                        </tr>
=======

   <div align="center">
	   <c:set var="dto" value="${Cont }" />
	      <h3>${dto.getNotice_writer() } 님 자유게시판 상세 내역 페이지</h3>
	   <hr width="30%" color="marmoon">	   
	   <table border="1" cellspacing="0" width="400">
	      <tr>
	         <th>작성자</th>
	      	 <td> ${dto.getNotice_writer() } </td>
	      </tr>
	      
	      <tr>
	         <th>글제목</th>
	      	 <td> ${dto.getNotice_title() } </td>
	      </tr>
	      
	      <tr>
	         <th>글내용</th>
	      	 <td>
	      	    <textarea rows="7" cols="25" readonly>${dto.getNotice_cont() }</textarea>
	         </td>
	      </tr>
	      
	      <tr>
	         <th>비밀번호</th>
	         <td>
	            <c:if test="${!empty dto.getNotice_pwd() }">
	               <c:forEach begin="1" end="${dto.getNotice_pwd().length() }">
	               				*
	               </c:forEach>
	            </c:if>
	         </td>
	      </tr>
	   
	   	  <tr>
	         <th>조회수</th>
	      	 <td> ${dto.getNotice_hit() } </td>
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
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
	      
	      <c:if test="${empty dto }">
	         <tr>
	            <td colspan="2" align="center">
	               <h3>검섹된 게시물이 없습니다.....</h3>
	            </td>
	         </tr>
	      </c:if>
	      
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
	   </table>
<<<<<<< HEAD
	   </div>
	</div>
	</div>
	
        <jsp:include page="../include/admin_bottom.jsp" />
=======
	
	</div>

>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
</body>
</html>
