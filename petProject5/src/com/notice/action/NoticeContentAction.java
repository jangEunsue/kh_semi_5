package com.notice.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.NoticeDAO;
import com.pet.model.NoticeDTO;

public class NoticeContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
		int Notice_no = 
				Integer.parseInt(request.getParameter("no").trim());
		
		NoticeDAO dao = NoticeDAO.getInstance();
			
		NoticeDTO dto = dao.getNoticeContent(Notice_no);
		
		request.setAttribute("Cont", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
	
		forward.setPath("notice/notice_content.jsp");
		
		return forward;
	}

}
