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

public class AdminOrderTransUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int serial_no = (int)request.getAttribute("serial_no");
		OrderDAO o_dao = OrderDAO.getInstance();
		
		if(serial_no == 0 ) {
			o_dao.completePay(serial_no);
		}else if(serial_no == 1) {
			o_dao.canclePay(serial_no);
		}

		 
		List<OrderDTO> o_list = o_dao.selectOrder();
		SalesDAO dao = SalesDAO.getInstance();
		
		List<SalesDTO> list = dao.getSalesList();
		
		
		
		request.setAttribute("list", list);
		request.setAttribute("o_dao", o_dao);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin1/admin_order_mg.jsp");
		
		return forward;
	}

}
