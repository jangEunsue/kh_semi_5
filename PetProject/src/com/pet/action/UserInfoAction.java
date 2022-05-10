package com.pet.action;

import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetMemberDAO;
import com.pet.model.PetMemberDTO;

public class UserInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userID = request.getParameter("id").trim();		
		PetMemberDAO dao = PetMemberDAO.getInstance();
		
		PetMemberDTO dto = dao.getMember(userID);
		
		request.setAttribute("Info", dto);
		StringTokenizer stBirth = new StringTokenizer(dto.getM_birth(), "/");
		int birthyy = Integer.parseInt(stBirth.nextToken());
		int birthmm = Integer.parseInt(stBirth.nextToken());
		int birthdd = Integer.parseInt(stBirth.nextToken());
		request.setAttribute("birthyy", birthyy);
		request.setAttribute("birthmm", birthmm);
		request.setAttribute("birthdd", birthdd);
		
		StringTokenizer stPhone = new StringTokenizer(dto.getM_phone(), "-");
		int phone1 = Integer.parseInt(stPhone.nextToken());
		int phone2 = Integer.parseInt(stPhone.nextToken());
		int phone3 = Integer.parseInt(stPhone.nextToken());
		request.setAttribute("phone1", phone1);
		request.setAttribute("phone2", phone2);
		request.setAttribute("phone3", phone3);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("user/member_info.jsp");
		
		System.out.println("forward>>" + forward);
		
		return forward;
	}

}
