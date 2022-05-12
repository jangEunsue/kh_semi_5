package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetMemberDAO;

public class UserFindPasswordOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//
		String user_id = request.getParameter("user_id").trim();
		String user_email = request.getParameter("user_email").trim();
		
		PetMemberDAO dao = PetMemberDAO.getInstance();
		
		// 아이디 존재 확인 
		int res = dao.userEmailCheck(user_id, user_email);
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		String pwd = "";
		
		if (res > 0) {
			// 회원인 경우
			pwd = dao.getPetMemberPassword(user_id);
			request.setAttribute("findPwd", pwd);
			forward.setRedirect(false);
			forward.setPath("user/user_pwd.jsp"); // 메인 페이지로 이동
			
		}else if (res == -1) {
			// 비밀번호가 틀린 경우
			out.println("<script>");
			out.println("alert('이메일을 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");
		}else if(res == 0){
			// 회원이 아닌 경우(아이디가 없거나 아이디가 틀린 경우
			out.println("<script>");
			out.println("alert('존재하지 않는 아이디 입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
