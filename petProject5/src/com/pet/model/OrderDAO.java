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

public class OrderDAO {
	Connection con = null;             // DB 연결하는 객체.
	PreparedStatement pstmt = null;    // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                 // SQL문을 저장할 객체.
	
	
	// AdminDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : AdminDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static OrderDAO instance = null;
	
	
	private OrderDAO() {   }  // 기본생성자.
		
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	//        메서드를 만들어서 여기에 접근하게 해야 함.
	public static OrderDAO getInstance() {
		
		if(instance == null) {
			instance = new OrderDAO();
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
	
	
	// DB에 연결된 자원을 종료하는 메서드
	public void closeConn(ResultSet rs,
			PreparedStatement pstmt, Connection con) {
		
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
		
	}  // closeConn() 메서드 end
	
	// pet_order 테이블에서 배송전 조회를 위한 메서드
	public int CountDel_b() {
		int del_b=0;
		
		try {
			openConn();
			
			sql="select count(p_order_del) as del_b from pet_order where p_order_del = 0";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				del_b=rs.getInt("del_b");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return del_b;
		
	}
	// pet_order 테이블에서 배송중 조회를 위한 메서드
	public int CountDel_i() {
		int del_i=0;
				
		try {
			openConn();
			
			sql="select count(p_order_del) as del_i from pet_order where p_order_del = 1";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				del_i=rs.getInt("del_i");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return del_i;
		
	}
	
	// pet_order 테이블에서 배송완료 조회를 위한 메서드
		public int CountDel_a() {
			int del_a=0;
					
			try {
				openConn();
				
				sql="select count(p_order_del) as del_a from pet_order where p_order_del = 2";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					del_a=rs.getInt("del_a");					
				}	

				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConn(rs, pstmt, con);
			}
			return del_a;
			
		}
		
		// pet_order 테이블에서 결제전 조회를 위한 메서드
				public int CountPay_b() {
					int pay_b=0;
							
					try {
						openConn();
						
						sql="select count(p_order_pay) as pay_b from pet_order where p_order_pay = 0";
						pstmt=con.prepareStatement(sql);
						rs=pstmt.executeQuery();
						if(rs.next()) {
							pay_b=rs.getInt("pay_b");
						}
						
						
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally {
						closeConn(rs, pstmt, con);
					}
					
					return pay_b;
					
				}
				
				// pet_order 테이블에서 결제전 조회를 위한 메서드
				public int CountPay_a() {
					int pay_a=0;
							
					try {
						openConn();
						
						sql="select count(p_order_pay) as pay_a from pet_order where p_order_pay = 1";
						pstmt=con.prepareStatement(sql);
						rs=pstmt.executeQuery();
						if(rs.next()) {
							pay_a=rs.getInt("pay_a");
						}
						
						
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally {
						closeConn(rs, pstmt, con);
					}
					return pay_a;
					
				}
				// 주문내역 전체를 조회하는 메서드
				public List<OrderDTO> selectOrder(){
					
					List<OrderDTO> list = new ArrayList<OrderDTO>();
					try {
						openConn();
						sql="select * from pet_order order by p_order_no desc";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) {
							OrderDTO dto = new OrderDTO();
							
							dto.setP_order_no(rs.getInt("p_order_no"));
							dto.setP_order_del(rs.getInt("p_order_del"));
							dto.setP_order_pay(rs.getInt("p_order_pay"));
							
							list.add(dto);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally {
						closeConn(rs, pstmt, con);
						
					}
					return list;
				}
				
				// 구매내역 전체를 조회하는 매서드
				
				public List<SalesDTO> selectAdminSale(){
					List<SalesDTO> list = new ArrayList<SalesDTO>();
					
					try {
						openConn();
						sql="select * from pet_sales order by sales_no desc";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) {
							SalesDTO dto = new SalesDTO();
							dto.setSales_no(rs.getInt("sales_no"));
							dto.setSales_id(rs.getString("sales_id"));
							dto.setSales_name(rs.getString("sales_name"));
							dto.setSales_phone(rs.getString("sales_phone"));
							dto.setSales_addr(rs.getString("sales_addr"));
							dto.setSales_pname(rs.getString("sales_pname"));
							dto.setSales_pimage(rs.getString("sales_pimage"));
							dto.setSales_price(rs.getInt("sales_price"));
							dto.setSales_pqty(rs.getInt("sales_pqty"));
							dto.setSales_transcost(rs.getInt("sales_transcost"));
							dto.setSales_payment(rs.getString("sales_payment"));
							dto.setSales_comments(rs.getString("sales_comments"));
							dto.setSales_mileage(rs.getInt("sales_mileage"));
							dto.setSales_date(rs.getString("sales_date"));
							dto.setSales_p_no(rs.getInt("sales_p_no"));
							dto.setSales_serial(rs.getInt("sales_serial"));

							list.add(dto);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally {
						closeConn(rs, pstmt, con);
					}
					return list;
				}
				
				
				
				// 주문번호에 따른 배송상태를 조회하는 메서드
				public int selectTrans(int no) {
					int trans=0;
					
					try {
						openConn();
						sql="select p_order_del from pet_order where p_order_no=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, no);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							trans = rs.getInt("p_order_del");
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally {
						closeConn(rs, pstmt, con);
					}
					return trans;
				}
				// 주문번호에 따른 결제 상태를 조회하는 메서드
				public int selectPay(int no) {
					int pay=0;
					
					try {
						openConn();
						sql="select p_order_pay from pet_order where p_order_no=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, no);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							pay = rs.getInt("p_order_pay");
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally {
						closeConn(rs, pstmt, con);
					}
					return pay;
				}
				
				// 결제 취소, 완료를 바꾸어주는 메서드
				public int completePay(int no) {
					int result = 0;
					int count=1;
					try {
						openConn();
						sql="update pet_order set p_order_pay = ? where p_order_no=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, count);
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
				
				public int canclePay(int no) {
					int result = 0;
					int count=0;
					try {
						openConn();
						sql="update pet_order set p_order_pay = ? where p_order_no=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, count);
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
}
