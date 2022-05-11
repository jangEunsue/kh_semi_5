package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.BoardDAO;
import com.pet.model.BoardDTO;

public class BoardReplyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 답변글 저장
		
        String reply_writer = request.getParameter("reply_writer").trim();
		
		String reply_title = request.getParameter("reply_title").trim();
		
		String reply_content = request.getParameter("reply_content").trim();
		
		String reply_pwd = request.getParameter("reply_pwd").trim();
		
		int free_no = 
				Integer.parseInt(request.getParameter("free_no").trim());
		
		int free_group = 
				Integer.parseInt(request.getParameter("free_group").trim());
		
		int free_step = 
				Integer.parseInt(request.getParameter("free_step").trim());
		
		int free_indent = 
				Integer.parseInt(request.getParameter("free_indent").trim());
		
		BoardDTO dto = new BoardDTO();
		
        dto.setFree_no(free_no);
		
		dto.setFree_writer(reply_writer);
		
		dto.setFree_title(reply_title);
		
		dto.setFree_cont(reply_content);
		
		dto.setFree_pwd(reply_pwd);
		
		dto.setFree_group(free_group);
		
		dto.setFree_step(free_step);
		
		dto.setFree_indent(free_indent);
		
		BoardDAO dao = BoardDAO.getInstance();
		
		dao.replyUpdate(free_group, free_step);
		
		int check = dao.replyBoard(dto);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			forward.setRedirect(true);
			
			forward.setPath("admin_board_list.do");
		}else {
			out.println("<script>");
			out.println("alert('게시물 답변글 등록 실패~~~')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
