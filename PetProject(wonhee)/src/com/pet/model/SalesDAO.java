package com.pet.model;

import java.io.PrintWriter;
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
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = null;
	
	
	// UploadDAO 객체 싱글턴 방식으로 생성
	private static SalesDAO instance;
	
	private SalesDAO() {};
	
	public static SalesDAO getInstance() {
		
		if(instance == null) {
			instance = new SalesDAO();
		}
		
		return instance;
	}	// getInstance() 메서드 end
	
	
	// DB 연동
	public void openConn() {
		try {
			Context ctx = new InitialContext();
			
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");
			
			con = ds.getConnection();
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}	// openConn() 메서드 end

	
	// DB에 연결된 자원을 종료하는 메서드
	public void closeConn(ResultSet rs, PreparedStatement pstmt, 
												Connection con) {
		
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
			
			e.printStackTrace();
		}
		
	}	// closeConn() 메서드 end

	
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
