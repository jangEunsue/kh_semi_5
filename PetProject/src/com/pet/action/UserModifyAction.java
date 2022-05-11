package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.PetMemberDAO;
import com.pet.model.PetMemberDTO;

public class UserModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		String user_pwd = request.getParameter("user_pwd").trim();
		String db_pwd = request.getParameter("db_pwd");
		
		int m_num = Integer.parseInt(request.getParameter("num").trim());
		
		ActionForward forward = new ActionForward();
		PrintWriter out = response.getWriter();
		
		if (user_pwd.equals(db_pwd)) {
			PetMemberDAO dao = PetMemberDAO.getInstance();
			
			PetMemberDTO dto = dao.getMember(m_num);
			
			
			request.setAttribute("modify", dto);
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
			
			forward.setRedirect(false);
			forward.setPath("user/member_modify.jsp");
			return forward;
		}else {
			out.println("<script>");
			out.println("alert('비밀번호를 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
		
	}

}
