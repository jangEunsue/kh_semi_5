package com.notice.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.NoticeDAO;
import com.pet.model.NoticeDTO;

public class NoticeOKReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 답변글 저장
		
        String reply_writer = request.getParameter("reply_writer").trim();
		
		String reply_title = request.getParameter("reply_title").trim();
		
		String reply_content = request.getParameter("reply_content").trim();
		
		String reply_pwd = request.getParameter("reply_pwd").trim();
		
		int reply_no = 
				Integer.parseInt(request.getParameter("reply_no").trim());
		
		int reply_group = 
				Integer.parseInt(request.getParameter("reply_group").trim());
		
		int reply_step = 
				Integer.parseInt(request.getParameter("reply_step").trim());
		
		int reply_indent = 
				Integer.parseInt(request.getParameter("reply_indent").trim());
		
	    NoticeDTO dto = new NoticeDTO();
		
        dto.setNotice_no(reply_no);
		
		dto.setNotice_writer(reply_writer);
		
		dto.setNotice_title(reply_title);
		
		dto.setNotice_cont(reply_content);
		
		dto.setNotice_pwd(reply_pwd);
		
		dto.setNotice_group(reply_group);
		
		dto.setNotice_step(reply_step);
		
		dto.setNotice_indent(reply_indent);
		
		NoticeDAO dao = NoticeDAO.getInstance();
		
		dao.replyUpdate(reply_group, reply_step);
		
		int check = dao.replyNotice(dto);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			forward.setRedirect(true);
			
			forward.setPath("admin_Notice_list.do");
		}else {
			out.println("<script>");
			out.println("alert('게시물 답변글 등록 실패~~~')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
