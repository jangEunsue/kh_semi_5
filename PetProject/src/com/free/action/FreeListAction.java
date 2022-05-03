package com.free.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.FreeBoardDAO;
import com.pet.model.FreeBoardDTO;

public class FreeListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int rowsize=5;				// 한 페이지 당 보여질 게시물의 수
		int block = 5;				// 아래에 보여질 페이지의 최대 수 - 예) [1][2][3] / [4][5][6]
		
		int totalRecord = 0;		// DB상의 게시물의 전체 수
		int allPage = 0;			// 전체 페이지 수
		
		
		int page = 0;				// 현재 페이지 변수
		
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page").trim());
			//nmull이 아니라면 파라미터로 받은 값을 page에 넣어줌
		}else { //처음으로 "전체 게시물 목록" a태그를 선택한 경우
			page = 1;
		}
		
		//해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize-1);
		//1페이지 * 3 - (3-1); = 3 - 2 = 1번 게시물 부터 보여짐
		//2페이지 * 3 - (3-1) = 6 - 2 = 4번 게시물부터 보여짐
		
		//해당 페이지에서의 끝 번호
		int endNo = (page * rowsize);
		
		//해당 페이지에서 시작 블럭
		int startBlock = (((page - 1) / block)*block)+1;

		//해당 페이지에서 마지막 블럭
		int endBlock = (((page - 1) / block)*block)+block;
		
		FreeBoardDAO dao = FreeBoardDAO.getInstance();
		
		//DB상의 전체 게시물의 수를 확인하는 메서드 호출
		totalRecord = dao.getFreeCount();
		
		//전체 게시물의 수를 한 페이지 당 보여질 게시물의 수로 나누어 주어야 함.
		// 이 과정을 거치면 전체 페이지 수가 나오게 됨.
		// 전체 페이지 수가 나올 때 나머지가 있으면 부조건 페이지 수를 하나 올려주어야 함
		//ceil메서드는 무조건 하나 올려주는 메서드. double형임 그래서 int타입인rowsize를 형변환 시켜주고
		//allpage변수가 int타입이므로 math함수도 형변환 해준다
		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
		
		if(endBlock > allPage) {
			endBlock = allPage;
		}
		
		//현재 페이지에 해당하는 게시물을 가져오는 메서드 인자도 같이 넘어야가함.
		List<FreeBoardDTO> pageList = dao.getFreeList(page, rowsize);
		
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("List", pageList);
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("freeboard/free_list.jsp");
		
		return forward;
	}

}
