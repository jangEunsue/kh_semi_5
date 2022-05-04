package com.pet.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;

public class SelectSearchProductAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//상품 검색 기능을 수행하는 비지니스 로직
		
		String search_keyword = request.getParameter("search_keyword").trim();
		
		ProductDAO dao = ProductDAO.getInstance();
		
		List<ProductDTO> list = dao.searchProduct(search_keyword);
		
		request.setAttribute("list", list);
		
		ActionForward forward = new ActionForward();
		 
		forward.setRedirect(false);
		forward.setPath("user/searchProductList.jsp");
		
		return forward;
	}

}
