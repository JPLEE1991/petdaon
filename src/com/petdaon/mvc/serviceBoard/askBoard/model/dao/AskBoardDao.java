package com.petdaon.mvc.serviceBoard.askBoard.model.dao;

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

import com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard;

public class AskBoardDao {
	
	private Properties prop = new Properties();
	
	/**
	 * prop객체에 buildpath로 배포된 /sql/serviceBoard/askBoard/askBoard-query.properties 불러오기
	 */
	public AskBoardDao() {
		String filepath = AskBoardDao.class.getResource("/sql/serviceBoard/askBoard/askBoard-query.properties").getPath();
		try {
			prop.load(new FileReader(filepath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<AskBoard> selectAskBoardList(Connection conn, int start, int end) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAskBoardList");
		List<AskBoard> list = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				AskBoard askBoard = new AskBoard();
				askBoard.setInquiryNo(rset.getInt("inquiry_no"));
				askBoard.setBoardCode(rset.getString("board_code"));
				askBoard.setWriter(rset.getString("writer"));
				askBoard.setStatus(rset.getString("status"));
				askBoard.setInquiryTitle(rset.getString("inquiry_title"));
				askBoard.setInquiryContent(rset.getString("inquiry_content"));
				askBoard.setEnrollDate(rset.getDate("enroll_date"));
				askBoard.setAnswer(rset.getString("answer"));
				askBoard.setAnswerDate(rset.getDate("answer_date"));
				askBoard.setAdminId(rset.getString("admin_id"));
				list.add(askBoard);
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
