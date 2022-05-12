package com.pet.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetMemberDAO;
import com.pet.model.PetMemberDTO;

public class UserQnaWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 게시판 글쓰기
		int nowPage = Integer.parseInt(request.getParameter("page").trim()) ;
		String userID = request.getParameter("id").trim();
		
		ActionForward forward = new ActionForward();
		PetMemberDAO dao = PetMemberDAO.getInstance();
		// 작성자(이름) 가지고 오기
		PetMemberDTO dto = dao.getMember(userID);
		request.setAttribute("page", nowPage);
		request.setAttribute("Info", dto);
		
		forward.setRedirect(false);
		forward.setPath("user/pet_qna_write.jsp");
		
		return forward;
	}

}
