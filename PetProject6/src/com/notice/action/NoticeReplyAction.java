package com.notice.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.NoticeDAO;
import com.pet.model.NoticeDTO;

public class NoticeReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
		int Notice_no =
				Integer.parseInt(request.getParameter("no").trim());
		
		NoticeDAO dao = NoticeDAO.getInstance();
		
		NoticeDTO dto = dao.getNoticeContent(Notice_no);
		
		request.setAttribute("reply", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("notice/notice_reply.jsp");
		
		return forward;
		
	}

}
