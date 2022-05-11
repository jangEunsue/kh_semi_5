package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.AdminDAO;
import com.pet.model.AdminDTO;
import com.pet.model.OrderDAO;

public class AdminLoginOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 관리자 로그인 
		
		String m_id = request.getParameter("m_id").trim();
		
		String m_pwd = request.getParameter("m_pwd").trim();
		
		AdminDAO dao = AdminDAO.getInstance();
				
		int check = dao.adminCheck(m_id, m_pwd);
		
		HttpSession session = request.getSession();
		
		ActionForward forward = new ActionForward();
		
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
		
		return forward;
	}

}
