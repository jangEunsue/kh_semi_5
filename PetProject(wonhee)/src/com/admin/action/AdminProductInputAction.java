package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.KindCategoryDAO;
import com.pet.model.KindCategoryDTO;
import com.pet.model.ProductCategoryDAO;
import com.pet.model.ProductCategoryDTO;

public class AdminProductInputAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 카테고리 코드 전체 리스트를 DB에서 조회하여
		// 상품 등록 폼 페이지(view page)로 이동시키는 비지니스 로직
		
		ProductCategoryDAO pdao = ProductCategoryDAO.getInstance();
		
		List<ProductCategoryDTO> productCategoryList = pdao.getProductCategoryList();
		
		request.setAttribute("ProductCategory", productCategoryList);
		
		KindCategoryDAO kdao = KindCategoryDAO.getInstance();
		
		List<KindCategoryDTO> kindCategoryList = kdao.getKindCategoryList(); 
		
		request.setAttribute("KindCategory", kindCategoryList);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin1/admin_product_input.jsp");
		
		return forward;
	}

}
