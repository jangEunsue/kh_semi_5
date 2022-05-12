package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetMemberDAO;


public class UserIdCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String user_id = request.getParameter("id");
		
		PetMemberDAO dao = PetMemberDAO.getInstance();
		int res = dao.petIdCheck(user_id);
		
		PrintWriter out = response.getWriter();
		
		if (res == 0) {
			out.println("0");
		}else {
			out.println("1"); // 아이디 중복
		}
		
		System.out.println("res : " + res);
		return null;
	}

}
