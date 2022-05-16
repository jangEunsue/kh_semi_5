package com.admin.action;

import java.io.IOException;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.OrderDAO;
import com.pet.model.OrderDTO;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

public class AdminOrderSalesUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int p_order_pay = Integer.parseInt(request.getParameter("p_order_pay"));
		int serial_no = Integer.parseInt(request.getParameter("serial_no"));
		OrderDAO o_dao = OrderDAO.getInstance();
		
		if(p_order_pay == 0 ) {
			o_dao.completePay(p_order_pay);
		}else if(p_order_pay == 1) {
			o_dao.canclePay(p_order_pay);
		}

		 
		List<OrderDTO> o_list = o_dao.selectOrder();
		SalesDAO dao = SalesDAO.getInstance();
		
		List<SalesDTO> list = dao.getSalesList();
		
		
		
		request.setAttribute("list", list);
		request.setAttribute("o_dao", o_dao);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(true);
		forward.setPath("admin1/admin_order_mg.jsp");
		
		return forward;
	}

}
