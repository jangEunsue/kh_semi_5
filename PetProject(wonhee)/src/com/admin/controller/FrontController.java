package com.admin.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class FrontController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		
		// 한글 인코딩 처리
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		// getRequestURI() : "/프로젝트명/파일명(*.do)" 라는 문자열을
		//                   반환해 주는 메서드.
		String uri = request.getRequestURI();
		System.out.println("URI >>> " + uri);
		
		// getContextPath() : 현재 프로젝트명을 문자열로 반환해 주는 메서드.
		String path = request.getContextPath();
		System.out.println("Path >>> " + path);
		
		// command 문자열 변수에는 *.do만 반환이 됨.
		String command = uri.substring(path.length() + 1);
		System.out.println("Command >>> " + command);
		
		Action action = null;
		ActionForward forward = null;
		
		Properties prop = new Properties();

		
		FileInputStream fis = 
				new FileInputStream("C:\\NCS\\workspace(jsp)\\PetProject_Admin\\src\\com\\admin\\controller\\mapping.properties");
		
		prop.load(fis);
		
		String value = prop.getProperty(command);
		System.out.println("value >>> " + value);
		
		if(value.substring(0, 7).equals("execute")) {
			StringTokenizer st = new StringTokenizer(value, "|");
			String url_1 = st.nextToken();  // "execute"
			String url_2 = st.nextToken();  // "패키지명.클래스명"
			
			try {
				Class url = Class.forName(url_2);
				
				// 동적으로 객체를 생성하는 방법
				action = (Action)url.newInstance();
				// 비지니스 로직을 실행하는 메서드 호출
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {  // value 값이 "execute" 가 아닌 경우
			// view page로 이동
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath(value);
		}
		
		
		if(forward != null) {
			if(forward.isRedirect()) {  // true인 경우
				response.sendRedirect(forward.getPath());
			}else {  // false인 경우 view page로 이동
				RequestDispatcher rd = 
						request.getRequestDispatcher(forward.getPath());
				
				rd.forward(request, response);
			}
		}
		
	}

}
