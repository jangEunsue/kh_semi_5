package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.controller.Action;
import com.admin.controller.ActionForward;
import com.pet.model.BoardDAO;
import com.pet.model.BoardDTO;

public class BoardListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		int rowsize = 3;        // 한 페이지당 보여질 게시물의 수
		int block = 3;          // 아래에 보여질 페이지의 최대 수 - 예) [1] [2] [3] /[4],[5],[6]
        int totalRecord = 0;    // DB 상의 게시물의 전체 수
		int allPage = 0;        // 전체 페이지 수
		
		int page = 0;           // 현제 페이지 변수
		
		if(request.getParameter("page") !=null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}else {  // 처음으로 "전체 게시물 목록" a 태그를 선택한 경우
			page = 1;
		}
		
		        // 해당 페이지에서 시작 번호
				int startNo = (page * rowsize) - (rowsize - 1);
				
				// 해당 페이지에서 끝 번호
				int endNo = (page * rowsize);
						
				// 해당 페이지에서 시작 블럭
				int startBlock = (((page - 1) / block) * block) + 1;
				
				// 해당 페이지에서 끝 블럭
				int endBlock = (((page - 1) / block) * block) + block;	
				
				BoardDAO dao = BoardDAO.getInstance();
				
				totalRecord = dao.getBoardCount();
				
				allPage = (int)Math.ceil(totalRecord / (double)rowsize);
				
				if(endBlock > allPage) {
					endBlock = allPage;
				}
				
				List<BoardDTO> pageList = dao.getBoardList(page, rowsize);
				
	}

}
