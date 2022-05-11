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

public class NoticeDAO {

	Connection con = null;             // DB 연결하는 객체.
	PreparedStatement pstmt = null;    // DB에 SQL문을 전송하는 객체.
	ResultSet rs = null;               // SQL문을 실행 후 결과 값을 가지고 있는 객체.
	
	String sql = null;                 // SQL문을 저장할 객체.
	private int get;
	
	
	// UploadDAO 객체를 싱글톤 방식으로 만들어 보자.
	// 1단계 : 싱글톤 방식으로 객체를 만들기 위해서는 우선적으로
	//        기본 생성자의 접근 제어자를 private 으로 선언해야 함.
	// 2단계 : UploadDAO 객체를 정적 멤버로 선언해야 함. - static으로 선언해야 함.
	private static NoticeDAO instance = null;
	
	
	private NoticeDAO() {   }  // 기본생성자.
		
	// 3단계 : 기본 생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 라는
	//        메서드를 만들어서 여기에 접근하게 해야 함.
	public static NoticeDAO getInstance() {
		
		if(instance == null) {
			instance = new NoticeDAO();
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
	
	// 게시판 전체 레코드 조회
public List<NoticeDTO> getNoticeList() {
		
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		
		try {
			openConn();
			
			sql = "select * from pet_notice "
					+ " order by  notice_group desc, notice_step";
		    
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				
				dto.setNotice_no(rs.getInt("notice_no"));
				dto.setNotice_writer(rs.getString("notice_writer"));
				dto.setNotice_title(rs.getString("notice_title"));
				dto.setNotice_cont(rs.getString("notice_cont"));
				dto.setNotice_pwd(rs.getString("notice_pwd"));
				dto.setNotice_hit(rs.getInt("notice_hit"));
				dto.setNotice_date(rs.getString("notice_date"));
				dto.setNotice_update(rs.getString("notice_update"));
				dto.setNotice_group(rs.getInt("notice_group"));
				dto.setNotice_step(rs.getInt("notice_step"));
				dto.setNotice_indent(rs.getInt("notice_indent"));
			    
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
	
	// 게시판 글 추가
	public int insertNotice(NoticeDTO dto) {
		
		int result = 0, count = 0;
		
		
		try {
			openConn();
			
			sql = "select max(notice_no) from pet_notice";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into pet_notice "
					+ " values(?, ?, ?, ?, ? , default, sysdate, '', ?, 0, 0)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			
			pstmt.setString(2, dto.getNotice_writer());
			
			pstmt.setString(3, dto.getNotice_title());
			
			pstmt.setString(4, dto.getNotice_cont());
			
			pstmt.setString(5, dto.getNotice_pwd());
			
			pstmt.setInt(6, count);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	
	// 조회수 증가
	public void noticeHit(int no) {
		
		
		try {
			openConn();
			
			sql = "update pet_notice set "
					+ " notice_hit = notice_hit + 1 "
					+ " where notice_no = ? ";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}

	}
	
	// 상세내역 조회
	public NoticeDTO getNoticeContent(int no) {
		
		NoticeDTO dto = new NoticeDTO();
		
		
		try {
			openConn();
			
			sql = "select * from pet_notice "
					+ " where notice_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNotice_no(rs.getInt("notice_no"));
				dto.setNotice_writer(rs.getString("notice_writer"));
				dto.setNotice_title(rs.getString("notice_title"));
				dto.setNotice_cont(rs.getString("notice_cont"));
				dto.setNotice_pwd(rs.getString("notice_pwd"));
				dto.setNotice_hit(rs.getInt("notice_hit"));
				dto.setNotice_date(rs.getString("notice_date"));
				dto.setNotice_update(rs.getString("notice_update"));
				dto.setNotice_group(rs.getInt("notice_group"));
				dto.setNotice_step(rs.getInt("notice_step"));
				dto.setNotice_indent(rs.getInt("notice_indent"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return dto;
	}
	
	//게시판글 수정
	public int UpdateNotice(NoticeDTO dto) {
		
		int result = 0;
		
		
		try {
			openConn();
			
			sql = "select * from pet_notice "
					+ " where notice_no = ?";
			
			pstmt = con.prepareStatement(sql);
		
			pstmt.setInt(1, dto.getNotice_no());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(dto.getNotice_pwd().equals(rs.getString("notice_pwd"))) {
					sql = "update pet_notice set "
							+ " notice_title = ?, notice_cont = ?, "
							+ " notice_update = sysdate "
							+ " where notice_no = ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, dto.getNotice_title());
					pstmt.setString(2, dto.getNotice_cont());
					pstmt.setInt(3, dto.getNotice_no());
					
					result = pstmt.executeUpdate();
					
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
	
	// 게시글 삭제 매서드
	public int deleteNotice(int no, String pwd) {
		
		int result = 0;
		
		
		try {
			openConn();
			
			sql = "select * from pet_notice "
					+ " where notice_no = ?" ;
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(pwd.equals(rs.getString("notice_pwd")))
			      
					sql = "delete from pet_notice "
							+ " where notice_no = ?";
				   
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, no);
				
				result = pstmt.executeUpdate();
				
				sql = "update pet_notice set "
						+ " notice_no = notice_no - 1, "
						+ " notice_group = notice_group -1 "
						+ " where notice_no > ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, no);
				
				pstmt.executeUpdate();
				
		}else {
			result = -1;
		}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	
	// 답변글 step 하나 증가
	public void replyUpdate(int group, int step) {

		
			openConn();
			
			
			try {
				sql = "update pet_notice set"
						+ " notice_step = notice_step + 1 "
						+ " where notice_group = ? and notice_step > ?"; 
				
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

	}//
	
	
	// 답변글 테이블 저장
	public int replyNotice(NoticeDTO dto) {
		int result = 0, count = 0;
		
		
		try {
			openConn();
			
			sql = "select max(notice_no) from pet_notice";
			
			pstmt = con.prepareStatement(sql);
		
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into pet_notice "
					+ " values(?, ?, ?, ?, ?, default, sysdate, '', ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			
			pstmt.setString(2, dto.getNotice_writer());
			pstmt.setString(3, dto.getNotice_title());
			pstmt.setString(4, dto.getNotice_cont());
			pstmt.setString(5, dto.getNotice_pwd());
			pstmt.setInt(6, dto.getNotice_group());
			pstmt.setInt(7, dto.getNotice_step());
			pstmt.setInt(8, dto.getNotice_indent());
			
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	// 게시물 조회
	// Notice 테이블에서 검색어에 해당하는 게시물의 수를 조회하는 메서드.
		public int searchListCount(String field, String keyword) {
			
			int count = 0;
			
			openConn();
			
			if(field.equals("title")) {
				
				try {
					sql = "select count(*) from pet_notice "
							+ " where notice_title like ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						count = rs.getInt(1);
					}
					
					rs.close(); pstmt.close(); con.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if(field.equals("content")) {
				
				try {
					sql = "select count(*) from pet_notice "
							+ " where notice_cont like ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						count = rs.getInt(1);
					}
					
					rs.close(); pstmt.close(); con.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if(field.equals("notice_content")) {
				
				try {
					sql = "select count(*) from pet_notice "
							+ " where notice_title like ?"
							+ " or notice_cont like ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					pstmt.setString(2, "%"+keyword+"%");
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
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
							+ " where notice_writer like ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						count = rs.getInt(1);
					}
					
					rs.close(); pstmt.close(); con.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
			return count;		
	} //// searchListCount() 메서드 end
	
		public List<NoticeDTO> searchNoticeList(
				String field, String keyword, int page, int rowsize) {
			
			List<NoticeDTO> list = new ArrayList<NoticeDTO>();
			
			// 해당 페이지에서 시작 번호
			int startNo = (page * rowsize) - (rowsize - 1);
			
			// 해당 페이지에서 마지막 번호
			int endNo = (page * rowsize);
			
			openConn();
			
			if(field.equals("title")) {
				
				try {
					sql = "select * from "
							+ " (select row_number() "
							+ " over(order by notice_no desc) rnum, "
							+ " b.* from pet_notice b where notice_title like ?) "
							+ " where rnum >= ? and rnum <= ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					pstmt.setInt(2, startNo);
					
					pstmt.setInt(3, endNo);
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						NoticeDTO dto = new NoticeDTO();
						
						dto.setNotice_no(rs.getInt("notice_no"));
						dto.setNotice_writer(rs.getString("notice_writer"));
						dto.setNotice_title(rs.getString("notice_title"));
						dto.setNotice_cont(rs.getString("notice_cont"));
						dto.setNotice_pwd(rs.getString("notice_pwd"));
						dto.setNotice_hit(rs.getInt("notice_hit"));
						dto.setNotice_date(rs.getString("notice_date"));
						dto.setNotice_update(rs.getString("notice_update"));
						
						list.add(dto);
					}
					
					rs.close(); pstmt.close(); con.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if(field.equals("content")) {
				
				try {
					sql = "select * from "
							+ " (select row_number() "
							+ " over(order by notice_no desc) rnum, "
							+ " b.* from pet_notice b where notice_cont like ?) "
							+ " where rnum >= ? and rnum <= ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					pstmt.setInt(2, startNo);
					
					pstmt.setInt(3, endNo);
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						NoticeDTO dto = new NoticeDTO();
						
						dto.setNotice_no(rs.getInt("notice_no"));
						dto.setNotice_writer(rs.getString("notice_writer"));
						dto.setNotice_title(rs.getString("notice_title"));
						dto.setNotice_cont(rs.getString("notice_cont"));
						dto.setNotice_pwd(rs.getString("notice_pwd"));
						dto.setNotice_hit(rs.getInt("notice_hit"));
						dto.setNotice_date(rs.getString("notice_date"));
						dto.setNotice_update(rs.getString("notice_update"));
						
						list.add(dto);
					}
					
					rs.close(); pstmt.close(); con.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if(field.equals("notice_content")) {
				
				try {
					sql = "select * from "
							+ " (select row_number() "
							+ " over(order by notice_no desc) rnum, "
							+ " b.* from pet_notice b where notice_title like ?"
							+ " or notice_cont like ?) "
							+ " where rnum >= ? and rnum <= ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					pstmt.setString(2, "%"+keyword+"%");
					
					pstmt.setInt(3, startNo);
					
					pstmt.setInt(4, endNo);
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						NoticeDTO dto = new NoticeDTO();
						
						dto.setNotice_no(rs.getInt("notice_no"));
						dto.setNotice_writer(rs.getString("notice_writer"));
						dto.setNotice_title(rs.getString("notice_title"));
						dto.setNotice_cont(rs.getString("notice_cont"));
						dto.setNotice_pwd(rs.getString("notice_pwd"));
						dto.setNotice_hit(rs.getInt("notice_hit"));
						dto.setNotice_date(rs.getString("notice_date"));
						dto.setNotice_update(rs.getString("notice_update"));
						
						list.add(dto);
					}
					
					rs.close(); pstmt.close(); con.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else {
				
				try {
					sql = "select * from "
							+ " (select row_number() "
							+ " over(order by notice_no desc) rnum, "
							+ " b.* from pet_notice b where notice_writer like ?) "
							+ " where rnum >= ? and rnum <= ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, "%"+keyword+"%");
					
					pstmt.setInt(2, startNo);
					
					pstmt.setInt(3, endNo);
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						NoticeDTO dto = new NoticeDTO();
						
						dto.setNotice_no(rs.getInt("notice_no"));
						dto.setNotice_writer(rs.getString("notice_writer"));
						dto.setNotice_title(rs.getString("notice_title"));
						dto.setNotice_cont(rs.getString("notice_cont"));
						dto.setNotice_pwd(rs.getString("notice_pwd"));
						dto.setNotice_hit(rs.getInt("notice_hit"));
						dto.setNotice_date(rs.getString("notice_date"));
						dto.setNotice_update(rs.getString("notice_update"));
						
						list.add(dto);
					}
					
					rs.close(); pstmt.close(); con.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
			return list;
		}  // searchNoticeList() 메서드 end	
		
		public int getNoticeCount() {
			
			int count = 0;
			
			
			try {
				openConn();
				
				sql = "select count(*) from pet_notice";
				
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
		}  // getNoticeCount() 메서드 end
	
		public List<NoticeDTO> getNoticeList(int page, int rowsize) {
			
			List<NoticeDTO> list = new ArrayList<NoticeDTO>();
			
			int startNo = (page * rowsize) - (rowsize - 1);
			int endNo = (page * rowsize);
			
			
		     try {
		    	 openConn();
					
					sql = "select * from "
							+ " (select row_number() "
							+ " over(order by notice_no desc) rnum, "
							+ " b.* from pet_notice b ) "
							+ " where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(sql);
			
				pstmt.setInt(1, startNo);
				
				pstmt.setInt(2, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					NoticeDTO dto = new NoticeDTO();
					
					dto.setNotice_no(rs.getInt("notice_no"));
					dto.setNotice_writer(rs.getString("notice_writer"));
					dto.setNotice_title(rs.getString("notice_title"));
					dto.setNotice_cont(rs.getString("notice_cont"));
					dto.setNotice_pwd(rs.getString("notice_pwd"));
					dto.setNotice_hit(rs.getInt("notice_hit"));
					dto.setNotice_date(rs.getString("notice_date"));
					dto.setNotice_update(rs.getString("notice_update"));
					
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
		
}		
