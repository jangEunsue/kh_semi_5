package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetNoticeDAO;
import com.pet.model.PetNoticeDTO;
import com.pet.model.PetQandADAO;
import com.pet.model.PetQandADTO;

public class UserNoticeContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 공지사항 상세내역
		int notice_no = Integer.parseInt(request.getParameter("no").trim());
		int nowPage = Integer.parseInt(request.getParameter("page").trim());
		
		
		PetNoticeDAO dao = PetNoticeDAO.getInstance();
		// 조회수 증가
		PetNoticeDTO dto = dao.getPetNoticeCont(notice_no);
		request.setAttribute("Cont", dto);	
		request.setAttribute("page", nowPage);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/pet_notice_cont.jsp");	
		
		return forward;
	}

}
