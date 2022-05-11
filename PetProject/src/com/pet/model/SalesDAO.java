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

public class SalesDAO {
	Connection con = null; // DB 연결하는 객체.
	PreparedStatement pstmt = null; // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null; // SQL문을 실행 후 결과 값을 가지고 있는 객체.

	String sql = null; // SQL문을 저장할 객체.

	// SalesDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	// 기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : SalesDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static SalesDAO instance = null;

	private SalesDAO() {
	} // 기본생성자.

	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	// 메서드를 만들어서 여기에 접근하게 해야 함.
	public static SalesDAO getInstance() {

		if (instance == null) {
			instance = new SalesDAO();
		}
		return instance;

	} // getInstance() 메서드 end

	// DB를 연동하는 작업을 진행하는 메서드
	public void openConn() {

		try {
			// 1단계 : JNDI 서버 객체 생성
			Context ctx = new InitialContext();

			// 2단계 : lookup() 메서드를 이용하여 매칭되는 커넥션을 찾는다.
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/myoracle");

			// 3단계 : DataSource 객체를 이용하여 커넥션 객체를 하나 가져온다.
			con = ds.getConnection();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	} // openConn() 메서드 end

	// DB에 연결된 자원을 종료하는 메서드
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {

		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}// closeConn() 메서드end

	// 구매내역을 확인하는 메서드
	public List<SalesDTO> selectUserSale(String id) {
		List<SalesDTO> list = new ArrayList<SalesDTO>();

		openConn();

		try {
			sql = "select * from pet_sales where sales_id = ? order by sales_no desc";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
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
		} finally {
			closeConn(rs, pstmt, con);
		}

		return list;
	}// selectUserSale end

	// 해당 사용자가 제품들을 구매했던 날짜를 조호히하는 메소드
	public List<SalesDTO> selectUserSaleDate(String id) {
		List<SalesDTO> list = new ArrayList<SalesDTO>();

		openConn();

		try {
			sql = "select DISTINCT SALES_DATE from pet_sales where sales_id = ? order by sales_date desc";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				SalesDTO dto = new SalesDTO();

				dto.setSales_id(id);
				dto.setSales_date(rs.getString("sales_date"));

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return list;
	}// selectUserSaleDate end

	// 해당 사용자의 해당 주문번호, 해당 상품에 해당하는 구매 내역 조회
	public SalesDTO selectSaleProductcont(int pnum, int saleNo, String userId) {
		SalesDTO dto = new SalesDTO();

		openConn();

		try {
			sql = "select * from pet_sales where sales_p_no = ? and sales_id = ? and sales_no = ? order by sales_no desc";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, pnum);
			pstmt.setString(2, userId);
			pstmt.setInt(3, saleNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {
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
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return dto;
	}// selectSaleProductcont(pnum , userId, date) end

	public List<SalesDTO> getSalesList(String id) {

		List<SalesDTO> list = new ArrayList<SalesDTO>();

		try {
			openConn();

			sql = "select * from pet_sales where sales_id=? " + " order by sales_no desc";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
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

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}

	public int getMaxSerial() {

		int result = 0;

		try {
			openConn();

			sql = "select max(sales_serial) from pet_sales";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1) + 1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}

	public int insertSales(SalesDTO dto) {

		int result = 0, count = 0;

		try {
			openConn();

			sql = "select max(sales_no) from pet_sales";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1) + 1;
			}

			sql = "insert into pet_sales " + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getSales_id());
			pstmt.setInt(3, dto.getSales_serial());
			pstmt.setString(4, dto.getSales_name());
			pstmt.setString(5, dto.getSales_phone());
			pstmt.setString(6, dto.getSales_addr());
			pstmt.setInt(7, dto.getSales_p_no());
			pstmt.setString(8, dto.getSales_pname());
			pstmt.setString(9, dto.getSales_pimage());
			pstmt.setInt(10, dto.getSales_price());
			pstmt.setInt(11, dto.getSales_pqty());
			pstmt.setInt(12, dto.getSales_transcost());
			pstmt.setString(13, dto.getSales_payment());
			pstmt.setString(14, dto.getSales_comments());
			pstmt.setInt(15, dto.getSales_mileage());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	}
	
	
	
	// 전체 매출 목록 리스트를 조회하는 메서드
		public List<SalesDTO> getSalesList() {
			
			List<SalesDTO> list = new ArrayList<SalesDTO>();

			try {		
				openConn();
				
				sql = "select * from pet_sales order by sales_serial desc";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					SalesDTO dto = new SalesDTO();
					
					dto.setSales_no(rs.getInt("sales_no"));
					dto.setSales_id(rs.getString("sales_id"));
					dto.setSales_serial(rs.getInt("sales_serial"));
					dto.setSales_name(rs.getString("sales_name"));
					dto.setSales_phone(rs.getString("sales_phone"));
					dto.setSales_addr(rs.getString("sales_addr"));
					dto.setSales_p_no(rs.getInt("sales_p_no"));
					dto.setSales_pname(rs.getString("sales_pname"));
					dto.setSales_pimage(rs.getString("sales_pimage"));
					dto.setSales_price(rs.getInt("sales_price"));
					dto.setSales_pqty(rs.getInt("sales_pqty"));
					dto.setSales_transcost(rs.getInt("sales_transcost"));
					dto.setSales_payment(rs.getString("sales_payment"));
					dto.setSales_comments(rs.getString("sales_comments"));
					dto.setSales_mileage(rs.getInt("sales_mileage"));
					dto.setSales_date(rs.getString("sales_date"));
					
					list.add(dto);
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}

			return list;
		}	// getSalesList() 메서드 end

		
		// 전체 상품 매출의 총합을 구하는 메서드
		public int getSalesPsum() {
			
			int result = 0;

			try {		
				openConn();
				
				sql = "select sum(sales_price * sales_pqty) as psum "
						+ " from pet_sales";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					result = rs.getInt(1);				
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}

			return result;
			
		}	// getSalesPsum() 메서드 end

		
		// 전체 배송비의 총합을 구하는 구하는 메서드(일련번호 별로 중복제거)
		public int getSalesTranscostsum() {
			
			int result = 0;

			try {		
				openConn();
				
				sql = "select sum(sales_transcost) from"
						+ " (select distinct sales_serial, sales_transcost from pet_sales)";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					result = rs.getInt(1);				
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}

			return result;
			
		}	// getSalesTranscostsum() 메서드 end

		
		// 전체 상품 매출과 배송비의 총합을 구하는 메서드 
		public int getSalesSumall() {
			
			int psum = 0;
			int transsum = 0;
			int result = 0;

			try {		
				openConn();
				
				sql = "select sum(sales_price * sales_pqty) as psum "
						+ " from pet_sales";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					psum = rs.getInt(1);				
				}
				
				sql = "select sum(sales_transcost) from"
						+ " (select distinct sales_serial, sales_transcost from pet_sales)";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					transsum = rs.getInt(1);				
				}
				
				result = psum + transsum;
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return result;
			
		}	// getSalesSumall() 메서드 end

		
		// 조건에 해당하는 매출 목록을 검색하는 메서드.
		public List<SalesDTO> searchSalesList(String searchDateStart, String searchDateEnd, String searchPname) {
			
			List<SalesDTO> list = new ArrayList<SalesDTO>();
			
			openConn();
			
			if(searchPname.equals("")) {
				if(searchDateStart.equals("") && searchDateEnd.equals("")) {
					try {		
						openConn();
						
						sql = "select * from pet_sales order by sales_serial desc";
						
						pstmt = con.prepareStatement(sql);
						
						rs = pstmt.executeQuery();
						
						while(rs.next()) {
							
							SalesDTO dto = new SalesDTO();
							
							dto.setSales_no(rs.getInt("sales_no"));
							dto.setSales_id(rs.getString("sales_id"));
							dto.setSales_serial(rs.getInt("sales_serial"));
							dto.setSales_name(rs.getString("sales_name"));
							dto.setSales_phone(rs.getString("sales_phone"));
							dto.setSales_addr(rs.getString("sales_addr"));
							dto.setSales_p_no(rs.getInt("sales_p_no"));
							dto.setSales_pname(rs.getString("sales_pname"));
							dto.setSales_pimage(rs.getString("sales_pimage"));
							dto.setSales_price(rs.getInt("sales_price"));
							dto.setSales_pqty(rs.getInt("sales_pqty"));
							dto.setSales_transcost(rs.getInt("sales_transcost"));
							dto.setSales_payment(rs.getString("sales_payment"));
							dto.setSales_comments(rs.getString("sales_comments"));
							dto.setSales_mileage(rs.getInt("sales_mileage"));
							dto.setSales_date(rs.getString("sales_date"));
							
							list.add(dto);
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && searchDateEnd.equals("")) {
					try {
						sql = "select * from pet_sales"
								+ " where sales_date > ?"
								+ " order by sales_serial desc";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						while(rs.next()) {
							
							SalesDTO dto = new SalesDTO();
							
							dto.setSales_no(rs.getInt("sales_no"));
							dto.setSales_id(rs.getString("sales_id"));
							dto.setSales_serial(rs.getInt("sales_serial"));
							dto.setSales_name(rs.getString("sales_name"));
							dto.setSales_phone(rs.getString("sales_phone"));
							dto.setSales_addr(rs.getString("sales_addr"));
							dto.setSales_p_no(rs.getInt("sales_p_no"));
							dto.setSales_pname(rs.getString("sales_pname"));
							dto.setSales_pimage(rs.getString("sales_pimage"));
							dto.setSales_price(rs.getInt("sales_price"));
							dto.setSales_pqty(rs.getInt("sales_pqty"));
							dto.setSales_transcost(rs.getInt("sales_transcost"));
							dto.setSales_payment(rs.getString("sales_payment"));
							dto.setSales_comments(rs.getString("sales_comments"));
							dto.setSales_mileage(rs.getInt("sales_mileage"));
							dto.setSales_date(rs.getString("sales_date"));
							
							list.add(dto);
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(searchDateStart.equals("") && !(searchDateEnd.equals(""))) {
					try {
						sql = "select * from pet_sales"
								+ " where sales_date < ?"
								+ " order by sales_serial desc";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						while(rs.next()) {
							
							SalesDTO dto = new SalesDTO();
							
							dto.setSales_no(rs.getInt("sales_no"));
							dto.setSales_id(rs.getString("sales_id"));
							dto.setSales_serial(rs.getInt("sales_serial"));
							dto.setSales_name(rs.getString("sales_name"));
							dto.setSales_phone(rs.getString("sales_phone"));
							dto.setSales_addr(rs.getString("sales_addr"));
							dto.setSales_p_no(rs.getInt("sales_p_no"));
							dto.setSales_pname(rs.getString("sales_pname"));
							dto.setSales_pimage(rs.getString("sales_pimage"));
							dto.setSales_price(rs.getInt("sales_price"));
							dto.setSales_pqty(rs.getInt("sales_pqty"));
							dto.setSales_transcost(rs.getInt("sales_transcost"));
							dto.setSales_payment(rs.getString("sales_payment"));
							dto.setSales_comments(rs.getString("sales_comments"));
							dto.setSales_mileage(rs.getInt("sales_mileage"));
							dto.setSales_date(rs.getString("sales_date"));
							
							list.add(dto);
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && !(searchDateEnd.equals(""))){				
					try {
						sql = "select * from pet_sales"
								+ " where sales_date between ? and ?"
								+ " order by sales_serial desc";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						while(rs.next()) {
							
							SalesDTO dto = new SalesDTO();
							
							dto.setSales_no(rs.getInt("sales_no"));
							dto.setSales_id(rs.getString("sales_id"));
							dto.setSales_serial(rs.getInt("sales_serial"));
							dto.setSales_name(rs.getString("sales_name"));
							dto.setSales_phone(rs.getString("sales_phone"));
							dto.setSales_addr(rs.getString("sales_addr"));
							dto.setSales_p_no(rs.getInt("sales_p_no"));
							dto.setSales_pname(rs.getString("sales_pname"));
							dto.setSales_pimage(rs.getString("sales_pimage"));
							dto.setSales_price(rs.getInt("sales_price"));
							dto.setSales_pqty(rs.getInt("sales_pqty"));
							dto.setSales_transcost(rs.getInt("sales_transcost"));
							dto.setSales_payment(rs.getString("sales_payment"));
							dto.setSales_comments(rs.getString("sales_comments"));
							dto.setSales_mileage(rs.getInt("sales_mileage"));
							dto.setSales_date(rs.getString("sales_date"));
							
							list.add(dto);
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				}
			} else {
				if(searchDateStart.equals("") && searchDateEnd.equals("")) {
					try {
						sql = "select * from pet_sales"
								+ " where sales_pname like ?"
								+ " order by sales_serial desc";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						
						rs = pstmt.executeQuery();
						
						while(rs.next()) {
							
							SalesDTO dto = new SalesDTO();
							
							dto.setSales_no(rs.getInt("sales_no"));
							dto.setSales_id(rs.getString("sales_id"));
							dto.setSales_serial(rs.getInt("sales_serial"));
							dto.setSales_name(rs.getString("sales_name"));
							dto.setSales_phone(rs.getString("sales_phone"));
							dto.setSales_addr(rs.getString("sales_addr"));
							dto.setSales_p_no(rs.getInt("sales_p_no"));
							dto.setSales_pname(rs.getString("sales_pname"));
							dto.setSales_pimage(rs.getString("sales_pimage"));
							dto.setSales_price(rs.getInt("sales_price"));
							dto.setSales_pqty(rs.getInt("sales_pqty"));
							dto.setSales_transcost(rs.getInt("sales_transcost"));
							dto.setSales_payment(rs.getString("sales_payment"));
							dto.setSales_comments(rs.getString("sales_comments"));
							dto.setSales_mileage(rs.getInt("sales_mileage"));
							dto.setSales_date(rs.getString("sales_date"));
							
							list.add(dto);
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals(""))&& searchDateEnd.equals("")) {
					try {
						sql = "select * from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date > ?"
								+ " order by sales_serial desc";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						while(rs.next()) {
							
							SalesDTO dto = new SalesDTO();
							
							dto.setSales_no(rs.getInt("sales_no"));
							dto.setSales_id(rs.getString("sales_id"));
							dto.setSales_serial(rs.getInt("sales_serial"));
							dto.setSales_name(rs.getString("sales_name"));
							dto.setSales_phone(rs.getString("sales_phone"));
							dto.setSales_addr(rs.getString("sales_addr"));
							dto.setSales_p_no(rs.getInt("sales_p_no"));
							dto.setSales_pname(rs.getString("sales_pname"));
							dto.setSales_pimage(rs.getString("sales_pimage"));
							dto.setSales_price(rs.getInt("sales_price"));
							dto.setSales_pqty(rs.getInt("sales_pqty"));
							dto.setSales_transcost(rs.getInt("sales_transcost"));
							dto.setSales_payment(rs.getString("sales_payment"));
							dto.setSales_comments(rs.getString("sales_comments"));
							dto.setSales_mileage(rs.getInt("sales_mileage"));
							dto.setSales_date(rs.getString("sales_date"));
							
							list.add(dto);
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(searchDateStart.equals("") && !(searchDateEnd.equals(""))) {
					try {
						sql = "select * from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date < ?"
								+ " order by sales_serial desc";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						while(rs.next()) {
							
							SalesDTO dto = new SalesDTO();
							
							dto.setSales_no(rs.getInt("sales_no"));
							dto.setSales_id(rs.getString("sales_id"));
							dto.setSales_serial(rs.getInt("sales_serial"));
							dto.setSales_name(rs.getString("sales_name"));
							dto.setSales_phone(rs.getString("sales_phone"));
							dto.setSales_addr(rs.getString("sales_addr"));
							dto.setSales_p_no(rs.getInt("sales_p_no"));
							dto.setSales_pname(rs.getString("sales_pname"));
							dto.setSales_pimage(rs.getString("sales_pimage"));
							dto.setSales_price(rs.getInt("sales_price"));
							dto.setSales_pqty(rs.getInt("sales_pqty"));
							dto.setSales_transcost(rs.getInt("sales_transcost"));
							dto.setSales_payment(rs.getString("sales_payment"));
							dto.setSales_comments(rs.getString("sales_comments"));
							dto.setSales_mileage(rs.getInt("sales_mileage"));
							dto.setSales_date(rs.getString("sales_date"));
							
							list.add(dto);
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && !(searchDateEnd.equals(""))){
					try {
						sql = "select * from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date between ? and ?"
								+ " order by sales_serial desc";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						pstmt.setString(3, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						while(rs.next()) {
							
							SalesDTO dto = new SalesDTO();
							
							dto.setSales_no(rs.getInt("sales_no"));
							dto.setSales_id(rs.getString("sales_id"));
							dto.setSales_serial(rs.getInt("sales_serial"));
							dto.setSales_name(rs.getString("sales_name"));
							dto.setSales_phone(rs.getString("sales_phone"));
							dto.setSales_addr(rs.getString("sales_addr"));
							dto.setSales_p_no(rs.getInt("sales_p_no"));
							dto.setSales_pname(rs.getString("sales_pname"));
							dto.setSales_pimage(rs.getString("sales_pimage"));
							dto.setSales_price(rs.getInt("sales_price"));
							dto.setSales_pqty(rs.getInt("sales_pqty"));
							dto.setSales_transcost(rs.getInt("sales_transcost"));
							dto.setSales_payment(rs.getString("sales_payment"));
							dto.setSales_comments(rs.getString("sales_comments"));
							dto.setSales_mileage(rs.getInt("sales_mileage"));
							dto.setSales_date(rs.getString("sales_date"));
							
							list.add(dto);
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				}
			}

			return list;
			
		}	// searchSalesList() 메서드 end

		
		// 검색 결과에 대한 상품 금액의 총합을 구하는 메서드
		public int getSalesPsum(String searchDateStart, String searchDateEnd, String searchPname) {
			
			int result = 0;

			openConn();
			
			if(searchPname.equals("")) {
				if(searchDateStart.equals("") && searchDateEnd.equals("")) {
					try {		
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales";
						
						pstmt = con.prepareStatement(sql);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && searchDateEnd.equals("")) {
					try {		
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_date > ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(searchDateStart.equals("") && !(searchDateEnd.equals(""))) {
					
					try {		
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_date < ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && !(searchDateEnd.equals(""))){				

					try {		
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_date between ? and ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				}
			} else {
				if(searchDateStart.equals("") && searchDateEnd.equals("")) {

					try {		
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_pname like ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals(""))&& searchDateEnd.equals("")) {

					try {		
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date > ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(searchDateStart.equals("") && !(searchDateEnd.equals(""))) {
					
					try {		
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date < ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && !(searchDateEnd.equals(""))){
					
					try {		
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date between ? and ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						pstmt.setString(3, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				}
			}

			return result;
			
		}	// getSalesPsum() 메서드 end

		
		// 검색 결과에 대한 배송비의 총합을 구하는 메서드(일련번호 별로 중복제거)
		public int getSalesTranscostsum(String searchDateStart, String searchDateEnd, String searchPname) {
			
			int result = 0;
			 
			openConn();
			
			if(searchPname.equals("")) {
				if(searchDateStart.equals("") && searchDateEnd.equals("")) {
					try {		
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales)";
						
						pstmt = con.prepareStatement(sql);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && searchDateEnd.equals("")) {
					try {		
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ "	where sales_date > ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}

				} else if(searchDateStart.equals("") && !(searchDateEnd.equals(""))) {
					try {		
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_date < ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}

				} else if(!(searchDateStart.equals("")) && !(searchDateEnd.equals(""))){	
					try {		
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_date between ? and ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}

				}
			} else {
				if(searchDateStart.equals("") && searchDateEnd.equals("")) {
					try {		
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_pname like ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}

				} else if(!(searchDateStart.equals(""))&& searchDateEnd.equals("")) {
					try {		
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date > ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}

				} else if(searchDateStart.equals("") && !(searchDateEnd.equals(""))) {
					try {		
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date < ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}

				} else if(!(searchDateStart.equals("")) && !(searchDateEnd.equals(""))){
					try {		
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date between ? and ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						pstmt.setString(3, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							result = rs.getInt(1);				
						}
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}

				}
			}

			return result;
			
		}	// getSalesTranscostsum() 메서드 end

		
		// 검색 결과에 대한 상품+배송비의 총합을 구하는 메서드
		public int getSalesSumall(String searchDateStart, String searchDateEnd, String searchPname) {
			
			int psum = 0;
			int transsum = 0;
			int result = 0;

			openConn();
			
			if(searchPname.equals("")) {
				if(searchDateStart.equals("") && searchDateEnd.equals("")) {
					try {		
						
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales";
						
						pstmt = con.prepareStatement(sql);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							psum = rs.getInt(1);				
						}
						
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales)";
						
						pstmt = con.prepareStatement(sql);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							transsum = rs.getInt(1);				
						}
						
						result = psum + transsum;
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && searchDateEnd.equals("")) {
					try {		
						
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_date > ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							psum = rs.getInt(1);				
						}
						
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_date > ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							transsum = rs.getInt(1);				
						}
						
						result = psum + transsum;
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(searchDateStart.equals("") && !(searchDateEnd.equals(""))) {
					try {		
						
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_date < ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							psum = rs.getInt(1);				
						}
						
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_date < ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							transsum = rs.getInt(1);				
						}
						
						result = psum + transsum;
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && !(searchDateEnd.equals(""))){				
					try {		
						
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_date between ? and ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							psum = rs.getInt(1);				
						}
						
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_date between ? and ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, searchDateStart);
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							transsum = rs.getInt(1);				
						}
						
						result = psum + transsum;
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				}
			} else {
				if(searchDateStart.equals("") && searchDateEnd.equals("")) {
					try {		
						
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_pname like ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							psum = rs.getInt(1);				
						}
						
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_pname like ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							transsum = rs.getInt(1);				
						}
						
						result = psum + transsum;
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals(""))&& searchDateEnd.equals("")) {
					try {		
						
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date > ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							psum = rs.getInt(1);				
						}
						
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date > ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							transsum = rs.getInt(1);				
						}
						
						result = psum + transsum;
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}

				} else if(searchDateStart.equals("") && !(searchDateEnd.equals(""))) {
					try {		
						
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date < ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							psum = rs.getInt(1);				
						}
						
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date < ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							transsum = rs.getInt(1);				
						}
						
						result = psum + transsum;
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				} else if(!(searchDateStart.equals("")) && !(searchDateEnd.equals(""))){
					try {		
						
						sql = "select sum(sales_price * sales_pqty) as psum "
								+ " from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date between ? and ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						pstmt.setString(3, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							psum = rs.getInt(1);				
						}
						
						sql = "select sum(sales_transcost) from"
								+ " (select distinct sales_serial, sales_transcost from pet_sales"
								+ " where sales_pname like ?"
								+ " and sales_date between ? and ?)";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, "%"+searchPname+"%");
						pstmt.setString(2, searchDateStart);
						pstmt.setString(3, searchDateEnd);
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							transsum = rs.getInt(1);				
						}
						
						result = psum + transsum;
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					} finally {
						closeConn(rs, pstmt, con);
					}
				}
			}

			return result;
			
		}	// getSalesSumall() 메서드 end
}