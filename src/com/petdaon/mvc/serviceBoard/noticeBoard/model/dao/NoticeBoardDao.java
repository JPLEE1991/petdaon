package com.petdaon.mvc.serviceBoard.noticeBoard.model.dao;

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

import com.petdaon.mvc.serviceBoard.noticeBoard.model.exception.NoticeBoardException;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard;


public class NoticeBoardDao {
	
	private Properties prop = new Properties();

	public NoticeBoardDao() {
		String filepath = NoticeBoardDao.class.getResource("/sql/serviceBoard/noticeBoard/noticeBoard-query.properties").getPath();
		try {
			prop.load(new FileReader(filepath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<NoticeBoard> selectNoticeBoardList(Connection conn, int start, int end) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectNoticeBoardList");
		List<NoticeBoard> list = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rset = pstmt.executeQuery();
			
			while(rset.next()) {
			    NoticeBoard noticeBoard = new NoticeBoard();
			    noticeBoard.setNo(rset.getInt("no"));
			    noticeBoard.setWriter(rset.getString("writer"));
			    noticeBoard.setTitle(rset.getString("title"));
			    noticeBoard.setContent(rset.getString("content"));
			    noticeBoard.setEnrollDate(rset.getDate("enroll_date"));
			    noticeBoard.setViewNum(rset.getInt("view_num"));
			    noticeBoard.setBoardCode(rset.getString("board_code"));
				list.add(noticeBoard);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int selectTotalContents(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectTotalContents");
		int totalContents = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalContents = rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalContents;
	}

	public NoticeBoard selectOneNoticeBoard(Connection conn, int no) {
		NoticeBoard noticeBoard = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOneNoticeBoard");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				noticeBoard = new NoticeBoard();
				noticeBoard.setNo(rset.getInt("no"));
				noticeBoard.setWriter(rset.getString("writer"));
				noticeBoard.setTitle(rset.getString("title"));
				noticeBoard.setContent(rset.getString("content"));
				noticeBoard.setEnrollDate(rset.getDate("enroll_date"));
				noticeBoard.setViewNum(rset.getInt("view_num"));
				noticeBoard.setBoardCode(rset.getString("board_code"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return noticeBoard;
	}

	public int updateViewNum(Connection conn, int no) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateViewNum");
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
				
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new NoticeBoardException("조회수1증가 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteNoticeBoard(Connection conn, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("deleteNoticeBoard");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int insertNoticeBoard(Connection conn, NoticeBoard noticeBoard) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertNoticeBoard");
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, noticeBoard.getWriter());
			pstmt.setString(2, noticeBoard.getTitle());
			pstmt.setString(3, noticeBoard.getContent());
				
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateNoticeBoard(Connection conn, NoticeBoard noticeBoard) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("updateNoticeBoard"); 
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, noticeBoard.getTitle());
			pstmt.setString(2, noticeBoard.getContent());
			pstmt.setInt(3, noticeBoard.getNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
}
