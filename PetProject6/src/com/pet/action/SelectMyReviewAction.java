package com.pet.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;
import com.pet.model.ReviewDAO;
import com.pet.model.ReviewDTO;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

public class SelectMyReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 아이디와 상품번호를 이용해 주문한 상품의 리뷰를 확인하는 비지니스 로직
		
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("sessionID");
		int no = Integer.parseInt(request.getParameter("no").trim());
		int pnum = Integer.parseInt(request.getParameter("pno").trim());
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		ReviewDTO dto = dao.selectMyReview(userId, no, pnum);
		
		ActionForward forward = new ActionForward();
		
		SalesDAO sDao = SalesDAO.getInstance();
		SalesDTO sDto = sDao.selectSaleProductcont(pnum ,no, userId);
		
		request.setAttribute("sales", sDto);
		
		if(dto.getReview_cont() == null) {//리뷰 작성 전이라면
			forward.setRedirect(false);
			forward.setPath("user/insertReview.jsp");
		}else {//리뷰 작성 후 라면
			
			request.setAttribute("review", dto);
			
			forward.setRedirect(false);
			forward.setPath("user/selectMyreview.jsp");
		}
			
		return forward;
	}

}
