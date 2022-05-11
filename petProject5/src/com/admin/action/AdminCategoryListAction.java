package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.KindCategoryDAO;
import com.pet.model.KindCategoryDTO;

public class AdminCategoryListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 카테고리 테이블 전체를 조회하여 
		// view page로 이동시키는 비지니스 로직.
		
		KindCategoryDAO dao = KindCategoryDAO.getInstance();
		
		List<KindCategoryDTO> list = dao.getKindCategoryList();
		
		request.setAttribute("categoryList", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("admin1/admin_category_list.jsp");
		
		return forward;
	}

}
