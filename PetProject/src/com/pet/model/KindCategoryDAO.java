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

public class KindCategoryDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = null;
	
	
	// UploadDAO 객체 싱글턴 방식으로 생성
	private static KindCategoryDAO instance;
	
	private KindCategoryDAO() {};
	
	public static KindCategoryDAO getInstance() {
		
		if(instance == null) {
			instance = new KindCategoryDAO();
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

	public List<KindCategoryDTO> getKindCategoryList() {
		
		List<KindCategoryDTO> list = new ArrayList<KindCategoryDTO>();

		try {
			openConn();
			
			sql = "select * from pet_kind_category"
					+ " order by category_num asc";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				KindCategoryDTO dto = new KindCategoryDTO();
				
				dto.setCategory_num(rs.getInt("category_num"));
				dto.setCategory_code(rs.getString("category_code"));
				dto.setCategory_name(rs.getString("category_name"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
		
	}	// getKindCategoryList() 메서드 end

	
	// 카테고리를 추가하는 메서드
	public int insertCategory(String code, String name) {
		
		int result = 0, count = 0;

		try {
			openConn();
			
			sql = "select max(category_num)"
					+ " from pet_kind_category";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into pet_kind_category"
					+ " values(?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2, code);
			pstmt.setString(3, name);
			
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			
			e.printStackTrace();
			
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}	// insertCategory() 메서드 end

	
	// 카테고리 번호에 해당하는 카테고리를 삭제하는 메서드
	public int deleteCategory(int num) {
		
		int result = 0;

		try {
			openConn();
			
			sql = "delete from pet_kind_category"
					+ " where category_num = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			sql = "update pet_kind_category set"
					+ " category_num = category_num - 1"
					+ " where category_num > ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
			
		return result;
	}	// deleteCategory() 메서드 end

}
