package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ProductDAO;

public class AdminProductDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// get 방식으로 넘어온 제품번호에 해당하는 제품을
		// DB에서 삭제하는 비지니스 로직.
		
		int product_num = Integer.parseInt(request.getParameter("p_num").trim());
		int nowPage = 
				Integer.parseInt(request.getParameter("page").trim());

		ProductDAO dao = ProductDAO.getInstance();
		
		int check = dao.deleteProduct(product_num);
		
		request.setAttribute("page", nowPage);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			forward.setRedirect(true);
			forward.setPath("admin_product_list.do?page="+nowPage);
		} else {
			out.println("<script>");
			out.println("alert('제품 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
