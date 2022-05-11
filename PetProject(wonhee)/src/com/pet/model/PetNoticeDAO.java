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

public class PetNoticeDAO {
	Connection con = null;           // DB 연결하는 객체
	PreparedStatement pstmt = null;  // DB에 SQL문을 전송하는 객체
	ResultSet rs = null;             // SQL문 실행 후 결과 값을 가지고 있는 객체
	
	String sql = "";                 // SQL문을 저장할 객체
	
	// PetNoticeDAO 객체를 싱글턴 방식으로 만들어보자**
	// 1. 싱글턴 방식으로 객체를 만들기 위해서는 우선적으로 
	//    기본 생성자의 접근 제어자를 public > private로 바꿔주어야 한다.
	
	// 2. PetNoticeDAO 객체를 정적 멤버로 선언해주어야한다. - static으로 선언해야함.
	private static PetNoticeDAO instance;
	
	private PetNoticeDAO() { } // 기본 생성자
	
	
	// 3. 기본 생성자 대신에 싱글턴 객체를 return 해주는 getInstance() 라는 메서드를
	//    만들어서 이 getInstance() 메서드에 외부에서 접근할 수  있게 해야함.
	public static PetNoticeDAO  getInstance() {
		if (instance == null) {
			instance = new PetNoticeDAO();
		}
		
		return instance;
	} // getInstance() 메서드 end
	
	
	// DB를 연동하는 작업을 진행하는 메서드 - DBCP 방식으로 데이터베이스와 연결 진행
	public void openConn() {
	
		try {
			// 1. JNDI 서버 객체 생성
			Context ctx = new InitialContext();
			
			// 2. lookup() 메서드를 이용하여 매칭되는 커넥션을 찾는다.
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/myoracle");
			
			// 3. DataSource 객체를 이용하여 커넥션 객체를 하나 가져온다.
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
	
	/*********************************************************************************/
	
	//
	// 공지사항 게시판 전체 게시글 수 확인
	public int getPetNoticeCount() {
		int count = 0;
		
		try {
			openConn();
			sql = "select count(*) from pet_notice";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return count;
	} // getPetNoticeCount()
	
	
	// 공지사항 리스트 불러오기
	public List<PetNoticeDTO> getPetNoticeList(int page, int rowsize) {
		List<PetNoticeDTO> list = new ArrayList<PetNoticeDTO>();
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);
		
		try {
			openConn();
			sql = "select * from "
					+ "(select row_number() "
					+ "over(order by free_no desc) nnum, "
					+ "p.* from pet_notice p) "
					+ "where nnum >= ? and nnum <= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				PetNoticeDTO dto = new PetNoticeDTO();
				
				dto.setFree_no(rs.getInt("free_no"));
                dto.setFree_writer(rs.getString("free_writer"));
                dto.setFree_title(rs.getString("free_title"));
                dto.setFree_cont(rs.getString("free_cont"));
                dto.setFree_pwd(rs.getString("free_pwd"));
                dto.setFree_hit(rs.getInt("free_hit"));
                dto.setFree_date(rs.getString("free_date"));
                dto.setFree_update(rs.getString("free_update"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	} // getPetNoticeList()
	
	// 공지사항 상세내용 가져오기
	public PetNoticeDTO getPetNoticeCont(int no) {
		PetNoticeDTO dto = new PetNoticeDTO();
		
		try {
			openConn();
			sql = "update pet_notice set free_hit = free_hit + 1 "
					+ " where free_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
			sql = "select * from pet_notice where free_no = ? order by free_no desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setFree_no(rs.getInt("free_no"));
                dto.setFree_writer(rs.getString("free_writer"));
                dto.setFree_title(rs.getString("free_title"));
                dto.setFree_cont(rs.getString("free_cont"));
                dto.setFree_pwd(rs.getString("free_pwd"));
                dto.setFree_hit(rs.getInt("free_hit"));
                dto.setFree_date(rs.getString("free_date"));
                dto.setFree_update(rs.getString("free_update"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}//
	
	// 검색
	public int searchListCount(String field, String keyword) {
		int count = 0;
		openConn();
		
		if (field.equals("title")) { // 제목으로 검색
			try {
				sql = "select count(*) from pet_notice "
						+ " where free_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					count = rs.getInt(1);
				}
				rs.close(); pstmt.close(); con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if (field.equals("content")) {// 내용으로 검색
			try {
				sql = "select count(*) from pet_notice "
						+ " where free_cont like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					count = rs.getInt(1);
				}
				rs.close(); pstmt.close(); con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if (field.equals("title_content")) {
			try {
				sql = "select count(*) from pet_notice "
						+ " where free_title like ? "
						+ " or free_cont like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setString(2, "%"+keyword+"%");
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					count = rs.getInt(1);
				}
				rs.close(); pstmt.close(); con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			try {
				sql = "select count(*) from pet_notice "
						+ " where free_writer like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setString(2, "%"+keyword+"%");
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					count = rs.getInt(1);
				}
				rs.close(); pstmt.close(); con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return count;
	} // searchListCount() end
	
	
	// board 테이블에서 검색한 내용을 가지고 페이징 처리를 하는 메서드
	public List<PetNoticeDTO> searchBoardList(
			String field, String keyword, int page, int rowsize) {
		List<PetNoticeDTO> list = new ArrayList<PetNoticeDTO>();
		
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);
		
		openConn();
		if (field.equals("title")) { //
			try {
				
				sql = "select * from "
						+ "(select row_number() "
						+ "over(order by free_no desc) nnum, "
						+ "p.* from pet_notice p where free_title like ?) "
						+ "where nnum >= ? and nnum <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					PetNoticeDTO dto = new PetNoticeDTO();
					
					dto.setFree_no(rs.getInt("free_no"));
	                dto.setFree_writer(rs.getString("free_writer"));
	                dto.setFree_title(rs.getString("free_title"));
	                dto.setFree_cont(rs.getString("free_cont"));
	                dto.setFree_pwd(rs.getString("free_pwd"));
	                dto.setFree_hit(rs.getInt("free_hit"));
	                dto.setFree_date(rs.getString("free_date"));
	                dto.setFree_update(rs.getString("free_update"));
	                list.add(dto);
				}
				rs.close(); pstmt.close(); con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if (field.equals("content")) { //
			try {
				sql = "select * from "
						+ "(select row_number() "
						+ "over(order by free_no desc) nnum, "
						+ "p.* from pet_notice p where free_cont like ?) "
						+ "where nnum >= ? and nnum <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					PetNoticeDTO dto = new PetNoticeDTO();
					
					dto.setFree_no(rs.getInt("free_no"));
	                dto.setFree_writer(rs.getString("free_writer"));
	                dto.setFree_title(rs.getString("free_title"));
	                dto.setFree_cont(rs.getString("free_cont"));
	                dto.setFree_pwd(rs.getString("free_pwd"));
	                dto.setFree_hit(rs.getInt("free_hit"));
	                dto.setFree_date(rs.getString("free_date"));
	                dto.setFree_update(rs.getString("free_update"));
	                
	                list.add(dto);
				}
				rs.close(); pstmt.close(); con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if (field.equals("title_content")) { // 
			try {
				sql = "select * from "
						+ "(select row_number() "
						+ "over(order by free_no desc) nnum, "
						+ "p.* from pet_notice p where free_title like ?"
						+ "or free_cont like ?) "
						+ "where nnum >= ? and nnum <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setString(2, "%"+keyword+"%");
				pstmt.setInt(3, startNo);
				pstmt.setInt(4, endNo);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					PetNoticeDTO dto = new PetNoticeDTO();
					
					dto.setFree_no(rs.getInt("free_no"));
	                dto.setFree_writer(rs.getString("free_writer"));
	                dto.setFree_title(rs.getString("free_title"));
	                dto.setFree_cont(rs.getString("free_cont"));
	                dto.setFree_pwd(rs.getString("free_pwd"));
	                dto.setFree_hit(rs.getInt("free_hit"));
	                dto.setFree_date(rs.getString("free_date"));
	                dto.setFree_update(rs.getString("free_update"));
	                
	                list.add(dto);
				}
				rs.close(); pstmt.close(); con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else { //
			try {
				sql = "select * from "
						+ "(select row_number() "
						+ "over(order by free_no desc) nnum, "
						+ "p.* from pet_notice p where free_writer like ?)"
						+ "where nnum >= ? and nnum <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					PetNoticeDTO dto = new PetNoticeDTO();
					
					dto.setFree_no(rs.getInt("free_no"));
	                dto.setFree_writer(rs.getString("free_writer"));
	                dto.setFree_title(rs.getString("free_title"));
	                dto.setFree_cont(rs.getString("free_cont"));
	                dto.setFree_pwd(rs.getString("free_pwd"));
	                dto.setFree_hit(rs.getInt("free_hit"));
	                dto.setFree_date(rs.getString("free_date"));
	                dto.setFree_update(rs.getString("free_update"));
	                
	                list.add(dto);
				}
				rs.close(); pstmt.close(); con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return list;
	} // searchBoardList() end
	
}
