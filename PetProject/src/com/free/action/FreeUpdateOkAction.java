package com.free.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.FreeBoardDAO;
import com.pet.model.FreeBoardDTO;

public class FreeUpdateOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String free_writer = request.getParameter("writer").trim();
		String free_title = request.getParameter("title").trim();
		String free_cont = request.getParameter("content").trim();
		String free_pwd = request.getParameter("pwd").trim();
		int free_no = Integer.parseInt(request.getParameter("free_no").trim());
		
		FreeBoardDTO dto = new FreeBoardDTO();
		
		dto.setFree_no(free_no);
		dto.setFree_writer(free_writer);
		dto.setFree_title(free_title);
		dto.setFree_cont(free_cont);
		dto.setFree_pwd(free_pwd);
		
		FreeBoardDAO dao = FreeBoardDAO.getInstance();
		
		int check = dao.updateOkfree(dto);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(check>0) {
			forward.setRedirect(true);
			forward.setPath("free_content.do?no="+free_no);
		}else if(check==-1) {
			out.println("<script>");
			out.println("alert('비밀번호를 확인해주세요.')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 수정 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
