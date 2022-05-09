package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

public class AdminSalesListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 결제 테이블 DB에 저장된 전체 목록을 조회하여
		// 매출 관리 페이지(view page)로 이동시키는 비지니스 로직.
		
		SalesDAO dao = SalesDAO.getInstance();
		
		List<SalesDTO> list = dao.getSalesList();
		
		int psum = dao.getSalesPsum();
		int transcostsum = dao.getSalesTranscostsum();
		int sumall = dao.getSalesSumall();
		
		request.setAttribute("salesList", list);
		request.setAttribute("psum", psum);
		request.setAttribute("transcostsum", transcostsum);
		request.setAttribute("sumall", sumall);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin/admin_sales_list.jsp");
		
		return forward;
	}

}
