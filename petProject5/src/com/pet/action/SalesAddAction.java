package com.pet.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.CartDTO;
import com.pet.model.PetMemberDAO;
import com.pet.model.PetMemberDTO;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

public class SalesAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		
		String cart_id = (String)session.getAttribute("sessionID");
		
		String cart_pname = request.getParameter("p_name").trim();
		
		int cart_price = Integer.parseInt(request.getParameter("p_price").trim());
		
		int cart_pqty = Integer.parseInt(request.getParameter("pqty").trim());
		
		int cart_pno = Integer.parseInt(request.getParameter("p_num").trim());
		
		String cart_pimage = request.getParameter("p_image").trim();

		String cart_pspec = request.getParameter("p_spec").trim();
		
		int cart_point =  Integer.parseInt(request.getParameter("p_point").trim());
		
		PetMemberDAO memberDao = PetMemberDAO.getInstance();
		
		CartDTO dto = new CartDTO();
		PetMemberDTO member = memberDao.getMember(cart_id);
		
		
		List<CartDTO> list = new ArrayList<CartDTO>();
		
		dto.setCart_pno(cart_pno);
		dto.setCart_pimage(cart_pimage);
		dto.setCart_pname(cart_pname);
		dto.setCart_pqty(cart_pqty);
		dto.setCart_price(cart_price);
		dto.setCart_point(cart_point);
		dto.setCart_Id(cart_id);
		dto.setCart_pspec(cart_pspec);
		
		
		list.add(dto);
		
		int total=0, point=0;
		
		for(int i=0; i<list.size(); i++) {
			CartDTO cart = list.get(i);
			int price = cart.getCart_price();
			total += price * cart_pqty;
			point += (price * cart_pqty)* 0.01;
		}
		
		
		int transcost = total > 50000 ? 0 : 3000;
		
		request.setAttribute("total", total);
		request.setAttribute("point", point);
		request.setAttribute("transcost", transcost);
		request.setAttribute("salesList", list);
		request.setAttribute("memberInfo", member);
		request.setAttribute("type", "direct");
		
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("user/sales_list.jsp");

		return forward;
	}

}
