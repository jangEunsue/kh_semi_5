package com.pet.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ReviewDAO;
import com.pet.model.ReviewDTO;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

public class UpdateReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 리뷰 수정 전 원래 내용을 가져오는 비지니스 로직

		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		int pnum = Integer.parseInt(request.getParameter("Pnum").trim());
		int snum = Integer.parseInt(request.getParameter("no").trim());

		ReviewDAO dao = ReviewDAO.getInstance();

		ReviewDTO dto = dao.selectMyReview(userId, snum, pnum);

		ActionForward forward = new ActionForward();

		SalesDAO sDao = SalesDAO.getInstance();
		SalesDTO sDto = sDao.selectSaleProductcont(pnum, snum, userId);

		request.setAttribute("sales", sDto);

		request.setAttribute("review", dto);

		forward.setRedirect(false);
		forward.setPath("user/updateReview.jsp");

		return forward;
	}

}
