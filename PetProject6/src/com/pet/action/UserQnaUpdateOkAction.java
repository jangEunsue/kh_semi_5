package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetQandADAO;
import com.pet.model.PetQandADTO;

public class UserQnaUpdateOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 게시물 수정
		int QA_no = Integer.parseInt(request.getParameter("QA_no").trim());
		int nowPage = Integer.parseInt(request.getParameter("page").trim());
		String QA_userID = request.getParameter("userId").trim();
		String QA_title = request.getParameter("title").trim();
		String QA_cont = request.getParameter("content").trim();
		
		PetQandADTO dto = new PetQandADTO();
		dto.setQA_no(QA_no);
		dto.setQA_title(QA_title);
		dto.setQA_cont(QA_cont);
		
		PetQandADAO dao = PetQandADAO.getInstance();
		int check = dao.updatePetQandA(dto);

		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if (check > 0) {
			forward.setRedirect(true);
			forward.setPath("pet_QA_cont.do?id="+QA_userID+"&no="+QA_no+"&page="+nowPage+""); // 상품 목록 컨트롤러로 이동
		}else {
			out.println("<script>");
			out.println("alert('게시물을 수정하지 못했습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		return forward;
	}

}
