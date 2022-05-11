package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.CartDAO;
import com.pet.model.CartDTO;

public class CartAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		
		String m_id = (String)session.getAttribute("userId");
		
		String cart_pname = request.getParameter("p_name").trim();
		
		int cart_price = Integer.parseInt(request.getParameter("p_price").trim());
		
		int cart_pqty = Integer.parseInt(request.getParameter("pqty").trim());
		
		int cart_pno = Integer.parseInt(request.getParameter("p_num").trim());
		
		String cart_pspec = request.getParameter("p_spec").trim();
		
		String cart_pimage = request.getParameter("p_image").trim();
		
		int cart_point =  Integer.parseInt(request.getParameter("p_point").trim());
		
		String cart_id = request.getParameter("m_id").trim();
		
		
		
		CartDTO dto = new CartDTO();
		
		dto.setCart_pno(cart_pno);
		dto.setCart_pname(cart_pname);
		dto.setCart_Id(cart_id);
		dto.setCart_price(cart_price);
		dto.setCart_pqty(cart_pqty);
		dto.setCart_pspec(cart_pspec);
		dto.setCart_pimage(cart_pimage);
		dto.setCart_point(cart_point);
		
		CartDAO dao = CartDAO.getInstance();
		
		int check  = 0;
		
		check = dao.updateCartPqty(dto, m_id);
		
		if(check == 0) {
			check = dao.insertCart(dto);
		}
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(check>0) {
			forward.setRedirect(true);
			forward.setPath("cart_list.do");
		}else {
			out.println("<script>");
			out.println("alert('서버 오류 - 장바구니 저장 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
