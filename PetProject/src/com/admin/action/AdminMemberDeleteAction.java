package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.MemberDAO;

public class AdminMemberDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int m_num = 
				Integer.parseInt(request.getParameter("num").trim());
		
		MemberDAO dao = MemberDAO.getInstance();
		
		int check = dao.deletMember(m_num);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
            if(check > 0) {
			
			forward.setRedirect(true);
			
			forward.setPath("admin_member_list.do");
			
		}else {
			out.println("<script>");
			out.println("alert('회원 삭제 실패~~~')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
