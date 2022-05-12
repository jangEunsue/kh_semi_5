package com.pet.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CartDAO {
	Connection con = null;             // DB 연결하는 객체.
	PreparedStatement pstmt = null;    // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                 // SQL문을 저장할 객체.
	
	
	// CartDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : CartDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static CartDAO instance = null;
	
	
	private CartDAO() {   }  // 기본생성자.
		
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	//        메서드를 만들어서 여기에 접근하게 해야 함.
	public static CartDAO getInstance() {
		
		if(instance == null) {
			instance = new CartDAO();
		}
		return instance;
		
	}  // getInstance() 메서드 end
	
	
	// DB를 연동하는 작업을 진행하는 메서드
	public void openConn() {
		
		try {
			// 1단계 : JNDI 서버 객체 생성
			Context ctx = new InitialContext();
			
			// 2단계 : lookup() 메서드를 이용하여 매칭되는 커넥션을 찾는다.
			DataSource ds =
					(DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");
			
			// 3단계 : DataSource 객체를 이용하여 커넥션 객체를 하나 가져온다.
			con = ds.getConnection();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
	}  // openConn() 메서드 end
	
	//DB에 연결된 자원을 종료하는 메서드
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
		
			try {
				if(rs != null) {
				rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(con != null) {
					con.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}//closeConn() 메서드end
	
	//pet_cart 테이블에 사용자 아이디에 해당하는 카트 목록을 조회하는 메서드
		public List<CartDTO> getCartList(String Id){
			
			List<CartDTO> list = new ArrayList<CartDTO>();
			
			try {
				openConn();
				
				sql = "select * from pet_cart where cart_id=? "
						+ " order by cart_no desc";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, Id);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CartDTO dto = new CartDTO();
					
					dto.setCart_no(rs.getInt("cart_no"));
					dto.setCart_pno(rs.getInt("cart_pno"));
					dto.setCart_Id(rs.getString("cart_Id"));
					dto.setCart_pname(rs.getString("cart_pname"));
					dto.setCart_pqty(rs.getInt("cart_pqty"));
					dto.setCart_price(rs.getInt("cart_price"));
					dto.setCart_pspec(rs.getString("cart_pspec"));
					dto.setCart_pimage(rs.getString("cart_pimage"));
					dto.setCart_point(rs.getInt("cart_point"));
					
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, pstmt, con);
			}
			return list;
		}//getCartList()메서드 end
	
		public int updateCartPqty(CartDTO dto, String userId) {
			
			int result = 0, count=0;
			
			try {
				openConn();
				
				sql = "select count(*) from pet_cart where cart_pno=? and cart_id=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, dto.getCart_pno());
				pstmt.setString(2, userId);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
				if(count>0) {
					sql = "update pet_cart set cart_pqty = cart_pqty+1 "
							+ " where cart_pno = ? and cart_id=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, dto.getCart_pno());
					pstmt.setString(2, userId);
					
					
				result = pstmt.executeUpdate();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, pstmt, con);
			}
			return result;
		}//updateCartpqty()메서드 end
		
		
		//장바구니 번호에 해당하는 장바구니 목록을 DB에서 삭제하는 메서드...
		
			public int deleteCart(int no) {
			
			int result=0;
			
			try {
				openConn();
				
				sql = "delete from pet_cart where cart_no=?";
				
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, no);
				
				result = pstmt.executeUpdate();
				
				sql = "update pet_cart set cart_no = cart_no-1 "
						+ " where cart_no > ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, no);
				
				pstmt.executeUpdate();
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, pstmt, con);
			}
			return result;
		}//deleteCart()메서드end
	
	//장비구니에 상품을 넣는 비지니스 로직
	
	
	public int insertCart(CartDTO dto) {
		int result = 0, count=0;
		
		try {
			openConn();
			
			//그룹함수 max는 언제나 int 타입으으로 반환이 된다.
			sql = "select max(cart_no) from pet_cart";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1)+1;
			}
			
			sql = "insert into pet_cart values(?,?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setInt(2, dto.getCart_pno());
			pstmt.setString(3, dto.getCart_Id());
			pstmt.setString(4, dto.getCart_pname());
			pstmt.setInt(5, dto.getCart_pqty());
			pstmt.setInt(6, dto.getCart_price());
			pstmt.setString(7, dto.getCart_pspec());
			pstmt.setString(8, dto.getCart_pimage());
			pstmt.setInt(9, dto.getCart_point());
			
			result = pstmt.executeUpdate();	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}// insertCart() 메서드 end
	
	public int updateCart(int pqty, int no) {
		
		int result= 0;
		
		try {
			openConn();
			
			sql = "update pet_cart set cart_pqty=? and cart_no=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, pqty);
			pstmt.setInt(2, no);
			
			result = pstmt.executeUpdate();
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	public CartDTO getSales(String id) {
		
		CartDTO dto = new CartDTO();
		
		try {
			openConn();
			
			sql = "select * from pet_cart where cart_no =?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setCart_no(rs.getInt("cart_no"));
				dto.setCart_pno(rs.getInt("cart_pno"));
				dto.setCart_Id(rs.getString("cart_id"));
				dto.setCart_pname(rs.getString("cart_pname"));
				dto.setCart_pqty(rs.getInt("cart_pqty"));
				dto.setCart_price(rs.getInt("cart_price"));
				dto.setCart_pspec(rs.getString("cart_pspec"));
				dto.setCart_pimage(rs.getString("cart_pimage"));
				dto.setCart_point(rs.getInt("cart_point"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}// getSales()메서드 end
}	
