package com.free.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.FreeBoardDAO;
import com.pet.model.FreeBoardDTO;

public class FreeReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int free_no = Integer.parseInt(request.getParameter("no").trim());
		
		FreeBoardDAO dao = FreeBoardDAO.getInstance();
		
		FreeBoardDTO dto = dao.UpdateFree(free_no);
		
		request.setAttribute("reply", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("freeboard/free_reply.jsp");
		
		return forward;
	}

}
