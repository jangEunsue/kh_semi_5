package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.OrderDAO;
import com.pet.model.OrderDTO;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

public class AdminOrderTransAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		session.getAttribute("adminId");
		 
		
		OrderDAO o_dao = OrderDAO.getInstance();
	
		List<OrderDTO> o_list = o_dao.selectOrder();
		
		SalesDAO dao = SalesDAO.getInstance();
		
		List<SalesDTO> list = dao.getSalesList();
		
		
		
		request.setAttribute("list", list);
		request.setAttribute("o_dao", o_dao);
		
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin1/admin_order_trans.jsp");
		
		return forward;
	}

}
