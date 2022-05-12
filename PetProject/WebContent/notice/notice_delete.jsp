<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <div align="center">
    <hr width="30%" color="blue">
        <h3>공지사항 삭제</h3>
    <hr width="30%" color="blue">
    <br>
    
    <form method="post"
          action="<%=request.getContextPath() %>/admin_notice_delete_ok.do">
        
     <input type="hidden" name="notice_no" value="${param.no }">
     <table border="1" cellpacing="0" width="400">
       <tr>
          <th>삭제할 게시글 비밀번호</th>
          <td> <input type="password" name="pwd"> </td>
	   </tr>
	   
	   <tr>
	      	<td colspan="2" align="center">
	      	  <input type="submit" value="글삭제">&nbsp;&nbsp;&nbsp;
	      	 <input type="reset" value="다시작성">
	      	</td>
	   </tr>
     </table>
   </form>
  </div>

</body>
</html>
