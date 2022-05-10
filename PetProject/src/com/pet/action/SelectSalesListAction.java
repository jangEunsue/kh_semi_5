package com.pet.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ProductDAO;
import com.pet.model.ReviewDAO;
import com.pet.model.ReviewDTO;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

import oracle.net.aso.l;

public class SelectSalesListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 아이디에 맞게 주문 내역을 조회하는 메서드
		
		HttpSession session =  request.getSession(); //세션 정보 가져오기
		String userId = (String)session.getAttribute("userId"); //세션에서 받아온 ID
		
		ActionForward forward = new ActionForward();
		
		if(userId.equals(null)) {
			forward.setRedirect(true);
			forward.setPath("pet_login.do");
		}else {
			
	
		SalesDAO dao = SalesDAO.getInstance();
		System.out.println(userId);
		
		List<SalesDTO> list = dao.selectUserSale(userId);
		List<SalesDTO> date = dao.selectUserSaleDate(userId);
		
		System.out.println(list);
		
		request.setAttribute("sales", list);
		request.setAttribute("date", date);
		
		
		
		forward.setRedirect(false);
		forward.setPath("user/selectSalesList.jsp");
		}
		
		
		return forward;
	}

}
