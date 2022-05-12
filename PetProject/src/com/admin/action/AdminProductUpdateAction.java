package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.KindCategoryDAO;
import com.pet.model.KindCategoryDTO;
import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;

public class AdminProductUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// get 방식으로 넘어온 제품번호에 해당하는 제품의 상세 내역을
		// DB에서 조회하여 수정 폼 페이지(view page)로 이동시키는 비지니스 로직.
		
		int product_num =
				Integer.parseInt(request.getParameter("p_num").trim());
		int nowPage = 
				Integer.parseInt(request.getParameter("page").trim());
		
		ProductDAO dao = ProductDAO.getInstance();
		
		ProductDTO dto = dao.productContent(product_num);
		
		request.setAttribute("productCont", dto);
		
		KindCategoryDAO kdao = KindCategoryDAO.getInstance();
		
		List<KindCategoryDTO> kindCategoryList = kdao.getKindCategoryList(); 
		
		request.setAttribute("KindCategory", kindCategoryList);
		request.setAttribute("page", nowPage);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin1/admin_product_update.jsp");
		
		return forward;
	}

}
