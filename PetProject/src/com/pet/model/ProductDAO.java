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


public class ProductDAO {
	Connection con = null; // DB 연결하는 객체.
	PreparedStatement pstmt = null; // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null; // SQL문을 실행 후 결과 값을 가지고 있는 객체.

	String sql = null; // SQL문을 저장할 객체.

	// BbsDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	// 기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : ProductDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static ProductDAO instance = null;

	private ProductDAO() {
	} // 기본생성자.

	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	// 메서드를 만들어서 여기에 접근하게 해야 함.
	public static ProductDAO getInstance() {

		if (instance == null) {
			instance = new ProductDAO();
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

	} // closeConn() 메서드 end
	
	
	//카테고리별 전체 상품을 조회하는 메서드
	public List<ProductDTO> selectAll(String category){
		 List<ProductDTO> list = new ArrayList<ProductDTO>();
		 
		 openConn();
		
		 try {
			 sql="select * from pet_product where p_category_fk=? order by p_num desc";
			 
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, category);
			
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		 
		 return list;
	}//feedAll() end
	
	//반려견 품종과 상품 종류에 따라 조회하는 메서드
	public List<ProductDTO> selectProductAboutPetKind(String category, String petKind){
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		 
		 openConn();
		
		 try {
			 sql="select * from pet_product where p_category_fk=? and p_kind_fk = ? order by p_num desc";
			 
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, category);
			pstmt.setString(2, petKind);
			
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		 
		 return list;
	}//selectProductaboutPetKind end
	
	
	//제품의 상세 정보를 조회하는 메서드
	public ProductDTO selectProductcont(int no) {
		ProductDTO dto = new ProductDTO();
		
		openConn();
		
		 try {
			 sql="select * from pet_product where p_num"
			 		+ "=?";
			 
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}//selectProductcont end
	
	
	//검색한 상품을 조회하는 메서드
	public List<ProductDTO> searchProduct(String keyward){
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		
		openConn();
		
		try {
			 sql="select * from pet_product where p_name like ? order by p_num desc";
			 
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" + keyward + "%");
		
			
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		 
		return list;
	}//searchProduct end
}
