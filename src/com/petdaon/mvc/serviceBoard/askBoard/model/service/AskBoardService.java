package com.petdaon.mvc.serviceBoard.askBoard.model.service;

import static com.petdaon.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.petdaon.mvc.serviceBoard.askBoard.model.dao.AskBoardDao;
import com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard;

public class AskBoardService {
	
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
}
