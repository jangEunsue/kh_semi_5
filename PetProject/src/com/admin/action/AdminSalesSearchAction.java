package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

public class AdminSalesSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 검색 폼 페이지에서 넘어온 데이터를 가지고 검색어에 해당하는
		// 게시물들을 화면에 보여줘야 함.

		String searchDateStart = request.getParameter("searchDate_start").trim();
		String searchDateEnd = request.getParameter("searchDate_end").trim();
		String searchPname = request.getParameter("searchPname").trim();

		SalesDAO dao = SalesDAO.getInstance();

		System.out.println(searchDateStart);
		System.out.println(searchDateEnd);
		System.out.println(searchPname);

		if (!(searchDateStart.equals(""))) {
			searchDateStart = searchDateStart.substring(2, 4) + "/" + searchDateStart.substring(5, 7) + "/"
					+ searchDateStart.substring(8, 10);
		}

		if (!(searchDateEnd.equals(""))) {
			searchDateEnd = searchDateEnd.substring(2, 4) + "/" + searchDateEnd.substring(5, 7) + "/"
					+ searchDateEnd.substring(8, 10);
		}

		List<SalesDTO> list = dao.searchSalesList(searchDateStart, searchDateEnd, searchPname);

		int psum = dao.getSalesPsum(searchDateStart, searchDateEnd, searchPname);
		int transcostsum = dao.getSalesTranscostsum(searchDateStart, searchDateEnd, searchPname);
		int sumall = dao.getSalesSumall(searchDateStart, searchDateEnd, searchPname);

		searchDateStart = request.getParameter("searchDate_start").trim();
		searchDateEnd = request.getParameter("searchDate_end").trim();

		PrintWriter out = response.getWriter();

		ActionForward forward = new ActionForward();

		if(!(searchDateStart.equals("")) && !(searchDateEnd.equals(""))) {
			if(Integer.parseInt(searchDateStart.substring(2, 4) + searchDateStart.substring(5, 7)
									+ searchDateStart.substring(8, 10)) 
									> 
				Integer.parseInt(searchDateEnd.substring(2, 4) + searchDateEnd.substring(5, 7)
									+ searchDateEnd.substring(8, 10))) {
				 out.println("<script>"); 
				 out.println("alert('기간을 제대로 입력해주십시오.')");
				 out.println("history.back()"); 
				 out.println("</script>"); 
				 
			 } else {
				request.setAttribute("psum", psum);
				request.setAttribute("transcostsum", transcostsum);
				request.setAttribute("sumall", sumall);
				request.setAttribute("searchDateStart", searchDateStart);
				request.setAttribute("searchDateEnd", searchDateEnd);
				request.setAttribute("searchPname", searchPname);
				request.setAttribute("List", list);
			
				forward.setRedirect(false);
				forward.setPath("admin1/admin_sales_search.jsp");
			 }
		} else {
			
			request.setAttribute("psum", psum);
			request.setAttribute("transcostsum", transcostsum);
			request.setAttribute("sumall", sumall);
			request.setAttribute("searchDateStart", searchDateStart);
			request.setAttribute("searchDateEnd", searchDateEnd);
			request.setAttribute("searchPname", searchPname);
			request.setAttribute("List", list);
		
			forward.setRedirect(false);
			forward.setPath("admin1/admin_sales_search.jsp");
		}
		
		return forward;
	}

}
