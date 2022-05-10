package com.boardqa.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.PetQandADAO;
import com.pet.model.PetQandADTO;

public class AdminQnaContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		int QA_no = Integer.parseInt(request.getParameter("no").trim());
		 
PetQandADAO dao = PetQandADAO.getInstance();
		
PetQandADTO dto = dao.getPetQandACont(QA_no);
		
request.setAttribute("Cont", dto);
	
ActionForward forward = new ActionForward();

forward.setRedirect(false);

forward.setPath("qanda/pet_qna_cont.jsp");

return forward;
	}

}

