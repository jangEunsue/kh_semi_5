<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 <jsp:include page="../include/admin_top.jsp" />

    <div align="center">
      <c:set var="dto" value="${reply }"/>
      <hr width="30%" color="lightgray">
        <h3> 게시판 답변</h3>
      <hr width="30%" color="lightgray">
      <br>
      
      <form method="post"
	      action="<%=request.getContextPath() %>/admin_notice_reply_ok.do">
	   
	      <input type="hidden" name="Notice_no" value="${dto.getNotice_no() }">
	      <input type="hidden" name="Notice_group" value="${dto.getNotice_group() }">
	      <input type="hidden" name="Notice_step" value="${dto.getNotice_step() }">
	      <input type="hidden" name="Notice_indent" value="${dto.getNotice_indent() }">
	      
	      <table border="1" cellspacing="0" width="400">
	         <tr>
	            <th>작성자</th>
	            <td> <input name="reply_writer"
	                     value="${dto.getNotice_writer() }"> </td>
	         </tr>
	         
	         <tr>
	            <th>글제목</th>
	            <td> <input name="reply_title"
	                      value="(Re)${dto.getNotice_title() }"> </td>
	         </tr>
	         
	         <tr>
	            <th>글내용</th>
	            <td>
	               <textarea rows="7" cols="30" name="reply_content">${dto.getNotice_cont() }</textarea>
	            </td>
	         </tr>
	         
	         <tr>
	         	<th>비밀번호</th>
	         	<td> <input type="password" name="reply_pwd"> </td>
	         </tr>
	         
	         <tr>
	            <td colspan="2" align="center">
	               <input type="submit" value="답변글">&nbsp;&nbsp;&nbsp;
	               <input type="reset" value="다시작성">
	            </td>
	         </tr>
	      
	      </table>
	      
	   </form>
      
    </div>
    
</body>
</html>
