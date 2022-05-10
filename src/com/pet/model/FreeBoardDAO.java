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



public class FreeBoardDAO {
	Connection con = null;             // DB 연결하는 객체.
	PreparedStatement pstmt = null;    // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                 // SQL문을 저장할 객체.
	
	
	// FreeBoardDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : FreeBoardDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static FreeBoardDAO instance = null;
	
	
	private FreeBoardDAO() {   }  // 기본생성자.
		
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	//        메서드를 만들어서 여기에 접근하게 해야 함.
	public static FreeBoardDAO getInstance() {
		
		if(instance == null) {
			instance = new FreeBoardDAO();
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
	
	//DB에 연결된 자원을 종료하는 메서드
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
		
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
		
	}//closeConn() 메서드end
	
	
		public int getFreeCount() {
		
		int count = 0;
		
		try {
			openConn();
			
			sql = "select count(*) from pet_free"; //totalRecord수가 나옴
			
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			rs.close(); pstmt.close(); con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}//getBoardCount() end
		
	public List<FreeBoardDTO> getFreeList(int page, int rowsize){
		
		List<FreeBoardDTO> list = new ArrayList<FreeBoardDTO>();
		int startNo = (page*rowsize) - (rowsize-1);
		
		int endNo = (page*rowsize);
		try {
			openConn();
			
			sql="select * from (select row_number() "
					+ "	over(order by free_group desc, free_step) rnum, "
					+ " p.*from pet_free p) "
					+ " where rnum >= ? and rnum <= ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FreeBoardDTO dto = new FreeBoardDTO();
				
				dto.setFree_no(rs.getInt("free_no"));
				dto.setFree_id(rs.getString("free_id"));
				dto.setFree_writer(rs.getString("free_writer"));
				dto.setFree_title(rs.getString("free_title"));
				dto.setFree_cont(rs.getString("free_cont"));
				dto.setFree_pwd(rs.getString("free_pwd"));
				dto.setFree_hit(rs.getInt("free_hit"));
				dto.setFree_date(rs.getString("free_date"));
				dto.setFree_update(rs.getString("free_update"));
				dto.setFree_group(rs.getInt("free_group"));
				dto.setFree_step(rs.getInt("free_step"));
				dto.setFree_indent(rs.getInt("free_indent"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}//getFreeList() end
	
	public int insertFree(FreeBoardDTO dto) {
		
		int result=0, count=0;
		
		try {
			openConn();
			
			sql = "select max(free_no) from pet_free";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}
			
			sql = "insert into pet_free values(?,?,?,?,?,?,default,sysdate,'',?,0,0)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getFree_id());
			pstmt.setString(3, dto.getFree_writer());
			pstmt.setString(4, dto.getFree_title());
			pstmt.setString(5, dto.getFree_cont());
			pstmt.setString(6, dto.getFree_pwd());
			pstmt.setInt(7, count);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	public void freeHit(int no) {
		try {
			openConn();
			
			sql="update pet_free set free_hit = free_hit+1 where free_no=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
	}//freeHit()end
	
	public FreeBoardDTO getFreeContent(int no) {
		
		FreeBoardDTO dto = new FreeBoardDTO();
		
		try {
			openConn();
			
			sql="select*from pet_free where free_no=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setFree_no(rs.getInt("free_no"));
				dto.setFree_id(rs.getString("free_id"));
				dto.setFree_writer(rs.getString("free_writer"));
				dto.setFree_title(rs.getString("free_title"));
				dto.setFree_cont(rs.getString("free_cont"));
				dto.setFree_pwd(rs.getString("free_pwd"));
				dto.setFree_hit(rs.getInt("free_hit"));
				dto.setFree_date(rs.getString("free_date"));
				dto.setFree_update(rs.getString("free_update"));
				dto.setFree_group(rs.getInt("free_group"));
				dto.setFree_step(rs.getInt("free_step"));
				dto.setFree_indent(rs.getInt("free_indent"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}//getFreeContent()end
	
	public int deleteFree(int no, String pwd) {
		
		int result=0;
		
		try {
			openConn();
			
			sql="select*from pet_free where free_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(pwd.equals(rs.getString("free_pwd"))) {
					
					sql="delete from pet_free where free_no=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, no);
					
					result = pstmt.executeUpdate();
					
					sql ="update pet_free set free_no=free_no-1, "
							+ " free_group = free_group-1"
							+ " where free_no > ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, no);
					
					pstmt.executeUpdate();
				}else {
					result=-1;
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
	public FreeBoardDTO UpdateFree(int no) {
		
		FreeBoardDTO dto = new FreeBoardDTO();
		
		try {
			openConn();
			
			sql = "select*from pet_free where free_no=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setFree_no(rs.getInt("free_no"));
				dto.setFree_id(rs.getString("free_id"));
				dto.setFree_writer(rs.getString("free_writer"));
				dto.setFree_title(rs.getString("free_title"));
				dto.setFree_cont(rs.getString("free_cont"));
				dto.setFree_pwd(rs.getString("free_pwd"));
				dto.setFree_hit(rs.getInt("free_hit"));
				dto.setFree_date(rs.getString("free_date"));
				dto.setFree_update(rs.getString("free_update"));
				dto.setFree_group(rs.getInt("free_group"));
				dto.setFree_step(rs.getInt("free_step"));
				dto.setFree_indent(rs.getInt("free_indent"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}// UpdateFree() end
	
	public int updateOkfree(FreeBoardDTO dto) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql="select * from pet_free where free_no=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getFree_no());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				if(dto.getFree_pwd().equals(rs.getString("free_pwd"))) {
					sql="update pet_free set free_title=?, free_cont=?, "
							+ " free_update=sysdate where free_no=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, dto.getFree_title());
					pstmt.setString(2, dto.getFree_cont());
					pstmt.setInt(3, dto.getFree_no());
					
					result = pstmt.executeUpdate();
			}else {
				result=-1;
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
	public void replyUpdate(int group, int step) {
		try {
			openConn();
			
			sql="update pet_free set free_step=free_step+1 "
					+ " where free_group = ? and free_step>?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, group);
			pstmt.setInt(2, step);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
				
	}//replyUpdate() end
	
	public int replyFree(FreeBoardDTO dto) {
		
		int result = 0, count =0;
		
		try {
			openConn();
			
			sql = "select max(free_no) from pet_free";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1)+1;
			}
			
			sql = "insert into pet_free values(?, ?, ?, ?, ?, ?, default, sysdate, '', ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getFree_id());
			pstmt.setString(3, dto.getFree_writer());
			pstmt.setString(4, dto.getFree_title());
			pstmt.setString(5, dto.getFree_cont());
			pstmt.setString(6, dto.getFree_pwd());
			pstmt.setInt(7, dto.getFree_group());
			pstmt.setInt(8, dto.getFree_step()+1);
			pstmt.setInt(9, dto.getFree_indent()+1);
			
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	
	public int searchListCount(String field, String keyword) {
		
		int count=0;
		
		openConn();
		
		if(field.equals("title")) {
			try {
					sql="select count(*) from pet_free "
							+ " where free_title like ?";
					
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, "%"+keyword+"%");
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
				closeConn(rs, pstmt, con);
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}else if(field.equals("content")) {
			try {
				sql = "select count(*) from pet_free "
						+ " where free_cont like ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+keyword+"%");
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
				closeConn(rs, pstmt, con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}else if(field.equals("title_content")) {
				try {
					sql = "select count(*) from pet_free "
							+ " where free_title like ? or free_cont like ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					pstmt.setString(2, "%"+keyword+"%");
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						count = rs.getInt(1);
					}
					
					closeConn(rs, pstmt, con);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				try {
					sql = "select count(*) from pet_free "
							+ " where free_writer like ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						count = rs.getInt(1);
					}
					closeConn(rs, pstmt, con);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return count;
		}//searchListCount()메서드 end
	
	public List<FreeBoardDTO> searchFreeList(
			String field, String keyword, int page, int rowsize){
		
		List<FreeBoardDTO> list = new ArrayList<FreeBoardDTO>();
		
		int startNo = (page * rowsize) - (rowsize -1);
		
		int endNo=(page*rowsize);
		
		openConn();
		
		if(field.equals("title")) {
			try {
				sql = "select * from "
						+ " (select row_number() "
						+ " over(order by free_no desc) rnum,"
						+ " p.* from pet_free p where free_title like ?) "
						+ " where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+keyword+"%");
				
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					FreeBoardDTO dto = new FreeBoardDTO();
					dto.setFree_no(rs.getInt("free_no"));
					dto.setFree_id(rs.getString("free_id"));
					dto.setFree_writer(rs.getString("free_writer"));
					dto.setFree_title(rs.getString("free_title"));
					dto.setFree_cont(rs.getString("free_cont"));
					dto.setFree_pwd(rs.getString("free_pwd"));
					dto.setFree_hit(rs.getInt("free_hit"));
					dto.setFree_date(rs.getString("free_date"));
					dto.setFree_update(rs.getString("free_update"));
					
					list.add(dto);
				}
				closeConn(rs, pstmt, con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(field.equals("content")) {
			try {
				sql = "select * from "
						+ " (select row_number() "
						+ " over(order by free_no desc) rnum, "
						+ "p.* from pet_free p where free_cont like ?) "
						+ " where rnum >=? and rnum <=?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+keyword+"%");
				
				pstmt.setInt(2, startNo);
				
				pstmt.setInt(3, endNo);
				
				rs = pstmt.executeQuery();
				
				
				while(rs.next()) {
					FreeBoardDTO dto = new FreeBoardDTO();
					
					dto.setFree_no(rs.getInt("free_no"));
					dto.setFree_id(rs.getString("free_id"));
					dto.setFree_writer(rs.getString("free_writer"));
					dto.setFree_title(rs.getString("free_title"));
					dto.setFree_cont(rs.getString("free_cont"));
					dto.setFree_pwd(rs.getString("free_pwd"));
					dto.setFree_hit(rs.getInt("free_hit"));
					dto.setFree_date(rs.getString("free_date"));
					dto.setFree_update(rs.getString("free_update"));
					
					list.add(dto);
				}
				
				closeConn(rs, pstmt, con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(field.equals("title_content")) {
			try {
				sql="select * from (select row_number() "
						+ " over(order by free_no desc) rnum, "
						+ " p.* from pet_free p where free_title like ? "
						+ " or free_cont like ?) "
						+ " where rnum>=? and rnum<=?";
				
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, "%"+keyword+"%");

				pstmt.setString(2, "%"+keyword+"%");
				
				pstmt.setInt(3, startNo);
				
				pstmt.setInt(4, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					FreeBoardDTO dto = new FreeBoardDTO();
					
					dto.setFree_no(rs.getInt("free_no"));
					dto.setFree_id(rs.getString("free_id"));
					dto.setFree_writer(rs.getString("free_writer"));
					dto.setFree_title(rs.getString("free_title"));
					dto.setFree_cont(rs.getString("free_cont"));
					dto.setFree_pwd(rs.getString("free_pwd"));
					dto.setFree_hit(rs.getInt("free_hit"));
					dto.setFree_date(rs.getString("free_date"));
					dto.setFree_update(rs.getString("free_update"));
					
					list.add(dto);
				}
				
				closeConn(rs, pstmt, con);
				
			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			try {
				sql = "select * from (select row_number() "
						+ " over(order by free_no desc) rnum, "
						+ " p.* from pet_free p where free_writer like ?) "
						+ " where rnum>=? and rnum<=?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "%"+keyword+"%");
				
				pstmt.setInt(2, startNo);
				
				pstmt.setInt(3, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					FreeBoardDTO dto = new FreeBoardDTO();
					
					dto.setFree_no(rs.getInt("free_no"));
					dto.setFree_id(rs.getString("free_id"));
					dto.setFree_writer(rs.getString("free_writer"));
					dto.setFree_title(rs.getString("free_title"));
					dto.setFree_cont(rs.getString("free_cont"));
					dto.setFree_pwd(rs.getString("free_pwd"));
					dto.setFree_hit(rs.getInt("free_hit"));
					dto.setFree_date(rs.getString("free_date"));
					dto.setFree_update(rs.getString("free_update"));
					
					list.add(dto);
				}
				
				closeConn(rs, pstmt, con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return list;
	}//searchFreeList() end
	
	
	
}