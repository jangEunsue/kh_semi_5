package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.BoardDAO;
import com.pet.model.BoardDTO;

public class AdminBoardWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String free_writer = request.getParameter("writer").trim();
		
		String free_title = request.getParameter("title").trim();
		
		String free_content = request.getParameter("content").trim();
		
		String free_pwd = request.getParameter("pwd").trim();
		
		BoardDTO dto = new BoardDTO();
		
		dto.setFree_writer(free_writer);
		
		dto.setFree_title(free_title);
		
		dto.setFree_cont(free_content);
		
		dto.setFree_pwd(free_pwd);
		
		BoardDAO dao = BoardDAO.getInstance();
		
		int check = dao.insertBoard(dto);
		
		PrintWriter out = response.getWriter();
		
		ActionForward forward = new ActionForward();
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('게시물 작성 완료'");
			out.println("</script>");
			forward.setRedirect(true);
			forward.setPath("admin_board_list.do");
		}else {
			out.println("<script>");
			out.println("alert('게시물 작성 실패'");
			out.println("</script>");
			forward.setRedirect(false);
			forward.setPath("board/board_write.jsp");
		}
				
		
		
		return forward;
	}

}