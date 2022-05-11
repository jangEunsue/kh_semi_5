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
	      action="<%=request.getContextPath() %>/BoardQA_reply_ok.do">
	   
	      <input type="hidden" name="QA_no" value="${dto.getQA_no() }">
	      <input type="hidden" name="QA_group" value="${dto.getQA_group() }">
	      <input type="hidden" name="QA_step" value="${dto.getQA_step() }">
	      <input type="hidden" name="QA_indent" value="${dto.getQA_indent() }">
	      
	      <table border="1" cellspacing="0" width="400">
	         <tr>
	            <th>작성자</th>
	            <td> <input name="QA_writer"
	                     value="${dto.getQA_writer() }"> </td>
	         </tr>
	         
	         <tr>
	            <th>글제목</th>
	            <td> <input name="QA_title"
	                      value="(Re)${dto.getQA_title() }"> </td>
	         </tr>
	         
	         <tr>
	            <th>글내용</th>
	            <td>
	               <textarea rows="7" cols="30" name="QA_content">${dto.getQA_cont() }</textarea>
	            </td>
	         </tr>
	         
	         <tr>
	         	<th>아이디</th>
	         	<td> <input type="text" name="QA_userId"> </td>
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