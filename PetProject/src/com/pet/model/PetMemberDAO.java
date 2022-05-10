package com.pet.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class PetMemberDAO {
	Connection con = null;           // DB 연결하는 객체
	PreparedStatement pstmt = null;  // DB에 SQL문을 전송하는 객체
	ResultSet rs = null;             // SQL문 실행 후 결과 값을 가지고 있는 객체
	
	String sql = "";                 // SQL문을 저장할 객체
	
	// PetMemberDAO 객체를 싱글턴 방식으로 만들어보자**
	// 1. 싱글턴 방식으로 객체를 만들기 위해서는 우선적으로 
	//    기본 생성자의 접근 제어자를 public > private로 바꿔주어야 한다.
	
	// 2. PetMemberDAO 객체를 정적 멤버로 선언해주어야한다. - static으로 선언해야함.
	private static PetMemberDAO instance;
	
	private PetMemberDAO() { } // 기본 생성자
	
	
	// 3. 기본 생성자 대신에 싱글턴 객체를 return 해주는 getInstance() 라는 메서드를
	//    만들어서 이 getInstance() 메서드에 외부에서 접근할 수  있게 해야함.
	public static PetMemberDAO  getInstance() {
		if (instance == null) {
			instance = new PetMemberDAO();
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
	
	// 아이디 중복 확인
	public int petIdCheck(String id) {
		int result = 0;
		
		try {
			openConn();
			sql="select * from pet_member where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = 1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	} // petIdCheck()
	
	
	// pet_member 테이블에 등록
	public int joinPetMember(PetMemberDTO dto) {
		int result = 0, count = 0;
		
		try {
			openConn();
			sql = "select max(m_num) from pet_member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into pet_member "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, 0, sysdate)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getM_id());
			pstmt.setString(3, dto.getM_pwd());
			pstmt.setString(4, dto.getM_name());
			pstmt.setString(5, dto.getM_birth());
			pstmt.setString(6, dto.getM_email());
			pstmt.setString(7, dto.getM_phone());
			pstmt.setString(8, dto.getM_addr());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	} // joinPetMember()
	
	public int userCheck(String id, String pwd) {
		int result = 0;
		
		try {
			openConn();
			sql = "select * from pet_member where m_id = ?";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (pwd.equals(rs.getString("m_pwd"))) {
					// 회원인 경우
					result = 1;
				}else {
					// 비밀번호가 틀린 경우
					result = -1;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // userCheck() end
	
	// id에 해당하는 회원의 정보를 조회하는 메서드
	public PetMemberDTO getMember(String id) {
		PetMemberDTO dto = new PetMemberDTO();
		
		try {
			openConn();
			sql = "select * from pet_member where m_id = ?";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setM_num(rs.getInt("m_num"));
				dto.setM_id(rs.getString("m_id"));
				dto.setM_pwd(rs.getString("m_pwd"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_birth(rs.getString("m_birth"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_phone(rs.getString("m_phone"));
				dto.setM_addr(rs.getString("m_addr"));
				dto.setM_mileage(rs.getInt("m_mileage"));
				dto.setM_regdate(rs.getString("m_regdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return dto;
	} // getMember() end

}
