package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.BoardDAO;
import com.pet.model.BoardDTO;

public class FreeContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
		int free_no = 
				Integer.parseInt(request.getParameter("no").trim());
		
		BoardDAO dao = BoardDAO.getInstance();
			
		BoardDTO dto = dao.getFreeContent(free_no);
		
		request.setAttribute("Cont", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
	
		forward.setPath("board/board_content.jsp");
		
		return forward;
	}

}
