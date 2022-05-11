package com.pet.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;

public class SelectProductListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String petKind = request.getParameter("petKind").trim();
		
		//데이터 카테고리 번호로 변환
		switch (petKind) {
		case "01":
			petKind = "P0000001";
			break;
		case "02":
			petKind = "P0000002";
			break;
		case "03":
			petKind = "P0000003";
			break;
		case "04":
			petKind = "P0000004";
			break;
		case "05":
			petKind = "P0000005";
			break;
		case "06":
			petKind = "P0000006";
			break;
		case "07":
			petKind = "P0000007";
			break;
		case "08":
			petKind = "P0000008";
			break;
		case "09":
			petKind = "P0000009";
			break;

		default:
			petKind = null;
			break;
		}
		
		System.out.println(petKind);

		ProductDAO dao = ProductDAO.getInstance();
		
		List<ProductDTO> feedList = dao.selectProductAboutPetKind("E0000001",petKind); //사료
		List<ProductDTO> stickList = dao.selectProductAboutPetKind("E0000002",petKind); //스틱
		List<ProductDTO> biscuitList = dao.selectProductAboutPetKind("E0000003",petKind); //비스킷
		List<ProductDTO> beefJerkyList = dao.selectProductAboutPetKind("E0000004",petKind); //육포
		List<ProductDTO> canList = dao.selectProductAboutPetKind("E0000005",petKind); //캔
		List<ProductDTO> treatList = dao.selectProductAboutPetKind("E0000006",petKind); //트릿
		List<ProductDTO> milkList = dao.selectProductAboutPetKind("E0000007",petKind); //펫밀크
		
		request.setAttribute("feed", feedList);
		request.setAttribute("stick", stickList);
		request.setAttribute("biscuit", biscuitList);
		request.setAttribute("beefJerky", beefJerkyList);
		request.setAttribute("can", canList);
		request.setAttribute("treat", treatList );
		request.setAttribute("milk", milkList );
		
		//test
		for(int i = 0; i < feedList.size() ; i ++ ) {
			System.out.println("feed" + feedList.get(i));
		}
		for(int i = 0; i < stickList.size() ; i ++ ) {
			System.out.println( "stick" + stickList.get(i));
		}
		for(int i = 0; i < biscuitList.size() ; i ++ ) {
			System.out.println( "biscuit" + biscuitList.get(i));
		}
		for(int i = 0; i < beefJerkyList.size() ; i ++ ) {
			System.out.println( "beef" + beefJerkyList.get(i));
		}
		for(int i = 0; i < canList.size() ; i ++ ) {
			System.out.println("can" + canList.get(i));
		}
		for(int i = 0; i < treatList.size() ; i ++ ) {
			System.out.println( "treat" + treatList.get(i));
		}
		for(int i = 0; i < milkList.size() ; i ++ ) {
			System.out.println("milk" + milkList.get(i));
		}
		
		ActionForward forward = new ActionForward();
	 
		forward.setRedirect(false);
		forward.setPath("user/productListForPetKind.jsp");
		
		
		return forward;
	}

}
