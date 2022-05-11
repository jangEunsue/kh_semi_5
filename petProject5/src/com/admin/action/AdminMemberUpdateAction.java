package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.MemberDAO;
import com.pet.model.MemberDTO;

public class AdminMemberUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 불러온 자료를 수정하는 비지니스 로직
		
		int m_num =
				Integer.parseInt(request.getParameter("num").trim());
		
		MemberDAO dao = MemberDAO.getInstance();
		
		MemberDTO dto = dao.memberContent(m_num);
		
		request.setAttribute("modify", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user1/user_member_update.jsp");
		
		return forward;
	}

}
