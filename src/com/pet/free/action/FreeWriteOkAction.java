package com.free.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.FreeBoardDAO;
import com.pet.model.FreeBoardDTO;

public class FreeWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		
		String free_id = (String)session.getAttribute("userId");
		
		String free_writer = request.getParameter("writer").trim();
		String free_title = request.getParameter("title").trim();
		String free_cont = request.getParameter("content").trim();
		String free_pwd = request.getParameter("pwd").trim();
		
		FreeBoardDTO dto = new FreeBoardDTO();
		dto.setFree_id(free_id);
		dto.setFree_writer(free_writer);
		dto.setFree_title(free_title);
		dto.setFree_cont(free_cont);
		dto.setFree_pwd(free_pwd);
		
		FreeBoardDAO dao = FreeBoardDAO.getInstance();
		
		int check = dao.insertFree(dto);
		
		PrintWriter out = response.getWriter();
		
		ActionForward forward = new ActionForward();
		
		if(check>0) {
			out.println("<script>");
			out.println("alert('게시글 등록 성공')");
			out.println("</script>");
			forward.setRedirect(true);
			forward.setPath("free_list.do");
		}else {
			out.println("<script>");
			out.println("alert('게시물 추가 실패')");
			out.println("</script>");
			forward.setRedirect(false);
			forward.setPath("freeboard/free_write.jsp");
		}
		return forward;
	}

}
