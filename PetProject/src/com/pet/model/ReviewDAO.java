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


public class ReviewDAO {
	Connection con = null; // DB 연결하는 객체.
	PreparedStatement pstmt = null; // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null; // SQL문을 실행 후 결과 값을 가지고 있는 객체.

	String sql = null; // SQL문을 저장할 객체.

	// BbsDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	// 기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : ReviewDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static ReviewDAO instance = null;

	private ReviewDAO() {
	} // 기본생성자.

	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	// 메서드를 만들어서 여기에 접근하게 해야 함.
	public static ReviewDAO getInstance() {

		if (instance == null) {
			instance = new ReviewDAO();
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
	
	//해당 상품의 리뷰들을 조회하는 메서드
	public List<ReviewDTO> selectReview(int no){
		List<ReviewDTO> list = new ArrayList<ReviewDTO>();
		
		openConn();
	
		try {
			sql="select * from pet_review where pnum=? order by review_no desc";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				
				dto.setReview_no(rs.getInt("review_no"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setReview_cont(rs.getString("review_cont"));
				dto.setUserID(rs.getString("userID"));
				dto.setRimage(rs.getString("rimage"));
				dto.setReview_date(rs.getString("review_date"));
				dto.setReview_group(rs.getInt("review_group"));
				dto.setReview_step(rs.getInt("review_step"));
				dto.setReview_indent(rs.getInt("review_indent"));
				dto.setSale_no(rs.getInt("sale_no"));
				dto.setSale_date(rs.getString("sale_date"));
				
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
	
	//리뷰를 추가하는 메서드
	public int insertReview(ReviewDTO dto) {
		
		int result=0 , reNum= 0, gNum=0;
		
		openConn();
		
		try {
			//review_no와 review_group의 최댓값을 조회하는 메서드
			sql="select max(review_no), max(review_group) from pet_review";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				reNum = rs.getInt(1) + 1;
				gNum = rs.getInt(2) +1;
			}
			
			
			sql="insert into pet_review values(?,?,?,?,?,sysdate,?,0,0,?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, reNum);
			pstmt.setInt(2, dto.getPnum());
			pstmt.setString(3, dto.getReview_cont());
			pstmt.setString(4, dto.getUserID());
			pstmt.setString(5, dto.getRimage());
			pstmt.setInt(6, gNum);
			pstmt.setInt(7, dto.getSale_no());
			pstmt.setString(8, dto.getSale_date());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}//insertReview end
	
	//구매내역에서 작성한 리뷰를 확인하는 메서드
	public ReviewDTO selectMyReview(String id, int saleNum, int pNum) {
		ReviewDTO dto = new ReviewDTO();
		
		openConn();
		
		try {
			sql = "select * from pet_review where userID=? and pnum=? and sale_no=?  order by review_no desc";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setInt(2, pNum);
			pstmt.setInt(3, saleNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto.setReview_no(rs.getInt("review_no"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setReview_cont(rs.getString("review_cont"));
				dto.setUserID(rs.getString("userID"));
				dto.setRimage(rs.getString("rimage"));
				dto.setReview_date(rs.getString("review_date"));
				dto.setReview_group(rs.getInt("review_group"));
				dto.setReview_step(rs.getInt("review_step"));
				dto.setReview_indent(rs.getInt("review_indent"));
				dto.setSale_no(rs.getInt("sale_no"));
				dto.setSale_date(rs.getString("sale_date"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}//selectMyReview end
	
	
	//리뷰를 수정하는 메서드
	public int updateReview(ReviewDTO dto) {
		
		int result = 0;
		
		openConn();
		
		try {
			sql = "update pet_review set review_cont = ? ,rimage = ? where userID = ? and pnum = ? and sale_no =? ";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getReview_cont());
			pstmt.setString(2, dto.getRimage());
			pstmt.setString(3, dto.getUserID());
			pstmt.setInt(4, dto.getPnum());
			pstmt.setInt(5, dto.getSale_no());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}//updateReview end

}
