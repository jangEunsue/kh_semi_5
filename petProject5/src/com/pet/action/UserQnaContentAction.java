package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetQandADAO;
import com.pet.model.PetQandADTO;

public class UserQnaContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//
		int QA_no = Integer.parseInt(request.getParameter("no").trim());
		int nowPage = Integer.parseInt(request.getParameter("page").trim());
		String m_id = request.getParameter("id");
		
		
		PetQandADAO dao = PetQandADAO.getInstance();
		
		// 들어온 아이디와 해당 글의 아이디가 일치하는지 확인하는 메서드
		int check = dao.checkPetQandAId(QA_no, m_id);
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if (check == 1) { // 일치
			PetQandADTO dto = dao.getPetQandACont(QA_no);
			request.setAttribute("Cont", dto);	
			request.setAttribute("page", nowPage);
			forward.setRedirect(false);
			forward.setPath("user/pet_qna_cont.jsp");			
		}else { // 불일치
			out.println("<script>");
			out.println("alert('읽기 권한이 없습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
