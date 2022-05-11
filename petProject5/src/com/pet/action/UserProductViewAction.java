package com.pet.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;
import com.pet.model.ReviewDAO;
import com.pet.model.ReviewDTO;

public class UserProductViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//제품의 상세 정보를 조회하는 메서드
		
		int no = Integer.parseInt(request.getParameter("pnum").trim());
		
		ProductDAO dao = ProductDAO.getInstance();
		ProductDTO dto = dao.selectProductcont(no);
		
		
		ReviewDAO rdao = ReviewDAO.getInstance();
		List<ReviewDTO> review = rdao.selectReview(no);
		
		request.setAttribute("cont", dto);
		request.setAttribute("review", review);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("user/contProduct.jsp");
		
		return forward;
	}

}
