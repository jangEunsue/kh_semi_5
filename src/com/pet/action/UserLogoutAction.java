package com.pet.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;

public class UserLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		
		session.invalidate(); // 모든 세션 정보를 만료시키는 메서드
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("index.jsp");
		
		return forward;
	}

}
