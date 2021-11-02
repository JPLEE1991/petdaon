package com.petdaon.mvc.volunteer_board.model.dao;

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

import com.petdaon.mvc.common.vo.BoardComment;
import com.petdaon.mvc.volunteer_board.model.exception.BoardException;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerApplicationExt;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;


public class VolunteerBoardDao {
	
	private Properties prop = new Properties();
	
	/**
	 * prop객체에 buildpath로 배포된 /sql/board/board-query.properties 불러오기
	 */
	public VolunteerBoardDao() {
		String filepath = VolunteerBoardDao.class.getResource("/sql/volunteer_board/volunteer_board-query.properties").getPath();
		try {
			prop.load(new FileReader(filepath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 봉사 게시글 등록
	public int insertVolunteerBoard(Connection conn, VolunteerBoard board) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertVolunteerBoard"); 
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getCenterName());
			pstmt.setString(3, board.getContent());
			pstmt.setDate(4, board.getStartDate());
			pstmt.setDate(5, board.getEndDate());
			pstmt.setString(6, board.getEmail());
			pstmt.setString(7, board.getPhone());
			pstmt.setInt(8, board.getCapacity());
			pstmt.setString(9, board.getPlace());
			pstmt.setDate(10, board.getDeadlineDate());
			pstmt.setString(11, board.getTime());
			pstmt.setString(12, board.getDay());
			pstmt.setString(13, board.getBoardCode());
			pstmt.setString(14, board.getWriter());
			pstmt.setString(15, board.getThumbnail());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException("봉사 게시글 등록 오류", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 승인상태인 전체 봉사 게시글 조회
	public List<VolunteerBoard> selectVolunteerBoardList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectVolunteerBoardList");
		List<VolunteerBoard> list = new ArrayList<>();
		
		// 1.PreparedStatment객체 생성 & 미완성쿼리 값대입
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				// 테이블 record 1 -> VO객체 1
				VolunteerBoard board = new VolunteerBoard();
				board.setNo(rset.getInt("no"));
				board.setTitle(rset.getString("title"));
				board.setCenterName(rset.getString("center_name"));
				board.setContent(rset.getString("content"));
				board.setStartDate(rset.getDate("start_date"));
				board.setEndDate(rset.getDate("end_date"));
				board.setEmail(rset.getString("email"));
				board.setPhone(rset.getString("phone"));
				board.setApprovalYn(rset.getString("approval_yn"));
				board.setDeleteYn(rset.getString("delete_yn"));
				board.setCapacity(rset.getInt("capacity"));
				board.setPlace(rset.getString("place"));
				board.setDeadlineDate(rset.getDate("deadline_date"));
				board.setRegDate(rset.getDate("reg_date"));
				board.setTime(rset.getString("time"));
				board.setDay(rset.getString("day"));
				board.setBoardCode(rset.getString("board_code"));
				board.setWriter(rset.getString("writer"));
				board.setEnrollYn(rset.getString("enroll_yn"));
				board.setThumbnail(rset.getString("thumbnail"));
				
				//보드를 리스트에 추가한다.
				list.add(board);
			}
			
		} catch (Exception e) {
			throw new BoardException("승인 봉사 게시글 전체 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	// 봉사게시글 한건조회(상세보기)
	public VolunteerBoard selectOneVolunteerBoard(Connection conn, int no) {
		VolunteerBoard board = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOneVolunteerBoard");
		
		try {
			// 미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(sql);
			// ?값 세팅한다.
			pstmt.setInt(1, no);
			// 쿼리문 실행
			rset = pstmt.executeQuery();
			
			// 0 또는 1건이 존재하므로 if조건문 실행
			if(rset.next()) {
				board = new VolunteerBoard();
				board.setNo(rset.getInt("no"));
				board.setTitle(rset.getString("title"));
				board.setCenterName(rset.getString("center_name"));
				board.setContent(rset.getString("content"));
				board.setStartDate(rset.getDate("start_date"));
				board.setEndDate(rset.getDate("end_date"));
				board.setEmail(rset.getString("email"));
				board.setPhone(rset.getString("phone"));
				board.setApprovalYn(rset.getString("approval_yn"));
				board.setDeleteYn(rset.getString("delete_yn"));
				board.setCapacity(rset.getInt("capacity"));
				board.setPlace(rset.getString("place"));
				board.setDeadlineDate(rset.getDate("deadline_date"));
				board.setRegDate(rset.getDate("reg_date"));
				board.setTime(rset.getString("time"));
				board.setDay(rset.getString("day"));
				board.setBoardCode(rset.getString("board_code"));
				board.setWriter(rset.getString("writer"));
				board.setEnrollYn(rset.getString("enroll_yn"));
				board.setThumbnail(rset.getString("thumbnail"));
			}
		} catch (Exception e) {
			throw new BoardException("봉사 게시글 상세보기 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return board;
	}

	// 담당자 이름 표기를 위한 봉사게시글 작성자 이름 조회
	public String selectWriterName(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectWriterName");
		String name = "";
		
		try {
			// 미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(sql);
			// ?값 세팅한다.
			pstmt.setInt(1, no);
			// 쿼리문 실행
			rset = pstmt.executeQuery();
			if(rset.next()) {
				name = rset.getString(1);
			}
			
		} catch (Exception e) {
			throw new BoardException("봉사 게시글 작성자 이름 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return name;
	}

	// 봉사 게시글 신청인원수 가져오기
	public int selectApplicationCount(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectApplicationCount");
		int applicationCnt = 0;
		
		try {
			// 미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(sql);
			// ?값 세팅한다.
			pstmt.setInt(1, no);
			// 쿼리문 실행
			rset = pstmt.executeQuery();
			if(rset.next()) {
				applicationCnt = rset.getInt(1);
			}
			
		} catch (Exception e) {
			throw new BoardException("봉사 게시글 신청인원수 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return applicationCnt;
	}

	// 봉사 신청 등록
	public int insertVolunteerApplication(Connection conn, String memberId, int boardNo) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertVolunteerApplication"); 
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			pstmt.setString(2, memberId);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException("봉사 신청 등록 오류", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 신청자 리스트 가져오기(이름, 이메일, 휴대폰 정보까지 가져와야 하므로 VolunteerApplicationExt 이용)
	public List<VolunteerApplicationExt> selectVolunteerApplicationList(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectVolunteerApplicationList");
		List<VolunteerApplicationExt> applicationList = new ArrayList<>();
		
		// 1.PreparedStatment객체 생성 & 미완성쿼리 값대입
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				// 테이블 record 1 -> VO객체 1
				VolunteerApplicationExt application = new VolunteerApplicationExt();
				application.setNo(rset.getInt("no"));
				application.setApprovalYn(rset.getString("approval_yn"));
				application.setApplicationYn(rset.getString("application_yn"));
				application.setRegDate(rset.getDate("reg_date"));
				application.setBoardNo(rset.getInt("board_no"));
				application.setBoardCode(rset.getString("board_code"));
				application.setApplicant(rset.getString("applicant"));
				application.setMemberName(rset.getString("member_name"));
				application.setPhone(rset.getString("phone"));
				application.setEmail(rset.getString("email"));
				
				//신청자 리스트에 추가한다.
				applicationList.add(application);
			}
			
		} catch (Exception e) {
			throw new BoardException("신청현황 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return applicationList;
	
	}

	// 댓글(문의/답변) 등록
	// dao에서 commentRef필드는 setObject를 사용할 것. int, null 모두 ?에 설정가능
	// - 0이면 null이 대입
	// - n이면 n이 대입
	public int insertVolunteerBoardComment(Connection conn, BoardComment bc) {
		PreparedStatement pstmt = null;
		//insert into board_comment values(seq_board_comment_no.nextval, ?, ?, ?, ?, default, default, ?, ?)
		//? 순서 각각 writer, comment_level, content, comment_ref, board_code, board_no
		String sql = prop.getProperty("insertVolunteerBoardComment");
		int result = 0;
		
		try {
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bc.getWriter());
			pstmt.setInt(2, bc.getCommentLevel());
			pstmt.setString(3, bc.getContent());
			pstmt.setObject(4, bc.getCommentRef() == 0 ? null : bc.getCommentRef());
			pstmt.setString(5, bc.getBoardCode());
			pstmt.setInt(6, bc.getBoardNo());
			
			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			//DML은 executeUpdate()
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("문의/답변 등록 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 댓글(문의/답변)목록 가져오기
	public List<BoardComment> selectCommentList(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCommentList");
		List<BoardComment> commentList = new ArrayList<>();
		
		try {
			// 미완성 쿼리 값 대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			// 쿼리문 실행
			rset = pstmt.executeQuery();
			while(rset.next()) {
				BoardComment bc = new BoardComment();
				bc.setNo(rset.getInt("no"));
				bc.setWriter(rset.getString("writer"));
				bc.setCommentLevel(rset.getInt("comment_level"));
				bc.setContent(rset.getString("content"));
				bc.setCommentRef(rset.getInt("comment_ref"));
				bc.setRegDate(rset.getDate("reg_date"));
				bc.setDeleteYn(rset.getString("delete_yn"));
				bc.setBoardCode(rset.getString("board_code"));
				bc.setBoardNo(rset.getInt("board_no"));
				
				//코멘트리스트에 추가한다.
				commentList.add(bc);
			}
			
		} catch (SQLException e) {
			throw new BoardException("문의/답변 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return commentList;
	}

	// 댓글(문의/답변) 삭제(삭제여부 삭제상태로 변경)
	public int deleteVolunteerBoardComment(Connection conn, int no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteVolunteerBoardComment");
		
		try {
			// 미완성 쿼리 값 대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			// 쿼리문 실행
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("문의/답변 삭제 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 봉사신청 승인여부 변경
	public int updateVolunteerApplicationApproval(Connection conn, String approvalStatus, int no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateVolunteerApplicationApproval");
		
		try {
			// 미완성 쿼리 값 대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, approvalStatus);
			pstmt.setInt(2, no);
			// 쿼리문 실행
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("봉사신청 승인여부 변경 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 게시물 삭제 - 삭제여부 변경
	public int deleteVolunteerBoard(Connection conn, int no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteVolunteerBoard");
		
		try {
			// 미완성 쿼리 값 대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			// 쿼리문 실행
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("봉사게시글 삭제 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 썸네일 제거 - null 처리
	public int deleteThumbnail(Connection conn, VolunteerBoard board) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteThumbnail");
		
		try {
			// 미완성 쿼리 값 대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board.getNo());
			// 쿼리문 실행
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BoardException("썸네일 삭제 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 봉사 게시물 수정
	public int updateVolunteerBoard(Connection conn, VolunteerBoard board) {
		PreparedStatement pstmt = null;
		// update volunteer set title = ?, center_name = ?, content = ?, start_date = ?, end_date = ?, email = ?, phone = ?, capacity = ?, place = ?, deadline_date = ?, time = ?, day = ?, thumbnail = ? where no = ?
		// ? 순서 각각 title, center_name, content, start_date, end_date, 
		// email, phone, capacity, place, deadline_date, time, day, thumbnail, no
		String sql = prop.getProperty("updateVolunteerBoard"); 
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getCenterName());
			pstmt.setString(3, board.getContent());
			pstmt.setDate(4, board.getStartDate());
			pstmt.setDate(5, board.getEndDate());
			pstmt.setString(6, board.getEmail());
			pstmt.setString(7, board.getPhone());
			pstmt.setInt(8, board.getCapacity());
			pstmt.setString(9, board.getPlace());
			pstmt.setDate(10, board.getDeadlineDate());
			pstmt.setString(11, board.getTime());
			pstmt.setString(12, board.getDay());
			pstmt.setString(13, board.getThumbnail());
			pstmt.setInt(14, board.getNo());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException("봉사 게시글 수정 오류", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 총 봉사게시글 리스트 가져오기(삭제여부, 승인여부 가리지 않고 전부 가져온다.)
	public List<VolunteerBoard> selectAllVolunteerBoardList(Connection conn, int startRownum, int endRownum) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAllVolunteerBoardList");
		List<VolunteerBoard> list = new ArrayList<>();
		
		// 1.PreparedStatment객체 생성 & 미완성쿼리 값대입
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRownum);
			pstmt.setInt(2, endRownum);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				// 테이블 record 1 -> VO객체 1
				VolunteerBoard board = new VolunteerBoard();
				board.setNo(rset.getInt("no"));
				board.setTitle(rset.getString("title"));
				board.setCenterName(rset.getString("center_name"));
				board.setContent(rset.getString("content"));
				board.setStartDate(rset.getDate("start_date"));
				board.setEndDate(rset.getDate("end_date"));
				board.setEmail(rset.getString("email"));
				board.setPhone(rset.getString("phone"));
				board.setApprovalYn(rset.getString("approval_yn"));
				board.setDeleteYn(rset.getString("delete_yn"));
				board.setCapacity(rset.getInt("capacity"));
				board.setPlace(rset.getString("place"));
				board.setDeadlineDate(rset.getDate("deadline_date"));
				board.setRegDate(rset.getDate("reg_date"));
				board.setTime(rset.getString("time"));
				board.setDay(rset.getString("day"));
				board.setBoardCode(rset.getString("board_code"));
				board.setWriter(rset.getString("writer"));
				board.setEnrollYn(rset.getString("enroll_yn"));
				board.setThumbnail(rset.getString("thumbnail"));
				
				//보드를 리스트에 추가한다.
				list.add(board);
			}
			
		} catch (Exception e) {
			throw new BoardException("관리자 봉사 게시글 전체 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	// 총봉사게시글수 조회
	public int selectTotalVolunteerContents(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectTotalVolunteerContents");
		int totalContents = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			// 쿼리문 실행
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalContents = rset.getInt(1); //1은 첫번째 컬럼값을 주세요 라는 의미이다. 또는 "별칭"으로 넣어도 된다. //1행 1열짜리 집합도 동일한 방식으로 해야한다는 것.
			}
			
		} catch (Exception e) {
			throw new BoardException("총봉사게시글수 조회 오류", e);
		} finally {
			// 자원반납
			close(rset);
			close(pstmt);
		}
		
		return totalContents;
	}

}
