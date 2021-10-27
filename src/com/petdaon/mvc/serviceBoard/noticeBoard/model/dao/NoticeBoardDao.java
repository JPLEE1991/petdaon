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
}
