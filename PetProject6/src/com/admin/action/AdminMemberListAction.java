package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.MemberDAO;
import com.pet.model.MemberDTO;

public class AdminMemberListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
		MemberDAO dao = MemberDAO.getInstance();
		
		List<MemberDTO> list = dao.getMemberList();
		
		request.setAttribute("memberList", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("admin1/admin_member_list.jsp");
		
		return forward;
	}

}
