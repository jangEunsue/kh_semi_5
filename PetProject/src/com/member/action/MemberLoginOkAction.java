package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.MemberDAO;
import com.pet.model.MemberDTO;

public class MemberLoginOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		// 회원 로그인 
		
				String m_id = request.getParameter("m_id").trim();
				
				String m_pwd = request.getParameter("m_pwd").trim();
				
				 MemberDAO dao = MemberDAO.getInstance();
						
				int check = dao.MemberCheck(m_id, m_pwd);
				
				HttpSession session = request.getSession();
				
				ActionForward forward = new ActionForward();
				
				PrintWriter out = response.getWriter();
				
				if(check > 0) {
					// 관리자 정보
					MemberDTO dto = dao.getMember(m_id);
					
					session.setAttribute("adminId", dto.getM_id());
					session.setAttribute("adminName", dto.getM_name());
					
					forward.setPath("user1/user_main.jsp");
					
				}else if(check == -1) {
					// 비번이 틀린 경우
					out.println("<script>");
					out.println("alert('회원 비밀번호가 틀립니다.')");
					out.println("history.back()");
					out.println("</script>");
					
					
				}else {
					// 존재하지 않는 관리자
					out.println("<script>");
					out.println("alert('존재하지 않은 회원입니다.')");
					out.println("history.back()");
					out.println("</script>");
				}
				
				return forward;
			}
	

}
