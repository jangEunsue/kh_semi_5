package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.BoardDAO;
import com.pet.model.BoardDTO;

public class BoardUpdateOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
		String free_writer = request.getParameter("writer").trim();
		
		String free_title = request.getParameter("title").trim();
		
        String free_content = request.getParameter("content").trim();
		
		String free_pwd = request.getParameter("pwd").trim();
		
		int free_no =
				Integer.parseInt(request.getParameter("free_no").trim());
		
		BoardDTO dto = new BoardDTO();
		
		dto.setFree_no(free_no);
		
		dto.setFree_writer(free_writer);
		
		dto.setFree_title(free_title);
		
		dto.setFree_cont(free_content);

		dto.setFree_pwd(free_pwd);
		
		BoardDAO dao = BoardDAO.getInstance();
		
	   int check = dao.UpdateBoard(dto);
	   
	   ActionForward forward = new ActionForward();
	   
	   PrintWriter out = response.getWriter();
	   
	   if(check > 0) {
			forward.setRedirect(true);
			forward.setPath("free_content.do?no="+free_no);
	   }else if(check == -1) {
		   out.println("<script>");
			out.println("alert('비밀번호가 틀립니다.')");
			out.println("history.back()");
			out.println("</script>");
	   }else {
		   out.println("<script>");
			out.println("alert('게시물 수정 실패')");
			out.println("history.back()");
			out.println("</script>");
	   }
	   
		return forward;
	}

}
