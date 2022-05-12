package com.pet.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.controller.Action;
import com.pet.controller.ActionForward;
import com.pet.model.CartDAO;
import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;
import com.pet.model.SalesDAO;
import com.pet.model.SalesDTO;

public class PaymentOkACtion implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		
		String sales_id = (String)session.getAttribute("sessionID");
		
		String[] sales_no = request.getParameterValues("sales_no");
		String[] sales_pno = request.getParameterValues("sales_pno");
		String[] sales_qty = request.getParameterValues("sales_qty");
		String sales_phone = request.getParameter("phone").trim();
		int user_addr_no = Integer.parseInt(request.getParameter("user_addr_no").trim());
		String user_addr1 = request.getParameter("user_addr1").trim();
		String user_addr2 = request.getParameter("user_addr2").trim();
		String user_addr3 = request.getParameter("user_addr3").trim();
		String sales_addr = "("+user_addr_no+") "+user_addr1 + " " + user_addr2 + " " + user_addr3; 
		String sales_name = request.getParameter("name").trim();
		String sales_comments = request.getParameter("comments").trim();
		String sales_payment = request.getParameter("payment").trim();
		String cart_ids = request.getParameter("cart_ids");
		String type = request.getParameter("type");
		int sales_transcost = Integer.parseInt(request.getParameter("transcost"));
		int sales_mileage = Integer.parseInt(request.getParameter("mileage").trim());
		int sales_total = Integer.parseInt(request.getParameter("total").trim());	
		
		
		ProductDAO productDao = ProductDAO.getInstance();
		SalesDAO salesDao = SalesDAO.getInstance();
		
		int serialMaxNum = salesDao.getMaxSerial();
		
		int result = 1, totalQty=0;
		
		for(int i=0; i<sales_pno.length; i++) {
			int pnum = Integer.parseInt(sales_pno[i]);
			int pqty = Integer.parseInt(sales_qty[i]);
			ProductDTO product = productDao.selectProductcont(pnum);
			SalesDTO salesDto = new SalesDTO();
			
			salesDto.setSales_id(sales_id);
			salesDto.setSales_name(sales_name);
			salesDto.setSales_addr(sales_addr);
			salesDto.setSales_phone(sales_phone);
			salesDto.setSales_comments(sales_comments);
			salesDto.setSales_mileage(sales_mileage);
			salesDto.setSales_payment(sales_payment);
			salesDto.setSales_p_no(product.getP_num());
			salesDto.setSales_pimage(product.getP_image());
			salesDto.setSales_pname(product.getP_name());
			salesDto.setSales_pqty(pqty);
			salesDto.setSales_price(product.getP_price());
			salesDto.setSales_transcost(sales_transcost);
			salesDto.setSales_serial(serialMaxNum);
			
			salesDao.insertSales(salesDto);
			
			totalQty += pqty;
			
			
			if(result < 0) {
				break;
			}
			
		}
		
		PrintWriter out = response.getWriter();
		ActionForward forward = new ActionForward();
		
		if(result > 0) {
			
			if(type.equals("cart")) {
				String[] cartIds = cart_ids.split(",");
				CartDAO cartDao = CartDAO.getInstance();
				
				for(int i=0; i<cartIds.length; i++) {
					int cartId = Integer.parseInt(cartIds[i]);
					cartDao.deleteCart(cartId);
				}
			}
			String payment = "";
			if(sales_payment == "credit") {
				payment = "신용카드";
			}else if(sales_payment == "account") {
				payment = "무통장 입금";
			}else {
				payment="휴대폰 결제";
			}
			
			request.setAttribute("payment", payment);
			request.setAttribute("sales_uid", sales_id);
			request.setAttribute("sales_total", sales_total);
			request.setAttribute("sales_transcost", sales_transcost);
			request.setAttribute("sales_phone", sales_phone);
			request.setAttribute("sales_name", sales_name);
			request.setAttribute("sales_addr", sales_addr);
			request.setAttribute("sales_serial", serialMaxNum);
			request.setAttribute("total_qty", totalQty);
			
			forward.setRedirect(false);
			forward.setPath("user/payment_list.jsp");
		}else {
			out.println("<script>");
			out.println("alert('결제 실패 - 상품등록')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
