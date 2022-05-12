package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.MemberDAO;
import com.pet.model.MemberDTO;

public class AdminMemberInputOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
        String m_id = request.getParameter("m_id").trim();
		
		String m_pwd = request.getParameter("m_pwd").trim();
		
		String m_name = request.getParameter("m_name").trim();

		String m_birth = request.getParameter("m_birth").trim();
		
		String m_email = request.getParameter("m_email").trim();
		
		String m_phone = request.getParameter("m_phone").trim();
		
		String m_addr = request.getParameter("m_addr").trim();
		
		int m_mileage = Integer.parseInt(request.getParameter("m_mileage").trim());

		MemberDTO dto = new MemberDTO();
		
		dto.setM_id(m_id);
		dto.setM_pwd(m_pwd);
		dto.setM_name(m_name);
		dto.setM_birth(m_birth);
		dto.setM_email(m_email);
		dto.setM_phone(m_phone);
		dto.setM_addr(m_addr);
		dto.setM_mileage(m_mileage);
		
		MemberDAO dao = MemberDAO.getInstance();
		
		int check = dao.insertMember(dto);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter(); 
		
		if(check > 0) {
			
            forward.setRedirect(true);
			
			forward.setPath("admin_member_list.do");
		}else {
			out.println("<script>");
			out.println("alert('회원 등록 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
