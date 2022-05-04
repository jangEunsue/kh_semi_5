package com.pet.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;

public class AllProductListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//모든 종류의 제품을 보여주는 비지니스 로직
		
		ProductDAO dao = ProductDAO.getInstance();
		
		List<ProductDTO> feedList = dao.selectAll("E0000001");
		List<ProductDTO> StickList = dao.selectAll("E0000002");
		List<ProductDTO> biscuitList = dao.selectAll("E0000003");
		List<ProductDTO> beefJerkyList = dao.selectAll("E0000004");
		List<ProductDTO> canList = dao.selectAll("E0000005");
		List<ProductDTO> treatList = dao.selectAll("E0000006");
		List<ProductDTO> milkList = dao.selectAll("E0000007");
		
		request.setAttribute("feed", feedList);
		request.setAttribute("stick", StickList);
		request.setAttribute("biscuit", biscuitList);
		request.setAttribute("beefJerky", beefJerkyList);
		request.setAttribute("can", canList);
		request.setAttribute("trear", treatList );
		request.setAttribute("milk", milkList );
		
		ActionForward forward = new ActionForward();
	 
		forward.setRedirect(false);
		forward.setPath("user/productAllPetKind.jsp");
		
		
		return forward;
	}

}
