package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetQandADAO;
import com.pet.model.PetQandADTO;

public class UserQnaWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int page = Integer.parseInt(request.getParameter("page").trim()) ;
		request.setAttribute("page", page);
		String qA_writer = request.getParameter("writer").trim();
		String qA_userID = request.getParameter("userID").trim();
		String qA_title = request.getParameter("title").trim();
		String qA_cont = request.getParameter("content").trim();
		
		PetQandADTO dto = new PetQandADTO();
		dto.setQA_writer(qA_writer);
		dto.setQA_title(qA_title);
		dto.setQA_cont(qA_cont);
		dto.setQA_userID(qA_userID);
		
		PetQandADAO dao = PetQandADAO.getInstance();
		int res = dao.insertPetQandA(dto);
		
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if (res > 0) {
			out.println("<script>");
			out.println("alert('게시물을 등록했습니다.')");
			out.println("</script>");
			forward.setRedirect(true);
			forward.setPath("pet_QA.do");
		}else {
			out.println("<script>");
	         out.println("alert('게시물을 등록하지 못했습니다.')");
	         out.println("history.back()");
	         out.println("</script>");
		}
		
		return forward;
	}

}
