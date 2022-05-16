package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.AdminDAO;
import com.pet.model.AdminDTO;
import com.pet.model.OrderDAO;
import com.pet.model.PetMemberDAO;
import com.pet.model.PetMemberDTO;

public class UserLoginOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//
		String user_id = request.getParameter("user_id").trim();
		String user_pwd = request.getParameter("user_pwd").trim();
		
		ActionForward forward = new ActionForward();
		if (user_id.equals("admin")) {
			String m_id = user_id;
			
			String m_pwd = user_pwd;
			
			AdminDAO dao = AdminDAO.getInstance();
					
			int check = dao.adminCheck(m_id, m_pwd);
			
			HttpSession session = request.getSession();
			
			forward = new ActionForward();
			
			PrintWriter out = response.getWriter();
			
			OrderDAO o_dao = OrderDAO.getInstance();
			
			int del_b = o_dao.CountDel_b();
			int del_i = o_dao.CountDel_i();
			int del_a = o_dao.CountDel_a();
			int pay_b = o_dao.CountPay_b();
			int pay_a = o_dao.CountPay_a();
			
			if(check > 0) {
				// 관리자 정보
				AdminDTO dto = dao.getAdmin(m_id);
				
				session.setAttribute("adminId", dto.getM_id());
				session.setAttribute("adminName", dto.getM_name());
				session.setAttribute("del_b", del_b);
				session.setAttribute("del_i", del_i);
				session.setAttribute("del_a", del_a);
				session.setAttribute("pay_b", pay_b);
				session.setAttribute("pay_a", pay_a);

				forward.setRedirect(false);
				forward.setPath("admin1/admin_main.jsp");
				
			}else if(check == -1) {
				// 비번이 틀린 경우
				out.println("<script>");
				out.println("alert('관리자 비밀번호가 틀립니다.')");
				out.println("history.back()");
				out.println("</script>");
				
				
			}else {
				// 존재하지 않는 관리자
				out.println("<script>");
				out.println("alert('존재하지 않은 관리자입니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
			
		}else { // 일반회원
			PetMemberDAO dao = PetMemberDAO.getInstance();
			int check = dao.userPwdCheck(user_id, user_pwd);
			

			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			
			if (check > 0) {
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
				// 회원이 아닌 경우(아이디가 없거나 아이디가 틀린 경우
				out.println("<script>");
				out.println("alert('존재하지 않는 아이디 입니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
			
		}
		
		return forward;
	}

}
