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

public class PetQandADAO {
	Connection con = null; // DB 연결하는 객체
	PreparedStatement pstmt = null; // DB에 SQL문을 전송하는 객체
	ResultSet rs = null; // SQL문 실행 후 결과 값을 가지고 있는 객체

	String sql = ""; // SQL문을 저장할 객체

	// PetQandADAO 객체를 싱글턴 방식으로 만들어보자**
	// 1. 싱글턴 방식으로 객체를 만들기 위해서는 우선적으로
	// 기본 생성자의 접근 제어자를 public > private로 바꿔주어야 한다.

	// 2. PetQandADAO 객체를 정적 멤버로 선언해주어야한다. - static으로 선언해야함.
	private static PetQandADAO instance;

	private PetQandADAO() {
	} // 기본 생성자

	// 3. 기본 생성자 대신에 싱글턴 객체를 return 해주는 getInstance() 라는 메서드를
	// 만들어서 이 getInstance() 메서드에 외부에서 접근할 수 있게 해야함.
	public static PetQandADAO getInstance() {
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
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/myoracle");

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

	// QA 게시판 전체 게시글 수 확인
	public int getPetQandACount() {
		int count = 0;

		try {
			openConn();
			sql = "select count(*) from pet_QandA";
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
	} // getPetQandACount()

	// QA 게시판 리스트 불러오기
	public List<PetQandADTO> getPetQandAList(int page, int rowsize) {
		List<PetQandADTO> list = new ArrayList<PetQandADTO>();
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);

		try {
			openConn();
			sql = "select * from " + "(select row_number() " + "over(order by QA_no desc) qnum, "
					+ "p.* from pet_QandA p) " + "where qnum >= ? and qnum <= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				PetQandADTO dto = new PetQandADTO();

				dto.setQA_no(rs.getInt("QA_no"));
				dto.setQA_writer(rs.getString("QA_writer"));
				dto.setQA_title(rs.getString("QA_title"));
				dto.setQA_cont(rs.getString("QA_cont"));
				dto.setQA_userID(rs.getString("QA_userID"));
				dto.setQA_date(rs.getString("QA_date"));
				dto.setQA_update(rs.getString("QA_update"));
				dto.setQA_group(rs.getInt("QA_group"));
				dto.setQA_step(rs.getInt("QA_step"));
				dto.setQA_indent(rs.getInt("QA_indent"));

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return list;
	} // getPetQandAList()

	// 로그인 아이디와 게시글의 userID와 일치하는지 확인
	public int checkPetQandAId(int no, String id) {
		int result = 0;

		try {
			openConn();
			sql = "select * from pet_QandA where QA_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (id.equals(rs.getString("QA_userID"))) {
					result = 1;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}

	// 게시글 내용 불러오기
	public PetQandADTO getPetQandACont(int no) {
		PetQandADTO dto = new PetQandADTO();

		try {
			openConn();
			sql = "select * from pet_QandA where QA_no = ? order by QA_no desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setQA_no(rs.getInt("QA_no"));
				dto.setQA_writer(rs.getString("QA_writer"));
				dto.setQA_title(rs.getString("QA_title"));
				dto.setQA_cont(rs.getString("QA_cont"));
				dto.setQA_userID(rs.getString("QA_userID"));
				dto.setQA_date(rs.getString("QA_date"));
				dto.setQA_update(rs.getString("QA_update"));
				dto.setQA_group(rs.getInt("QA_group"));
				dto.setQA_step(rs.getInt("QA_step"));
				dto.setQA_indent(rs.getInt("QA_indent"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return dto;
	}//

	// 게시글 등록
	public int insertPetQandA(PetQandADTO dto) {
		int result = 0, count = 0;

		try {
			openConn();
			sql = "select max(QA_no) from pet_QandA";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1) + 1;
			}

			sql = "insert into pet_QandA " + "values(?, ?, ?, ?, ?, sysdate, '', ?, 0, 0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getQA_writer());
			pstmt.setString(3, dto.getQA_title());
			pstmt.setString(4, dto.getQA_cont());
			pstmt.setString(5, dto.getQA_userID());
			pstmt.setInt(6, count);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} // insertPetQandA()

	// 게시물 수정
	public int updatePetQandA(PetQandADTO dto) {
		int result = 0;
		openConn();

		sql = "update pet_QandA set QA_title = ?, " + " QA_cont = ?, QA_update = sysdate " + " where QA_no = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getQA_title());
			pstmt.setString(2, dto.getQA_cont());
			pstmt.setInt(3, dto.getQA_no());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return result;
	}

	// 게시물 삭제
	public int deletePetQandA(int no) {
		int result = 0;
		try {
			openConn();
			sql = "delete from pet_QandA " + "where QA_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
			sql = "update pet_QandA set " + "QA_no = QA_no - 1, " + "QA_group = QA_group - 1" + "where QA_no > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}

	// 검색
	// board테이블에서 검색어에 해당하는 게시물의 수를 조회하는 메서드
	public int searchListCount(String field, String keyword) {
		int count = 0;
		openConn();

		if (field.equals("title")) { // 제목으로 검색
			try {
				sql = "select count(*) from pet_QandA " + " where QA_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				rs = pstmt.executeQuery();

				if (rs.next()) {
					count = rs.getInt(1);
				}
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (field.equals("content")) {// 내용으로 검색
			try {
				sql = "select count(*) from pet_QandA " + " where QA_cont like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				rs = pstmt.executeQuery();

				if (rs.next()) {
					count = rs.getInt(1);
				}
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (field.equals("title_content")) {
			try {
				sql = "select count(*) from pet_QandA " + " where QA_title like ? " + " or QA_cont like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setString(2, "%" + keyword + "%");
				rs = pstmt.executeQuery();

				if (rs.next()) {
					count = rs.getInt(1);
				}
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			try {
				sql = "select count(*) from pet_QandA " + " where QA_writer like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setString(2, "%" + keyword + "%");
				rs = pstmt.executeQuery();

				if (rs.next()) {
					count = rs.getInt(1);
				}
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return count;
	} // searchListCount() end

	// board 테이블에서 검색한 내용을 가지고 페이징 처리를 하는 메서드
	public List<PetQandADTO> searchBoardList(String field, String keyword, int page, int rowsize) {
		List<PetQandADTO> list = new ArrayList<PetQandADTO>();

		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);

		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);

		openConn();
		if (field.equals("title")) { //
			try {

				sql = "select * from " + "(select row_number() " + "over(order by QA_no desc) qnum, "
						+ "p.* from pet_QandA p where QA_title like ?) " + "where qnum >= ? and qnum <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					PetQandADTO dto = new PetQandADTO();

					dto.setQA_no(rs.getInt("QA_no"));
					dto.setQA_writer(rs.getString("QA_writer"));
					dto.setQA_title(rs.getString("QA_title"));
					dto.setQA_cont(rs.getString("QA_cont"));
					dto.setQA_userID(rs.getString("QA_userID"));
					dto.setQA_date(rs.getString("QA_date"));
					dto.setQA_update(rs.getString("QA_update"));
					dto.setQA_group(rs.getInt("QA_group"));
					dto.setQA_step(rs.getInt("QA_step"));
					dto.setQA_indent(rs.getInt("QA_indent"));
					list.add(dto);
				}
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (field.equals("content")) { //
			try {
				sql = "select * from " + "(select row_number() " + "over(order by QA_no desc) qnum, "
						+ "p.* from pet_QandA p where QA_cont like ?) " + "where qnum >= ? and qnum <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					PetQandADTO dto = new PetQandADTO();

					dto.setQA_no(rs.getInt("QA_no"));
					dto.setQA_writer(rs.getString("QA_writer"));
					dto.setQA_title(rs.getString("QA_title"));
					dto.setQA_cont(rs.getString("QA_cont"));
					dto.setQA_userID(rs.getString("QA_userID"));
					dto.setQA_date(rs.getString("QA_date"));
					dto.setQA_update(rs.getString("QA_update"));
					dto.setQA_group(rs.getInt("QA_group"));
					dto.setQA_step(rs.getInt("QA_step"));
					dto.setQA_indent(rs.getInt("QA_indent"));

					list.add(dto);
				}
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (field.equals("title_content")) { //
			try {
				sql = "select * from " + "(select row_number() " + "over(order by QA_no desc) qnum, "
						+ "p.* from pet_QandA p where QA_title like ?" + "or QA_cont like ?) "
						+ "where qnum >= ? and qnum <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setString(2, "%" + keyword + "%");
				pstmt.setInt(3, startNo);
				pstmt.setInt(4, endNo);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					PetQandADTO dto = new PetQandADTO();

					dto.setQA_no(rs.getInt("QA_no"));
					dto.setQA_writer(rs.getString("QA_writer"));
					dto.setQA_title(rs.getString("QA_title"));
					dto.setQA_cont(rs.getString("QA_cont"));
					dto.setQA_userID(rs.getString("QA_userID"));
					dto.setQA_date(rs.getString("QA_date"));
					dto.setQA_update(rs.getString("QA_update"));
					dto.setQA_group(rs.getInt("QA_group"));
					dto.setQA_step(rs.getInt("QA_step"));
					dto.setQA_indent(rs.getInt("QA_indent"));

					list.add(dto);
				}
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else { //
			try {
				sql = "select * from " + "(select row_number() " + "over(order by QA_no desc) qnum, "
						+ "p.* from pet_QandA p where QA_writer like ?)" + "where qnum >= ? and qnum <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					PetQandADTO dto = new PetQandADTO();

					dto.setQA_no(rs.getInt("QA_no"));
					dto.setQA_writer(rs.getString("QA_writer"));
					dto.setQA_title(rs.getString("QA_title"));
					dto.setQA_cont(rs.getString("QA_cont"));
					dto.setQA_userID(rs.getString("QA_userID"));
					dto.setQA_date(rs.getString("QA_date"));
					dto.setQA_update(rs.getString("QA_update"));
					dto.setQA_group(rs.getInt("QA_group"));
					dto.setQA_step(rs.getInt("QA_step"));
					dto.setQA_indent(rs.getInt("QA_indent"));

					list.add(dto);
				}
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return list;
	} // searchBoardList() end
}
