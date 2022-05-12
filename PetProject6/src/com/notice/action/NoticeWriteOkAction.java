package com.notice.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.NoticeDAO;
import com.pet.model.NoticeDTO;

public class NoticeWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String notice_writer = request.getParameter("writer").trim();
		
		String notice_title = request.getParameter("title").trim();
		
		String notice_content = request.getParameter("content").trim();
		
		String notice_pwd = request.getParameter("pwd").trim();
		
		NoticeDTO dto = new NoticeDTO();
		
		dto.setNotice_writer(notice_writer);
		
		dto.setNotice_title(notice_title);
		
		dto.setNotice_cont(notice_content);
		
		dto.setNotice_pwd(notice_pwd);
		
		NoticeDAO dao = NoticeDAO.getInstance();
		
		int check = dao.insertNotice(dto);
		
		PrintWriter out = response.getWriter();
		
		ActionForward forward = new ActionForward();
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('게시물 작성 완료'");
			out.println("</script>");
			forward.setRedirect(true);
			forward.setPath("admin_notice_list.do");
		}else {
			out.println("<script>");
			out.println("alert('게시물 작성 실패'");
			out.println("</script>");
			forward.setRedirect(false);
			forward.setPath("Notice/Notice_write.jsp");
		}
				
		
		
		return forward;
	}

}