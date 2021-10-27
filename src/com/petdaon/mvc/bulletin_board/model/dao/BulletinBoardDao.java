package com.petdaon.mvc.bulletin_board.model.dao;

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

import com.petdaon.mvc.bulletin_board.model.exception.BulletinBoardException;
import com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard;
import com.petdaon.mvc.common.vo.Attachment;

public class BulletinBoardDao {
	
	private Properties prop = new Properties();
	
	/**
	 * prop객체에 buildpath로 배포된  /sql/bulletin_board/board-query.properties 불러오기
	 */
	public BulletinBoardDao() {
		String filepath = BulletinBoardDao.class.getResource("/sql/bulletin_board/bulletin_board-query.properties").getPath();
		try {
			prop.load(new FileReader(filepath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<BulletinBoard> selectBoardList(Connection conn, int start, int end) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public List<BulletinBoard> selectBoardLsit(Connection conn, int start, int end) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectBoardList");
		List<BulletinBoard> list = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				// 테이블의 record 1 -> vo객체 1
				BulletinBoard bboard = new BulletinBoard();
				bboard.setNo(rset.getInt("no"));
				bboard.setTitle(rset.getString("tite"));
				bboard.setWriter(rset.getString("writer"));
				bboard.setContent(rset.getString("content"));
				bboard.setRegDate(rset.getDate("ENROLL_DATE"));
				bboard.setReadCount(rset.getInt("VIEW_NUM"));
				
				list.add(bboard);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int insertBoard(Connection conn, BulletinBoard board) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertBoard");
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getWriter());
			pstmt.setString(3, board.getContent());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BulletinBoardException("게시글 등록 오류", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int selectLastBoardNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectLastBoardNo");
		int boardNo = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				boardNo = rset.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new BulletinBoardException("게시글번호 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return boardNo;
	}

	public int insertAttachment(Connection conn, Attachment attach) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAttachment");
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attach.getBoardNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BulletinBoardException("첨부파일 등록 오류", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
}
