package com.notice.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.NoticeDAO;
import com.pet.model.NoticeDTO;

public class NoticeUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
		int free_no = 
				Integer.parseInt(request.getParameter("no").trim());
		
		NoticeDAO dao = NoticeDAO.getInstance();
		
		NoticeDTO dto = dao.getNoticeContent(free_no);
		
		request.setAttribute("modify", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);

		forward.setPath("notice/Notice_update.jsp");
		return forward;
	}

}
