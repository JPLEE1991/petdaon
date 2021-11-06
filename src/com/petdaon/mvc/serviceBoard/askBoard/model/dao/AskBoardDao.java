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

	
	public AskBoard selectOneAskBoard(Connection conn, int inquiryNo) {
		AskBoard askBoard = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOneAskBoard");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inquiryNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				askBoard = new AskBoard();
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
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return askBoard;
	}
	
	public int insertAskBoard(Connection conn, AskBoard askBoard) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAskBoard");
		int result = 0;
			
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, askBoard.getWriter());
			pstmt.setString(2, askBoard.getInquiryTitle());
			pstmt.setString(3, askBoard.getInquiryContent());
				
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateAskBoard(Connection conn, AskBoard askBoard) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("updateAskBoard");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, askBoard.getAnswer());
			pstmt.setString(2, askBoard.getAdminId());
			pstmt.setInt(3, askBoard.getInquiryNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateInquiryStatus(Connection conn, String inquiryNo, String status) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("updateInquiryStatus"); 
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, status);
			pstmt.setString(2, inquiryNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateInquiryStatusCancel(Connection conn, int inquiryNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("updateInquiryStatusCancel"); 
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, inquiryNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
}
