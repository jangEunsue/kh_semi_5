package com.pet.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.CartDAO;
import com.pet.model.CartDTO;

public class CartListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		
		String userId = (String)session.getAttribute("sessionID");
		
		CartDAO dao = CartDAO.getInstance();
		
		List<CartDTO> list = dao.getCartList(userId);
		
		request.setAttribute("cartList", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user/cart_list.jsp");
		
		return forward;
	}

}