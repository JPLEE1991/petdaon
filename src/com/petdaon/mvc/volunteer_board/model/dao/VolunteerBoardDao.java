package com.petdaon.mvc.volunteer_board.model.dao;

import static com.petdaon.mvc.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.petdaon.mvc.volunteer_board.model.exception.BoardException;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;


public class VolunteerBoardDao {
	
	private Properties prop = new Properties();
	
	/**
	 * prop객체에 buildpath로 배포된 /sql/board/board-query.properties 불러오기
	 */
	public VolunteerBoardDao() {
		String filepath = VolunteerBoardDao.class.getResource("/sql/volunteer_board/volunteer_board-query.properties").getPath();
		try {
			prop.load(new FileReader(filepath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 봉사 게시글 등록
	public int insertVolunteerBoard(Connection conn, VolunteerBoard board) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertVolunteerBoard"); 
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getCenterName());
			pstmt.setString(3, board.getContent());
			pstmt.setDate(4, board.getStartDate());
			pstmt.setDate(5, board.getEndDate());
			pstmt.setString(6, board.getEmail());
			pstmt.setString(7, board.getPhone());
			pstmt.setInt(8, board.getCapacity());
			pstmt.setString(9, board.getPlace());
			pstmt.setDate(10, board.getDeadlineDate());
			pstmt.setString(11, board.getTime());
			pstmt.setString(12, board.getDay());
			pstmt.setString(13, board.getBoardCode());
			pstmt.setString(14, board.getWriter());
			pstmt.setString(15, board.getThumbnail());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException("봉사 게시글 등록 오류", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 승인상태인 전체 봉사 게시글 조회
	public List<VolunteerBoard> selectVolunteerBoardList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectVolunteerBoardList");
		List<VolunteerBoard> list = new ArrayList<>();
		
		// 1.PreparedStatment객체 생성 & 미완성쿼리 값대입
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				// 테이블 record 1 -> VO객체 1
				VolunteerBoard board = new VolunteerBoard();
				board.setNo(rset.getInt("no"));
				board.setTitle(rset.getString("title"));
				board.setCenterName(rset.getString("center_name"));
				board.setContent(rset.getString("content"));
				board.setStartDate(rset.getDate("start_date"));
				board.setEndDate(rset.getDate("end_date"));
				board.setEmail(rset.getString("email"));
				board.setPhone(rset.getString("phone"));
				board.setApprovalYn(rset.getString("approval_yn"));
				board.setDeleteYn(rset.getString("delete_yn"));
				board.setCapacity(rset.getInt("capacity"));
				board.setPlace(rset.getString("place"));
				board.setDeadlineDate(rset.getDate("deadline_date"));
				board.setRegDate(rset.getDate("reg_date"));
				board.setTime(rset.getString("time"));
				board.setDay(rset.getString("day"));
				board.setBoardCode(rset.getString("board_code"));
				board.setWriter(rset.getString("writer"));
				board.setEnrollYn(rset.getString("enroll_yn"));
				board.setThumbnail(rset.getString("thumbnail"));
				
				//보드를 리스트에 추가한다.
				list.add(board);
			}
			
		} catch (Exception e) {
			throw new BoardException("승인 봉사 게시글 전체 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	// 봉사게시글 한건조회(상세보기)
	public VolunteerBoard selectOneVolunteerBoard(Connection conn, int no) {
		VolunteerBoard board = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOneVolunteerBoard");
		
		try {
			// 미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(sql);
			// ?값 세팅한다.
			pstmt.setInt(1, no);
			// 쿼리문 실행
			rset = pstmt.executeQuery();
			
			// 0 또는 1건이 존재하므로 if조건문 실행
			if(rset.next()) {
				board = new VolunteerBoard();
				board.setNo(rset.getInt("no"));
				board.setTitle(rset.getString("title"));
				board.setCenterName(rset.getString("center_name"));
				board.setContent(rset.getString("content"));
				board.setStartDate(rset.getDate("start_date"));
				board.setEndDate(rset.getDate("end_date"));
				board.setEmail(rset.getString("email"));
				board.setPhone(rset.getString("phone"));
				board.setApprovalYn(rset.getString("approval_yn"));
				board.setDeleteYn(rset.getString("delete_yn"));
				board.setCapacity(rset.getInt("capacity"));
				board.setPlace(rset.getString("place"));
				board.setDeadlineDate(rset.getDate("deadline_date"));
				board.setRegDate(rset.getDate("reg_date"));
				board.setTime(rset.getString("time"));
				board.setDay(rset.getString("day"));
				board.setBoardCode(rset.getString("board_code"));
				board.setWriter(rset.getString("writer"));
				board.setEnrollYn(rset.getString("enroll_yn"));
				board.setThumbnail(rset.getString("thumbnail"));
			}
		} catch (Exception e) {
			throw new BoardException("봉사 게시글 상세보기 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return board;
	}

	// 담당자 이름 표기를 위한 봉사게시글 작성자 이름 조회
	public String selectWriterName(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectWriterName");
		String name = "";
		
		try {
			// 미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(sql);
			// ?값 세팅한다.
			pstmt.setInt(1, no);
			// 쿼리문 실행
			rset = pstmt.executeQuery();
			if(rset.next()) {
				name = rset.getString(1);
			}
			
		} catch (Exception e) {
			throw new BoardException("봉사 게시글 작성자 이름 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return name;
	}

	// 봉사 게시글 신청인원수 가져오기
	public int selectApplicationCount(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectApplicationCount");
		int applicationCnt = 0;
		
		try {
			// 미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(sql);
			// ?값 세팅한다.
			pstmt.setInt(1, no);
			// 쿼리문 실행
			rset = pstmt.executeQuery();
			if(rset.next()) {
				applicationCnt = rset.getInt(1);
			}
			
		} catch (Exception e) {
			throw new BoardException("봉사 게시글 신청인원수 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return applicationCnt;
	}

	// 봉사 신청 등록
	public int insertVolunteerApplication(Connection conn, String memberId, int boardNo) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertVolunteerApplication"); 
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			pstmt.setString(2, memberId);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException("봉사 신청 등록 오류", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

}
