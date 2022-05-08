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
import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;

public class InsertCartAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 카트에 상품을 넣는 비지니스 로직

		HttpSession session = request.getSession();

		String userId = (String) session.getAttribute("userId");
		int p_num = Integer.parseInt(request.getParameter("no").trim());
		int pqty = Integer.parseInt(request.getParameter("qty").trim());

		
		ActionForward forward = new ActionForward();
		
		// 회원이 아닌 경우
		if (userId == null) {
			forward.setRedirect(true);
			forward.setPath("pet_login.do");

		} else {

			// 상품 정보 조회
			ProductDAO pDao = ProductDAO.getInstance();
			ProductDTO product = pDao.selectProductcont(p_num);

			// cart에 상품 담기
			CartDAO cDao = CartDAO.getInstance();

			CartDTO cDto = new CartDTO();

			cDto.setCart_Id(userId);
			cDto.setCart_pcont(product.getP_content());
			cDto.setCart_pimage(product.getP_image());
			cDto.setCart_pimage(product.getP_image());
			cDto.setCart_pname(product.getP_name());
			cDto.setCart_pno(p_num);
			cDto.setCart_pqty(pqty);
			cDto.setCart_price(product.getP_price());

			int check = cDao.InsertCart(cDto);


			PrintWriter out = response.getWriter();

			if (check > 0) {
				forward.setRedirect(true);
				forward.setPath("cart_list.do");

			} else {
				out.println("<script>");
				out.println("alert('장바구니 추가 실패')");
				out.println("history.back()");
				out.println("</script>");
			}
		}
		return forward;
	}

}
