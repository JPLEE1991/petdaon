package com.petdaon.mvc.serviceBoard.askBoard.model.service;

import static com.petdaon.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.petdaon.mvc.serviceBoard.askBoard.model.dao.AskBoardDao;
import com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard;

public class AskBoardService {
	
	public static final String STATUS_DEFAULT = "D";
	
	private AskBoardDao askBoardDao = new AskBoardDao();
	
	public List<AskBoard> selectAskBoardList(int start, int end) {
		Connection conn = getConnection();
		List<AskBoard> list = askBoardDao.selectAskBoardList(conn, start, end);
		close(conn);
		return list;
	}
	
	public int selectTotalContents() {
		Connection conn = getConnection();
		int totalContents = askBoardDao.selectTotalContents(conn);
		close(conn);
		return totalContents;
	}

	public int insertAskBoard(AskBoard askBoard) {
		Connection conn = getConnection();
		int result = askBoardDao.insertAskBoard(conn, askBoard);
		if(result > 0) commit(conn);
		else rollback(conn);

		close(conn);
		return result;
	}

	public AskBoard selectOneAskBoard(int inquiryNo) {
		Connection conn = getConnection();
		AskBoard askBoard = askBoardDao.selectOneAskBoard(conn, inquiryNo);
		close(conn);
		return askBoard;
	}
}
