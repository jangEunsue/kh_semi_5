package com.boardqa.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.PetQandADAO;

public class AdminQnaDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
        int QA_no = Integer.parseInt(request.getParameter("no").trim());
		
		PetQandADAO dao = PetQandADAO.getInstance();
		
		int check = dao.deletePetQandA(QA_no);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			forward.setRedirect(true);
			forward.setPath("boardqa_list.do");
		}else {
			out.println("<script>");
			out.println("alert('게시물을삭제하지못했습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
		
	}


}
