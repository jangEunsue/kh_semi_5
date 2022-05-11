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

public class MemberDAO {

	Connection con = null;             // DB 연결하는 객체.
	PreparedStatement pstmt = null;    // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                 // SQL문을 저장할 객체.
	private int get;
	
	
	// UploadDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : UploadDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static MemberDAO instance = null;
	
	
	private MemberDAO() {   }  // 기본생성자.
		
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	//        메서드를 만들어서 여기에 접근하게 해야 함.
	public static MemberDAO getInstance() {
		
		if(instance == null) {
			instance = new MemberDAO();
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
	
	// 회원 로그인 메서드
	public int MemberCheck(String id, String pwd) {
		
		int result = 0;
		
		
	    try {
            openConn();
			
			sql = "select * from admin_pet "
					+ " where m_id = ?";
	    	
			pstmt = con.prepareStatement(sql);
		    
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(pwd.equals(rs.getString("m_pwd"))) {
					result = 1;
				}else {
					result = -1;
				}
			}
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
	    
	    return result;
	}
	
	// 회원 정보 조회
	public MemberDTO getMember(String id) {
		
		MemberDTO dto = new MemberDTO();
		
		
		try {
			openConn();
			
			sql = "select * from admin_pet "
					+ " where m_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setM_id(rs.getString("m_id"));
				dto.setM_pwd(rs.getString("m_pwd"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_regdate(rs.getString("m_regdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}
	

	//전체 조회 매서드
	
	public List<MemberDTO> getMemberList() {
		
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		
		try {
			openConn();
			
			sql = "select * from pet_member order by m_num desc" ;
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				
				dto.setM_num(rs.getInt("m_num"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_id(rs.getString("m_id"));
				dto.setM_pwd(rs.getString("m_pwd"));
				dto.setM_name(rs.getString("m_name"));
				dto.setM_birth(rs.getString("m_birth"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_phone(rs.getString("m_phone"));
				dto.setM_addr(rs.getString("m_addr"));
				dto.setM_mileage(rs.getInt("m_mileage"));
				dto.setM_regdate(rs.getString("m_regdate"));
				
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
	
	// 회원 등록 매서드
	
	public int insertMember(MemberDTO dto) {
		
		int result = 0, count = 0;
		
	
		try {
			openConn();
			
			sql = "select max(m_num) from pet_member";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql= "insert into pet_member"
					+ " values( ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getM_id());
			pstmt.setString(3, dto.getM_pwd());
			pstmt.setString(4, dto.getM_name());
			pstmt.setString(5, dto.getM_birth());
			pstmt.setString(6, dto.getM_email());
			pstmt.setString(7, dto.getM_phone());
			pstmt.setString(8, dto.getM_addr());
			pstmt.setInt(9, dto.getM_mileage());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	
	// deletMember() 시작
	public int deletMember(int m_num) {
		
		int result = 0;
		
		
		try {
			openConn();
			
			sql = " delete from pet_member "
					+ " where m_num = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, m_num);
			
			result = pstmt.executeUpdate();
			
			sql = "update pet_member set "
					+ " m_num = m_num - 1 "
					+ " where m_num > ?";
			
           pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, m_num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;		
	}
	
	// 회원 번호에 해당하는 회원에 대한 상세 정보 조회 매서드
	public MemberDTO memberContent(int m_num) {
		
		MemberDTO dto = new MemberDTO();
		
		
		try {
			openConn();
			
			sql = "select * from pet_member "
					+ " where m_num = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, m_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
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
		}finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}
	
	// MemberUpdate() 시작
	
	public int MemberUpdate(MemberDTO dto) {

		int result = 0;
		
		
		try {
			openConn();
			
			sql = " update pet_member set m_email = ?,"
					+ " m_phone = ? , m_addr = ?, "
					+ " m_mileage = ? where m_num = ?";
			
			pstmt = con.prepareStatement(sql);
		   
		    pstmt.setString(1, dto.getM_email());
		    
		    pstmt.setString(2, dto.getM_phone());
		    
		    pstmt.setString(3, dto.getM_addr());
		    
		    pstmt.setInt(4, dto.getM_mileage());
		    
		    pstmt.setInt(5, dto.getM_num());
		    
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
