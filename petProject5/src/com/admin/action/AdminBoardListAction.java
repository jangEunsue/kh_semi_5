package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.BoardDAO;
import com.pet.model.BoardDTO;

public class AdminBoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		BoardDAO dao = BoardDAO.getInstance();
		
		List<BoardDTO> list = dao.getBoardList();
		
		request.setAttribute("List", list);
		
		ActionForward forward = new ActionForward();
		
        forward.setRedirect(false);  
		
		forward.setPath("board/board_list.jsp");
		
		return forward;

	}

}
