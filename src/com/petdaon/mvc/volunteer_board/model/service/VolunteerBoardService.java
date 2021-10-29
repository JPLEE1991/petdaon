package com.petdaon.mvc.volunteer_board.model.service;

import static com.petdaon.mvc.common.JdbcTemplate.close;
import static com.petdaon.mvc.common.JdbcTemplate.commit;
import static com.petdaon.mvc.common.JdbcTemplate.getConnection;
import static com.petdaon.mvc.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.petdaon.mvc.volunteer_board.model.dao.VolunteerBoardDao;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

public class VolunteerBoardService {
	
	/**
	 * 사용자권한 상수
	 * 업무로직담당 service클래스에 선언 
	 */
	public static final String VOLUNTEER_BOARD_CODE = "03";
	
	public static final String APPROVAL_YES = "Y";
	public static final String APPROVAL_NO = "N";
	public static final String DELETE_YES = "Y";
	public static final String DELETE_NO = "N";
	public static final String ENROLL_YES = "Y";
	public static final String ENROLL_NO = "N";
	
	private VolunteerBoardDao volunteerBoardDao = new VolunteerBoardDao();

	// 봉사 게시글 등록
	public int insertVolunteerBoard(VolunteerBoard board) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			result = volunteerBoardDao.insertVolunteerBoard(conn, board);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e; //controller가 예외처리를 결정할 수 있도록 넘김.
		} finally {
			close(conn);
		}
		
		return result;
	}

	// 승인상태인 전체 봉사 게시글 조회
	public List<VolunteerBoard> selectVolunteerBoardList() {
		Connection conn = getConnection();
		List<VolunteerBoard> list = volunteerBoardDao.selectVolunteerBoardList(conn);
		// 단순조회로 트랜잭션 처리하지 않음
		close(conn);
		return list;
	}

	// 봉사게시글 한건조회(상세보기)
	public VolunteerBoard selectOneVolunteerBoard(int no) {
		Connection conn = getConnection();
		VolunteerBoard board = volunteerBoardDao.selectOneVolunteerBoard(conn, no);
		// 단순조회로 트랜잭션 처리하지 않음
		close(conn);
		return board;
	}

	// 담당자 이름 표기를 위한 봉사게시글 작성자 이름 조회
	public String selectWriterName(int no) {
		Connection conn = getConnection();
		String name = volunteerBoardDao.selectWriterName(conn, no);
		// 단순조회로 트랜잭션 처리하지 않음
		close(conn);
		return name;
	}

	// 봉사 게시글 신청인원 수 가져오기
	public int selectApplicationCount(int no) {
		Connection conn = getConnection();
		int applicationCnt = volunteerBoardDao.selectApplicationCount(conn, no);
		// 단순조회로 트랜잭션 처리하지 않음
		close(conn);
		return applicationCnt;
	}

	// 봉사 신청 등록
	public int insertVolunteerApplication(String memberId, int boardNo) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			result = volunteerBoardDao.insertVolunteerApplication(conn, memberId, boardNo);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e; //controller가 예외처리를 결정할 수 있도록 넘김.
		} finally {
			close(conn);
		}
		
		return result;
	}

}
