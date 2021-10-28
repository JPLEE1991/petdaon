package com.petdaon.mvc.serviceBoard.noticeBoard.model.service;

import static com.petdaon.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.petdaon.mvc.serviceBoard.noticeBoard.model.dao.NoticeBoardDao;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard;

public class NoticeBoardService {
	
	private NoticeBoardDao noticeBoardDao = new NoticeBoardDao();

	public List<NoticeBoard> selectNoticeBoardList(int start, int end) {
		Connection conn = getConnection();
		List<NoticeBoard> list = noticeBoardDao.selectNoticeBoardList(conn, start, end);
		close(conn);
		return list;
	}

	public int selectTotalContents() {
		Connection conn = getConnection();
		int totalContents = noticeBoardDao.selectTotalContents(conn);
		close(conn);
		return totalContents;
	}
}