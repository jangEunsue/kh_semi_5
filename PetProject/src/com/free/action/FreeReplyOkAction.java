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

public class FreeReplyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		
		String free_id = (String)session.getAttribute("userId");
		
		
		String re_writer = request.getParameter("re_writer").trim();
		
		String re_title = request.getParameter("re_title").trim();
		
		String re_content = request.getParameter("re_content").trim();
		
		String re_pwd = request.getParameter("re_pwd").trim();
		
		
		int free_no = Integer.parseInt(request.getParameter("free_no").trim());
		
		int free_group = Integer.parseInt(request.getParameter("free_group").trim());
		
		int free_step = Integer.parseInt(request.getParameter("free_step").trim());
		
		int free_indent = Integer.parseInt(request.getParameter("free_indent").trim());
		
		FreeBoardDTO dto = new FreeBoardDTO();
		
		dto.setFree_no(free_no);
		dto.setFree_id(free_id);
		dto.setFree_writer(re_writer);
		dto.setFree_title(re_title);
		dto.setFree_cont(re_content);
		dto.setFree_pwd(re_pwd);
		dto.setFree_group(free_group);
		dto.setFree_step(free_step);
		dto.setFree_indent(free_indent);
		
		FreeBoardDAO dao = FreeBoardDAO.getInstance();
		
		dao.replyUpdate(free_group, free_step);
		
		int check = dao.replyFree(dto);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(check>0) {
			forward.setRedirect(true);
			forward.setPath("free_list.do");
		}else {
			out.println("<script>");
			out.println("alert('답글 등록 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
