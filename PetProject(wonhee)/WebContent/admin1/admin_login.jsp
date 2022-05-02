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
       <h3>관리자 로그인 페이지</h3>
    <hr width="30%" color="blue">
    <br>
    
    <form method="post"
          action="<%=request.getContextPath()%>/admin_login_ok.do">
          
          <table border="1" cellspacing="0" width="400">
            <tr>
              <th>관리자 아이디</th>
              <td> <input name="m_id"> </td>
           </tr>
           
           <tr>
             <th>관리자 비밀번호</th>
             <td> <input type="password" name="m_pwd"> </td>
           </tr> 
            
           <tr>
             <td colspan="2" align="center">
             <input type="submit" value="로그인">&nbsp;&nbsp;&nbsp;
             <input type="reset" value="다시작성">
             </td>
           </tr>
          
          
          </table>
    
    </form>
    </div>
</body>
</html>