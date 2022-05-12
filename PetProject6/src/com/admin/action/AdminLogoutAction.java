package com.admin.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;

public class AdminLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    //로그아웃
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		ActionForward forward = new ActionForward();
				
		forward.setRedirect(false);
		
		forward.setPath("main.jsp");
		
		return forward;
	}

}
