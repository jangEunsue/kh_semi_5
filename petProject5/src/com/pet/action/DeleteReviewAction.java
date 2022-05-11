package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ReviewDAO;

public class DeleteReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 리뷰를 삭제하는 비지니스 로직
		
		int no = Integer.parseInt(request.getParameter("no").trim());
		
		ReviewDAO dao = ReviewDAO.getInstance();
		int check = dao.deleteReview(no);
		
		ActionForward foward = new ActionForward();
		
		if(check > 0) {
			foward.setRedirect(true);
			foward.setPath("");
		}else {
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('리뷰 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		return foward;
	}

}
