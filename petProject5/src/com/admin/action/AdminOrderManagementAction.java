package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.coyote.Request;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;

public class AdminOrderManagementAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		session.getAttribute("adminId");
		forward.setRedirect(false);
		forward.setPath("admin1/admin_order_mg.jsp");
		return forward;
	}

}
