package com.free.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetMemberDAO;
import com.pet.model.PetMemberDTO;


public class FreeWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		
		String userId = (String)session.getAttribute("userId");
		
		PetMemberDAO dao = PetMemberDAO.getInstance();
		
		PetMemberDTO pm = dao.getMember(userId);
		
		request.setAttribute("memberList", pm);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("freeboard/free_write.jsp");
		
		
		return forward;
	}

}

