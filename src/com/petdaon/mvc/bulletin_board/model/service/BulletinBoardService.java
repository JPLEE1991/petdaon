package com.petdaon.mvc.bulletin_board.model.service;

import static com.petdaon.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.petdaon.mvc.bulletin_board.model.dao.BulletinBoardDao;
import com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard;

public class BulletinBoardService {

	private BulletinBoardDao buttetinBoardDao = new BulletinBoardDao();
	
	public List<BulletinBoard> selectBoardList(int start, int end) {
		Connection conn = getConnection();
		List<BulletinBoard> list = buttetinBoardDao.selectBoardList(conn, start, end);
		close(conn);
		return null;
	}

}
