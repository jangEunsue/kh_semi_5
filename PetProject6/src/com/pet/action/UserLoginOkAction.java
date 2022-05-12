package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetMemberDAO;
import com.pet.model.PetMemberDTO;

public class UserLoginOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//
		String user_id = request.getParameter("user_id").trim();
		String user_pwd = request.getParameter("user_pwd").trim();
		
		PetMemberDAO dao = PetMemberDAO.getInstance();
		int check = dao.userPwdCheck(user_id, user_pwd);
		
		ActionForward forward = new ActionForward();

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		
		if(user_id.equals("admin")) {
			session.setAttribute("sessionID", "admin");
			
			forward.setRedirect(false);
			forward.setPath("./admin1/admin_main.jsp"); // 관리자 메인 페이지로 이동
		}
		else if (check > 0) {
			// 회원인 경우
			PetMemberDTO dto = dao.getMember(user_id);
			session.setAttribute("userId", dto.getM_id());
			session.setAttribute("userName", dto.getM_name());
			session.setAttribute("sessionID", dto.getM_id());
			
			forward.setRedirect(true);
			forward.setPath("pet_main.do"); // 메인 페이지로 이동
			
		}else if (check == -1) {
			// 비밀번호가 틀린 경우
			out.println("<script>");
			out.println("alert('비밀번호를 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");
		}else if(check == 0){
			// 회원이 아닌 경우(아이디가 없거나 아이디가 틀린 경우)
			out.println("<script>");
			out.println("alert('존재하지 않는 아이디 입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
		
	}

}
