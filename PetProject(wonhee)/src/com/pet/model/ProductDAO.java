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

import com.pet.model.ProductDAO;
import com.pet.model.ProductDTO;

public class ProductDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = null;
	
	
	// UploadDAO 객체 싱글턴 방식으로 생성
	private static ProductDAO instance;
	
	private ProductDAO() {};
	
	public static ProductDAO getInstance() {
		
		if(instance == null) {
			instance = new ProductDAO();
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

	
	// 전체 상품 목록 리스트를 조회하는 메서드
	public List<ProductDTO> getProductList(int page, int rowsize) {
		
		List<ProductDTO> list = new ArrayList<ProductDTO>();

		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);
		
		try {		
			openConn();

			sql = "select * from "
					+ "(select row_number() over(order by p_num desc) rnum, "
					+ "p.* from pet_product p) "
					+ "where rnum >= ? and rnum <= ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductDTO dto = new ProductDTO();
				
				dto.setP_num(rs.getInt("p_num"));
				dto.setP_name(rs.getString("p_name"));
				dto.setP_category_fk(rs.getString("p_category_fk"));
				dto.setP_age(rs.getString("p_age"));
				dto.setP_kind_fk(rs.getString("p_kind_fk"));
				dto.setP_wetdry(rs.getString("p_wetdry"));
				dto.setP_size(rs.getString("p_size"));
				dto.setP_neutering(rs.getString("p_neutering"));
				dto.setP_company(rs.getString("p_company"));
				dto.setP_image(rs.getString("p_image"));
				dto.setP_price(rs.getInt("p_price"));
				dto.setP_qty(rs.getInt("p_qty"));
				dto.setP_spec(rs.getString("p_spec"));
				dto.setP_content(rs.getString("p_content"));
				dto.setP_point(rs.getInt("p_point"));
				dto.setP_inputdate(rs.getString("p_inputdate"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return list;
		
	}	// getProductList() 메서드 end

		
	// shop_products 테이블에 상품을 등록(추가)하는 메서
	public int insertProduct(ProductDTO dto) {
		
		int result = 0, count = 0;

		try {
			openConn();
			
			sql = "select max(p_num) from pet_product";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into pet_product"
					+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getP_name());
			pstmt.setString(3, dto.getP_category_fk());
			pstmt.setString(4, dto.getP_age());
			pstmt.setString(5, dto.getP_kind_fk());
			pstmt.setString(6, dto.getP_wetdry());
			pstmt.setString(7, dto.getP_size());
			pstmt.setString(8, dto.getP_neutering());
			pstmt.setString(9, dto.getP_company());
			pstmt.setString(10, dto.getP_image());
			pstmt.setInt(11, dto.getP_price());
			pstmt.setInt(12, dto.getP_qty());
			pstmt.setString(13, dto.getP_spec());
			pstmt.setString(14, dto.getP_content());
			pstmt.setInt(15, dto.getP_point());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
	
		return result;
		
	}	// insertProduct() 메서드 end

	
	// 제품번호에 해당하는 제품을 DB에서 삭제하는 메서드.
	public int deleteProduct(int num) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "delete from pet_product"
					+ " where p_num = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			sql = "update pet_product set"
					+ " p_num = p_num - 1"
					+ " where p_num > ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	}	// deleteProduct() 메서드 end

	
	// 제품번호에 해당하는 제품의 상세 정보를 조회하는 메서드.
	public ProductDTO productContent(int num) {
		
		ProductDTO dto = new ProductDTO();
		
		try {
			openConn();
			
			sql = "select * from pet_product"
					+ " where p_num = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto.setP_num(rs.getInt("p_num"));
				dto.setP_name(rs.getString("p_name"));
				dto.setP_category_fk(rs.getString("p_category_fk"));
				dto.setP_age(rs.getString("p_age"));
				dto.setP_kind_fk(rs.getString("p_kind_fk"));
				dto.setP_wetdry(rs.getString("p_wetdry"));
				dto.setP_size(rs.getString("p_size"));
				dto.setP_neutering(rs.getString("p_neutering"));
				dto.setP_company(rs.getString("p_company"));
				dto.setP_image(rs.getString("p_image"));
				dto.setP_price(rs.getInt("p_price"));
				dto.setP_qty(rs.getInt("p_qty"));
				dto.setP_spec(rs.getString("p_spec"));
				dto.setP_content(rs.getString("p_content"));
				dto.setP_point(rs.getInt("p_point"));
				dto.setP_inputdate(rs.getString("p_inputdate"));
				
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}	// productContent() 메서드 end

	// 상품번호에 해당하는 상품의 정보를 수정하는 메서드.
	public int updateProduct(ProductDTO dto) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "update pet_product set p_image = ?,"
					+ " p_price = ?, p_point = ?, p_qty = ?,"
					+ " p_wetdry = ?, p_kind_fk = ?, p_age = ?,"
					+ " p_size = ?, p_neutering = ?, p_content = ?, p_spec = ?"
					+ " where p_num = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getP_image());
			pstmt.setInt(2, dto.getP_price());
			pstmt.setInt(3, dto.getP_point());
			pstmt.setInt(4, dto.getP_qty());
			pstmt.setString(5, dto.getP_wetdry());
			pstmt.setString(6, dto.getP_kind_fk());
			pstmt.setString(7, dto.getP_age());
			pstmt.setString(8, dto.getP_size());
			pstmt.setString(9, dto.getP_neutering());
			pstmt.setString(10, dto.getP_content());
			pstmt.setString(11, dto.getP_spec());
			pstmt.setInt(12, dto.getP_num());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
		
	}	// updateProduct() 메서드 end

	
	// 상품을 키워드로 검색하고 페이징 처리하는 메서드.
	public List<ProductDTO> searchProductList(
			String search_field, String search_keyword, int page, int rowsize) {
		
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 마지막 번호
		int endNo = (page * rowsize);
		
		openConn();
		
		if(search_field.equals("name")) {
			
			try {
				sql = "select * from "
						+ "(select row_number() over(order by p_num desc) rnum, "
						+ "p.* from pet_product p where p_name like ?) "
						+ "where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+search_keyword+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					ProductDTO dto = new ProductDTO();
					
					dto.setP_num(rs.getInt("p_num"));
					dto.setP_name(rs.getString("p_name"));
					dto.setP_category_fk(rs.getString("p_category_fk"));
					dto.setP_age(rs.getString("p_age"));
					dto.setP_kind_fk(rs.getString("p_kind_fk"));
					dto.setP_wetdry(rs.getString("p_wetdry"));
					dto.setP_size(rs.getString("p_size"));
					dto.setP_neutering(rs.getString("p_neutering"));
					dto.setP_company(rs.getString("p_company"));
					dto.setP_image(rs.getString("p_image"));
					dto.setP_price(rs.getInt("p_price"));
					dto.setP_qty(rs.getInt("p_qty"));
					dto.setP_spec(rs.getString("p_spec"));
					dto.setP_content(rs.getString("p_content"));
					dto.setP_point(rs.getInt("p_point"));
					dto.setP_inputdate(rs.getString("p_inputdate"));
					
					list.add(dto);
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
		} else if(search_field.equals("category")) {
			
			try {
				sql = "select * from "
						+ "(select row_number() over(order by p_num desc) rnum, "
						+ "p.* from pet_product p where p_category_fk like ?) "
						+ "where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+search_keyword+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					ProductDTO dto = new ProductDTO();
					
					dto.setP_num(rs.getInt("p_num"));
					dto.setP_name(rs.getString("p_name"));
					dto.setP_category_fk(rs.getString("p_category_fk"));
					dto.setP_age(rs.getString("p_age"));
					dto.setP_kind_fk(rs.getString("p_kind_fk"));
					dto.setP_wetdry(rs.getString("p_wetdry"));
					dto.setP_size(rs.getString("p_size"));
					dto.setP_neutering(rs.getString("p_neutering"));
					dto.setP_company(rs.getString("p_company"));
					dto.setP_image(rs.getString("p_image"));
					dto.setP_price(rs.getInt("p_price"));
					dto.setP_qty(rs.getInt("p_qty"));
					dto.setP_spec(rs.getString("p_spec"));
					dto.setP_content(rs.getString("p_content"));
					dto.setP_point(rs.getInt("p_point"));
					dto.setP_inputdate(rs.getString("p_inputdate"));
					
					list.add(dto);
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
		} else if(search_field.equals("name_content")) {
			
			try {
				sql = "select * from "
						+ "(select row_number() over(order by p_num desc) rnum, "
						+ "p.* from pet_product p "
						+ "where p_name like ? or p_content like ?) "
						+ "where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+search_keyword+"%");
				pstmt.setString(2, "%"+search_keyword+"%");
				pstmt.setInt(3, startNo);
				pstmt.setInt(4, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					ProductDTO dto = new ProductDTO();
					
					dto.setP_num(rs.getInt("p_num"));
					dto.setP_name(rs.getString("p_name"));
					dto.setP_category_fk(rs.getString("p_category_fk"));
					dto.setP_age(rs.getString("p_age"));
					dto.setP_kind_fk(rs.getString("p_kind_fk"));
					dto.setP_wetdry(rs.getString("p_wetdry"));
					dto.setP_size(rs.getString("p_size"));
					dto.setP_neutering(rs.getString("p_neutering"));
					dto.setP_company(rs.getString("p_company"));
					dto.setP_image(rs.getString("p_image"));
					dto.setP_price(rs.getInt("p_price"));
					dto.setP_qty(rs.getInt("p_qty"));
					dto.setP_spec(rs.getString("p_spec"));
					dto.setP_content(rs.getString("p_content"));
					dto.setP_point(rs.getInt("p_point"));
					dto.setP_inputdate(rs.getString("p_inputdate"));
					
					list.add(dto);
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
		} else if(search_field.equals("company")) {
			
			try {
				sql = "select * from "
						+ "(select row_number() over(order by p_num desc) rnum, "
						+ "p.* from pet_product p where p_company like ?) "
						+ "where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+search_keyword+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					ProductDTO dto = new ProductDTO();
					
					dto.setP_num(rs.getInt("p_num"));
					dto.setP_name(rs.getString("p_name"));
					dto.setP_category_fk(rs.getString("p_category_fk"));
					dto.setP_age(rs.getString("p_age"));
					dto.setP_kind_fk(rs.getString("p_kind_fk"));
					dto.setP_wetdry(rs.getString("p_wetdry"));
					dto.setP_size(rs.getString("p_size"));
					dto.setP_neutering(rs.getString("p_neutering"));
					dto.setP_company(rs.getString("p_company"));
					dto.setP_image(rs.getString("p_image"));
					dto.setP_price(rs.getInt("p_price"));
					dto.setP_qty(rs.getInt("p_qty"));
					dto.setP_spec(rs.getString("p_spec"));
					dto.setP_content(rs.getString("p_content"));
					dto.setP_point(rs.getInt("p_point"));
					dto.setP_inputdate(rs.getString("p_inputdate"));
					
					list.add(dto);
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
		}
		
		return list;
		
	}	// searchProductList() 메서드 end

	
	// 상품의 수를 반환하는 메서드
	public int getProductCount() {
		
		int count = 0;

		try {
			openConn();
			
			sql = "select count(*) from pet_product";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			rs.close(); pstmt.close(); con.close(); 
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		return count;
		
	}	// getProductCount() 메서드 end

	
	// 검색어에 해당하는 게시물의 수를 조회하는 메서드.
	public int searchListCount(String search_field, String search_keyword) {
		
		int count = 0;
		
		openConn();
		
		if(search_field.equals("name")) {

			try {
				
				sql = "select count(*) from pet_product"
						+ " where p_name like ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+search_keyword+"%");
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
				rs.close(); pstmt.close(); con.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
					
		} else if(search_field.equals("category")) {
			
				try {
				
				sql = "select count(*) from pet_product"
						+ " where p_category_fk like ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+search_keyword+"%");
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
				rs.close(); pstmt.close(); con.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
		} else if(search_field.equals("name_content")) {
			
			try {
				
				sql = "select count(*) from pet_product"
						+ " where p_name like ?"
						+ " or p_content like ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+search_keyword+"%");
				pstmt.setString(2, "%"+search_keyword+"%");
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
				rs.close(); pstmt.close(); con.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
								
		} else if(search_field.equals("company")){
			
			try {
				
				sql = "select count(*) from pet_product"
						+ " where p_company like ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+search_keyword+"%");
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
				rs.close(); pstmt.close(); con.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
				
		}
		
		return count;
	} // searchListCount() 메서드 end


}
