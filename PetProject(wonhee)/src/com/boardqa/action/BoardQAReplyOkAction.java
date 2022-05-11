package com.boardqa.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetQandADAO;
import com.pet.model.PetQandADTO;

public class BoardQAReplyOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		  String QA_writer = request.getParameter("QA_writer").trim();
			
			String QA_title = request.getParameter("QA_title").trim();
			
			String QA_content = request.getParameter("QA_content").trim();
			
			String QA_userID = request.getParameter("QA_userID").trim();
			
			int QA_no = 
					Integer.parseInt(request.getParameter("QA_no").trim());
			
			int QA_group = 
					Integer.parseInt(request.getParameter("QA_group").trim());
			
			int QA_step = 
					Integer.parseInt(request.getParameter("QA_step").trim());
			
			int QA_indent = 
					Integer.parseInt(request.getParameter("QA_indent").trim());
			
			PetQandADTO dto = new PetQandADTO();
			
	        dto.setQA_no(QA_no);
			
			dto.setQA_writer(QA_writer);
			
			dto.setQA_title(QA_title);
			
			dto.setQA_cont(QA_content);
			
			dto.setQA_userID(QA_userID);
			
			dto.setQA_group(QA_group);
			
			dto.setQA_step(QA_step);
			
			dto.setQA_indent(QA_indent);
			
			PetQandADAO dao = PetQandADAO.getInstance();
			
			dao.replyUpdate(QA_group, QA_step);
			
			int check = dao.replyQa(dto);
			
			ActionForward forward = new ActionForward();
			
			PrintWriter out = response.getWriter();
			
			if(check > 0) {
				
				forward.setRedirect(true);
				
				forward.setPath("admin_boardqa_list.do");
			}else {
				out.println("<script>");
				out.println("alert('게시물 답변글 등록 실패~~~')");
				out.println("history.back()");
				out.println("</script>");
			}
			
			return forward;
		}

}
