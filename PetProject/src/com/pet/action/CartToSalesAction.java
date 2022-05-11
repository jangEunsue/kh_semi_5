package com.pet.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.CartDAO;
import com.pet.model.CartDTO;
import com.pet.model.PetMemberDAO;
import com.pet.model.PetMemberDTO;

public class CartToSalesAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		String sales_id = (String)session.getAttribute("userId");
		
		String[] checkboxes = request.getParameterValues("check");
		String[] pqtys = request.getParameterValues("pqty");
		
		PetMemberDAO memberDao = PetMemberDAO.getInstance();
		
		CartDAO cartDao = CartDAO.getInstance();
		
		PetMemberDTO member = memberDao.getMember(sales_id);
		
		List<CartDTO> list = new ArrayList<CartDTO>();
		
		int total = 0, point = 0;
		
		for(int i = 0; i < checkboxes.length; i++) {
			CartDTO cart = cartDao.getSales(checkboxes[i]);
			int pqty = Integer.parseInt(pqtys[i]);
			int price = cart.getCart_price();
			
			total += price * pqty;
			point += (price * pqty) * 0.01;
			
			cart.setCart_pqty(pqty);
			list.add(cart);
		}
		int transcost = total > 50000 ? 0 : 3000;
		
		String cartIds = String.join(",", checkboxes);
		
		request.setAttribute("cartIds", cartIds);
		request.setAttribute("total", total);
		request.setAttribute("point", point);
		request.setAttribute("transcost", transcost);
		request.setAttribute("memberInfo", member);
		request.setAttribute("salesList", list);
		request.setAttribute("type", "cart");
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user/sales_list.jsp");
		
		return forward;
	}

}
