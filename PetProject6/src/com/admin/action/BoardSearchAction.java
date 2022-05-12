package com.admin.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.BoardDAO;
import com.pet.model.BoardDTO;

public class BoardSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)  {
		// TODO Auto-generated method stub
		
		String search_field = request.getParameter("search_field").trim();
		
		String search_keyword = request.getParameter("search_keyword").trim();
		
		int rowsize = 5;
		int block = 5;
		int totalRecord = 0;
		int allPage = 0;
		
		int page = 0;
		
		if(request.getParameter("page") !=null) {
	        page = Integer.parseInt(request.getParameter("page").trim());      
		}else {
			page = 1;
		}
		
		int startNo = (page * rowsize) - (rowsize - 1);
		
		int endNo = (page * rowsize);		
		
		int startBlock = (((page -1 ) / block) * block ) + block;
		
		int endBlock = (((page - 1)/block)*block)+block;
		
		BoardDAO dao = BoardDAO.getInstance();
		
		totalRecord = dao.searchListCount(search_field, search_keyword);
		
		allPage = (int)Math.ceil(totalRecord/(double)rowsize);
		
		if(endBlock > allPage) {
			endBlock = allPage;
		}
		
		List<BoardDTO> searchList =
				dao.searchBoardList(search_field, search_keyword, page, rowsize);
	
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("search_field", search_field);
		request.setAttribute("search_keyword", search_keyword);
		request.setAttribute("List", searchList);

		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
        
		forward.setPath("board/board_search.jsp");
	
		return forward;
	}
      
}
