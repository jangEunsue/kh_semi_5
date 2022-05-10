package com.notice.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.NoticeDAO;
import com.pet.model.NoticeDTO;

public class NoticeUpdateOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
		String notice_writer = request.getParameter("writer").trim();
		
		String notice_title = request.getParameter("title").trim();
		
        String notice_content = request.getParameter("content").trim();
		
		String notice_pwd = request.getParameter("pwd").trim();
		
		int notice_no =
				Integer.parseInt(request.getParameter("notice_no").trim());
		
		NoticeDTO dto = new NoticeDTO();
		
		dto.setNotice_no(notice_no);
		
		dto.setNotice_writer(notice_writer);
		
		dto.setNotice_title(notice_title);
		
		dto.setNotice_cont(notice_content);

		dto.setNotice_pwd(notice_pwd);
		
		NoticeDAO dao = NoticeDAO.getInstance();
		
	   int check = dao.UpdateNotice(dto);
	   
	   ActionForward forward = new ActionForward();
	   
	   PrintWriter out = response.getWriter();
	   
	   if(check > 0) {
			forward.setRedirect(true);
			forward.setPath("notice_content.do?no="+notice_no);
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
