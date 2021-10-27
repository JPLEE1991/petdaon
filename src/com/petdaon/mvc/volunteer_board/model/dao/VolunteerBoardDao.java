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
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("봉사 게시글 등록 오류", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 전체 봉사 게시글 조회
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
				
				list.add(board);
			}
			
		} catch (SQLException e) {
			throw new BoardException("봉사 게시글 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
}
