package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;

public class AdminProductUpdateOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 상품 수정 폼 페이지에서 넘어온 데이터들을 
		// DB에 저장하는 비지니스 로직.
		
		// 첨부파일이 저장될 위치(경로)를 설정.
		String saveFolder = 
				"C:\\NCS\\workspace(jsp)\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\petProject5\\upload";
		
		// 첨부파일 용량(크기) 제한 - 파일 업로드 최대 크기
		int fileSize = 50 * 1024 * 1024;	// 50MB
		
		// 이지파일 업로드를 위한 객체 생성
		MultipartRequest multi = new MultipartRequest(
				request, 
				saveFolder, 
				fileSize,
				"UTF-8",
				new DefaultFileRenamePolicy()
				);
				
		// 수정 폼 페이지에서 넘어온 데이터들을 받아주자.
		int p_num = Integer.parseInt(multi.getParameter("p_num").trim());
		
		String product_category = multi.getParameter("p_category").trim();
		String p_name = multi.getParameter("p_name").trim();
		int p_price = Integer.parseInt(multi.getParameter("p_price").trim());
		int p_point = Integer.parseInt(multi.getParameter("p_point").trim());
		int p_qty = Integer.parseInt(multi.getParameter("p_qty").trim());
		String p_wetdry = multi.getParameter("p_wetdry").trim();
		String kind_category = multi.getParameter("kind_category").trim();
		String p_age = multi.getParameter("p_age").trim();
		String p_size = multi.getParameter("p_size").trim();
		String p_neutering = multi.getParameter("p_neutering").trim();
		String p_content = multi.getParameter("p_content").trim();
		String p_company = multi.getParameter("p_company").trim();
		String p_spec = multi.getParameter("p_spec").trim();
		int nowPage = 
				Integer.parseInt(multi.getParameter("page").trim());
		
		// getFilesystemName() : 서버 상에 실제로 업로드될 파일의 이름을 문자열로 반환
		String p_image_new = multi.getFilesystemName("p_image_new");
		
		if(multi.getFilesystemName("p_image_new") == null) {	// 수정할 첨부파일 이미지가 없는 경우
			p_image_new = multi.getParameter("p_image_old");
		}
		
		ProductDTO dto = new ProductDTO();
		
		dto.setP_num(p_num);
		dto.setP_name(p_name);
		dto.setP_category_fk(product_category);
		dto.setP_age(p_age);
		dto.setP_kind_fk(kind_category);
		dto.setP_wetdry(p_wetdry);
		dto.setP_size(p_size);
		dto.setP_neutering(p_neutering);
		dto.setP_company(p_company);
		dto.setP_image(p_image_new);
		dto.setP_price(p_price);
		dto.setP_qty(p_qty);
		dto.setP_spec(p_spec);
		dto.setP_content(p_content);
		dto.setP_point(p_point);
		
		ProductDAO dao = ProductDAO.getInstance();
		
		int check = dao.updateProduct(dto);
		
		ActionForward forward = new ActionForward();
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			forward.setRedirect(true);
			forward.setPath("admin_product_list.do?page="+nowPage);	// 상품 목록 컨트롤러로 이동		
		} else {
			out.println("<script>");
			out.println("alert('상품 정보 수정 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
