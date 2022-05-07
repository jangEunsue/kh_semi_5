package com.pet.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PetQandADAO {
	Connection con = null;           // DB 연결하는 객체
	PreparedStatement pstmt = null;  // DB에 SQL문을 전송하는 객체
	ResultSet rs = null;             // SQL문 실행 후 결과 값을 가지고 있는 객체
	
	String sql = "";                 // SQL문을 저장할 객체
	
	// PetQandADAO 객체를 싱글턴 방식으로 만들어보자**
	// 1. 싱글턴 방식으로 객체를 만들기 위해서는 우선적으로 
	//    기본 생성자의 접근 제어자를 public > private로 바꿔주어야 한다.
	
	// 2. PetQandADAO 객체를 정적 멤버로 선언해주어야한다. - static으로 선언해야함.
	private static PetQandADAO instance;
	
	private PetQandADAO() { } // 기본 생성자
	
	
	// 3. 기본 생성자 대신에 싱글턴 객체를 return 해주는 getInstance() 라는 메서드를
	//    만들어서 이 getInstance() 메서드에 외부에서 접근할 수  있게 해야함.
	public static PetQandADAO  getInstance() {
		if (instance == null) {
			instance = new PetQandADAO();
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
}
