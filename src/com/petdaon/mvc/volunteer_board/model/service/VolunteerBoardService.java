package com.petdaon.mvc.volunteer_board.model.service;

import static com.petdaon.mvc.common.JdbcTemplate.close;
import static com.petdaon.mvc.common.JdbcTemplate.commit;
import static com.petdaon.mvc.common.JdbcTemplate.getConnection;
import static com.petdaon.mvc.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.petdaon.mvc.common.vo.BoardComment;
import com.petdaon.mvc.volunteer_board.model.dao.VolunteerBoardDao;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerApplicationExt;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

public class VolunteerBoardService {
	
	/**
	 * 사용자권한 상수
	 * 업무로직담당 service클래스에 선언 
	 */
	public static final String VOLUNTEER_BOARD_CODE = "03";
	
	public static final String APPROVAL_YES = "Y";
	public static final String APPROVAL_NO = "N";
	public static final String APPROVAL_WAIT = "W";
	public static final String DELETE_YES = "Y";
	public static final String DELETE_NO = "N";
	public static final String ENROLL_YES = "Y";
	public static final String ENROLL_NO = "N";
	
	//봉사신청관련 추가
	public static final String APPLICATION_YES = "Y";	// 봉사신청상태 - 신청
	public static final String APPLICATION_NO = "N";	// 봉사신청상태 - 취소
	
	
	
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

	// 신청자 리스트 가져오기(이름, 이메일, 휴대폰 정보까지 가져와야 하므로 VolunteerApplicationExt 이용)
	public List<VolunteerApplicationExt> selectVolunteerApplicationList(int no) {
		Connection conn = getConnection();
		List<VolunteerApplicationExt> applicationList = volunteerBoardDao.selectVolunteerApplicationList(conn, no);
		// 단순조회로 트랜잭션 처리하지 않음
		close(conn);
		return applicationList;
	}

	// 댓글(문의/답변) 등록
	public int insertVolunteerBoardComment(BoardComment bc) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = volunteerBoardDao.insertVolunteerBoardComment(conn, bc);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e; //controller가 예외처리를 결정할 수 있도록 넘김.
		} finally {
			close(conn);
		}
		return result;
	}

	// 댓글(문의/답변)목록 가져오기
	public List<BoardComment> selectCommentList(int no) {
		Connection conn = getConnection();
		List<BoardComment> commentList = volunteerBoardDao.selectCommentList(conn, no);
		close(conn);
		return commentList;
	}

	// 댓글(문의/답변) 삭제(삭제여부 삭제상태로 변경)
	public int deleteVolunteerBoardComment(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = volunteerBoardDao.deleteVolunteerBoardComment(conn, no);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		}
		return result;
	}

	// 봉사신청 승인여부 변경
	public int updateVolunteerApplicationApproval(String approvalStatus, int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = volunteerBoardDao.updateVolunteerApplicationApproval(conn, approvalStatus, no);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		}
		return result;
	}

	// 게시물 삭제 - 삭제여부 변경
	public int deleteVolunteerBoard(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = volunteerBoardDao.deleteVolunteerBoard(conn, no);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		}
		return result;
	}

	// 썸네일 제거 - null 처리
	public int deleteThumbnail(VolunteerBoard board) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = volunteerBoardDao.deleteThumbnail(conn, board);
			// 썸네일 제거 - null 처리
			board.setThumbnail("");
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		}
		return result;
	}

	// 게시물 수정
	public int updateVolunteerBoard(VolunteerBoard board) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = volunteerBoardDao.updateVolunteerBoard(conn, board);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		}
		return result;
	}

	// 총 봉사게시글 리스트 가져오기(삭제여부 'Y'상태 제외 나머지 전부 가져온다.)
	public List<VolunteerBoard> selectAllVolunteerBoardList(int startRownum, int endRownum) {
		Connection conn = getConnection();
		List<VolunteerBoard> list = volunteerBoardDao.selectAllVolunteerBoardList(conn, startRownum, endRownum);
		// 단순조회로 트랜잭션 처리하지 않음
		close(conn);
		return list;
	}

	// 총봉사게시글수 조회(삭제여부 'Y'상태 제외)
	public int selectTotalVolunteerContents() {
		Connection conn = getConnection();
		int totalContent = volunteerBoardDao.selectTotalVolunteerContents(conn);
		// 단순조회로 트랜잭션 처리하지 않음
		close(conn);
		return totalContent;
	}

	// 봉사게시글 승인여부 변경
	public int updateVolunteerBoardApproval(String approvalStatus, int boardNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = volunteerBoardDao.updateVolunteerBoardApproval(conn, approvalStatus, boardNo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		}
		return result;
	}

	// 검색 결과 봉사게시글(삭제여부 'Y'상태 제외)
	public List<VolunteerBoard> searchVolunteerBoard(Map<String, Object> param) {
		Connection conn = getConnection();
		List<VolunteerBoard> list = volunteerBoardDao.searchVolunteerBoard(conn, param);
		// 단순조회로 트랜잭션 처리하지 않음
		close(conn);
		return list;
	}

	// 검색 결과에 따른 봉사게시글수 조회 (삭제여부 'Y'상태 제외)
	public int searchVolunteerBoardCount(Map<String, Object> param) {
		Connection conn = getConnection();
		int totalContent = volunteerBoardDao.selectTotalVolunteerContents(conn, param);
		// 단순조회로 트랜잭션 처리하지 않음
		close(conn);
		return totalContent;
	}

}
