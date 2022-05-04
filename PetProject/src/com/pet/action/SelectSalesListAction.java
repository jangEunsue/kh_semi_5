package com.pet.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ProductDAO;
import com.pet.model.ReviewDAO;
import com.pet.model.ReviewDTO;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

public class SelectSalesListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 아이디에 맞게 주문 내역을 조회하는 메서드
		
		String userId = request.getParameter("userId").trim(); //세션에서 받아온 ID
		
		SalesDAO dao = SalesDAO.getInstance();
		
		List<SalesDTO> list = dao.selectUserSale(userId);
		
		request.setAttribute("sales", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("user/selectSalesList.jsp");
		
		return forward;
	}

}
