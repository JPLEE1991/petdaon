package com.petdaon.mvc.findMe_board.model.dao;

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

import com.petdaon.mvc.common.vo.Attachment;
import com.petdaon.mvc.findMe_board.model.vo.Board;
import com.petdaon.mvc.findMe_board.model.vo.BoardExt;
import com.petdaon.mvc.serviceBoard.askBoard.model.dao.AskBoardDao;

public class BoardDao {

	private Properties prop = new Properties();

	/**
	 * prop객체에 buildpath로 배포된 /sql/board/board-query.properties 불러오기
	 */
	public BoardDao() {
		String filepath = BoardDao.class.getResource("/sql/findMe_board/findMe_board-query.properties").getPath();

		System.out.println("BoardDao filepath: " + filepath);
		try {
			prop.load(new FileReader(filepath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
//	  public List<Board> selectBoardList(Connection conn, int start, int end) {
//	  PreparedStatement pstmt = null; ResultSet rset = null; String sql =
//	  prop.getProperty("selectBoardList"); List<Board> list = new ArrayList<>();
//	  
//	  try { 
//		  pstmt = conn.prepareStatement(sql); 
//		  pstmt.setInt(1, start);
//		  pstmt.setInt(2, end);
//		  
//		  rset = pstmt.executeQuery();
//	  
//		  while(rset.next()) { // 테이블 record 1 -> VO객체 1 BoardExt board = new
//			  
//			  BoardExt board = new BoardExt(); 
//			  
//			  board.setNo(rset.getInt("no"));
//			  board.setTitle(rset.getString("title"));
//			  board.setWriter(rset.getString("writer"));
//			  board.setContent(rset.getString("content"));
//			  board.setEnrollDate(rset.getDate("enroll_date"));		  
//			  board.setBoardCommentCount(rset.getInt("bc_count"));
//			  
//			  if(rset.getInt("attach_no") != 0) { Attachment attach = new Attachment();
//			  attach.setNo(rset.getInt("attach_no"));
//			  attach.setBoardNo(rset.getInt("board_no"));
//			  attach.setOriginalFilename(rset.getString("original_filename"));
//			  attach.setRenamedFilename(rset.getString("renamed_filename"));
//			  attach.setRegDate(rset.getDate("attach_reg_date"));
//			  
//			  board.setAttach(attach); }
//			  
//		  list.add(board); }
//	  
//	  
//	  } catch (SQLException e) { e.printStackTrace(); } finally { close(rset);
//	  close(pstmt); } return list; }
	
	  public List<Board> selectBoardList(Connection conn, int start, int end) {
		  PreparedStatement pstmt = null; 
		  ResultSet rset = null; 
		  String sql = prop.getProperty("selectBoardList"); List<Board> list = new ArrayList<>();
		  System.out.println("boardDao board00 ");
		  try { 
			  pstmt = conn.prepareStatement(sql); 
			  pstmt.setInt(1, start);
			  pstmt.setInt(2, end);
			  
			  rset = pstmt.executeQuery();
		  
			  while(rset.next()) { // 테이블 record 1 -> VO객체 1 BoardExt board = new
				  
				  BoardExt board = new BoardExt(); 
				  board.setNo(rset.getInt("no"));
				  board.setAddress(rset.getString("address"));
				  board.setAnimalType(rset.getString("animal_type"));
				  board.setEnrollDate(rset.getDate("enroll_date"));		  
				  board.setBoardCommentCount(rset.getInt("bc_count"));
				  
				  
				  System.out.println("boardDao board.getAttach(): "+board.getAttach());
				  System.out.println("boardDao attach_no: "+ rset.getInt("attach_no"));
				  if(rset.getInt("attach_no") != 0) { 
					  Attachment attach = new Attachment();
					  attach.setNo(rset.getInt("no"));
					  attach.setBoardCode(rset.getString("board_code"));
					  attach.setOriginalFilename(rset.getString("original_filename"));
					  attach.setRenamedFilename(rset.getString("renamed_filename"));
					  attach.setRegDate(rset.getDate("enroll_date"));
					  board.setAttach(attach); 
					  System.out.println("boardDao board22: "+board);
				  }
				  
				  list.add(board); 
			  }
		  
		  } catch (SQLException e) { 
			  e.printStackTrace(); 
		  } finally { close(rset);
		  	close(pstmt); 
		  } 
		  	return list; 
	  }
	 

	
	  public int selectTotalContents(Connection conn) { PreparedStatement pstmt =
	  null; ResultSet rset = null; String sql =
	  prop.getProperty("selectTotalContents"); int totalContents = 0;
	  
	  try { 
		  pstmt = conn.prepareStatement(sql); rset = pstmt.executeQuery();
		  if(rset.next()) { totalContents = rset.getInt(1); }
	  
	  } catch (SQLException e) { 
		  e.printStackTrace(); 
	  } finally { 
		  close(rset);
		  close(pstmt); 
	  } 
	  
	  return totalContents; }
	 
	//게시글 작성
	public int insertBoard(Connection conn, Board board) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertBoard");
		int result = 0;
//		insertBoard = insert into FIND_ME_BOARD values('01',seq_tb_FIND_ME_no.nextval,?,?,?,
//													    default,?,?,?,?,
//														?,?,?,'N','N',
//														?,?,?,default,?,?)

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getWriter());
			pstmt.setString(3, board.getPhone());
			pstmt.setString(4, board.getGender());
			pstmt.setInt(5, board.getWeight());
			pstmt.setString(6, board.getColor());
			pstmt.setString(7, board.getCharacter());
			pstmt.setDate(8, board.getMissDate());
			pstmt.setString(9, board.getContent());
			pstmt.setString(10, board.getStatus());
			pstmt.setDouble(11, board.getLatitude());
			pstmt.setDouble(12, board.getLongitude());
			pstmt.setString(13, board.getAddress());
			pstmt.setString(14, board.getAnimalType());
			pstmt.setString(15, board.getBreed());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
//			throw new BoardException("게시글 등록 오류", e);
		} finally {
			close(pstmt);
		}

		return result;
	}
	//첨부파일 
	public int insertAttachment(Connection conn, Attachment attach) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAttachment");
//		쿼리문:
//		insertAttachment = insert into attachment values(seq_attachment_no.nextval, ?, ?, DEFAULT, "01", ?)
		int result = 0;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, attach.getOriginalFilename());
			pstmt.setString(2, attach.getRenamedFilename());
			pstmt.setInt(3, attach.getNo());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
//			throw new BoardException("첨부파일 등록 오류", e);
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int selectLastBoardNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectLastBoardNo");
		int boardNo = 0;

		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if (rset.next()) {
				boardNo = rset.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
//			throw new BoardException("게시물번호 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return boardNo;
	}

	public Board selectOneBoard(Connection conn, int no) {
		Board board = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = prop.getProperty("selectOneBoard");
		try{
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setInt(1, no);
			//쿼리문실행
			//완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				board = new Board();
				board.setBoardCode("01");
				board.setNo(rset.getInt("no"));
				board.setTitle(rset.getString("title"));
				board.setWriter(rset.getString("writer"));
				board.setPhone(rset.getString("phone"));
				board.setEnrollDate(rset.getDate("Enroll_Date"));
				board.setGender(rset.getString("gender"));
				board.setWeight(rset.getInt("weight"));
				board.setColor(rset.getString("color"));
				board.setCharacter(rset.getString("character"));
				board.setMissDate(rset.getDate("miss_date"));
				board.setContent(rset.getString("content"));
				board.setStatus(rset.getString("status"));
				board.setDeleteYN(rset.getString("delete_YN"));
				board.setCompleYN(rset.getString("complete_YN"));
				board.setLatitude(rset.getDouble("latitude"));
				board.setLongitude(rset.getDouble("longitude"));
				board.setAddress(rset.getString("address"));
				board.setNoticeYN(rset.getString("notice_YN"));
				board.setAnimalType(rset.getString("animal_type"));
				board.setBreed(rset.getString("breed"));
				board.setAttach(null);
								
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return board;
	}

	public Attachment selectOneAttachmentByBoardNo(Connection conn, int boardNo) {
		Attachment attach = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = prop.getProperty("selectOneAttachmentByBoardNo");
		
		try{
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setInt(1, boardNo);
			//쿼리문실행
			//완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				attach = new Attachment();
				attach.setNo(rset.getInt("no"));
				attach.setBoardCode(rset.getString("board_code"));
				attach.setOriginalFilename(rset.getString("original_filename"));
				attach.setRenamedFilename(rset.getString("renamed_filename"));
				attach.setRegDate(rset.getDate("reg_date"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return attach;
	}

//	public int updateReadCount(Connection conn, int no) {
//		PreparedStatement pstmt = null;
//		String sql = prop.getProperty("updateReadCount");
//		int result = 0;
//		
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, no);
//			
//			result = pstmt.executeUpdate();
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw new BoardException("조회수1증가 오류", e);
//		} finally {
//			close(pstmt);
//		}
//		
//		return result;
//	}

//	public Attachment selectOneAttachment(Connection conn, int no) {
//		Attachment attach = null;
//		PreparedStatement pstmt = null;
//		ResultSet rset = null;
//		
//		String query = prop.getProperty("selectOneAttachment");
//		try{
//			//미완성쿼리문을 가지고 객체생성.
//			pstmt = conn.prepareStatement(query);
//			//쿼리문미완성
//			pstmt.setInt(1, no);
//			//쿼리문실행
//			//완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
//			rset = pstmt.executeQuery();
//			
//			if(rset.next()){
//				attach = new Attachment();
//				attach.setNo(rset.getInt("no"));
//				attach.setBoardNo(rset.getInt("board_no"));
//				attach.setOriginalFilename(rset.getString("original_filename"));
//				attach.setRenamedFilename(rset.getString("renamed_filename"));
//				attach.setRegDate(rset.getDate("reg_date"));
//			}
//		}catch(Exception e){
//			e.printStackTrace();
//		}finally{
//			close(rset);
//			close(pstmt);
//		}
//		return attach;
//	}

//    public int deleteBoard(Connection conn, int no) {
//		int result = 0;
//		PreparedStatement pstmt = null;
//		String query = prop.getProperty("deleteBoard"); 
//		
//		try {
//			//미완성쿼리문을 가지고 객체생성.
//			pstmt = conn.prepareStatement(query);
//			//쿼리문미완성
//			pstmt.setInt(1, no);
//			
//			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
//			//DML은 executeUpdate()
//			result = pstmt.executeUpdate();
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			close(pstmt);
//		}
//
//		
//		return result;
//	}

//	public int updateBoard(Connection conn, Board board) {
//		int result = 0;
//		PreparedStatement pstmt = null;
//		String query = prop.getProperty("updateBoard"); 
//		
//		try {
//			//미완성쿼리문을 가지고 객체생성.
//			pstmt = conn.prepareStatement(query);
//			//쿼리문미완성
//			pstmt.setString(1, board.getTitle());
//			pstmt.setString(2, board.getContent());
//			pstmt.setInt(3, board.getNo());
//			
//			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
//			//DML은 executeUpdate()
//			result = pstmt.executeUpdate();
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			close(pstmt);
//		}
//
//		
//		return result;
//	}
//
//	public int deleteAttachment(Connection conn, int no) {
//		int result = 0;
//		PreparedStatement pstmt = null;
//		String query = prop.getProperty("deleteAttachment"); 
//		try {
//			//미완성쿼리문을 가지고 객체생성.
//			pstmt = conn.prepareStatement(query);
//			//쿼리문미완성
//			pstmt.setInt(1, no);
//			
//			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
//			//DML은 executeUpdate()
//			result = pstmt.executeUpdate();
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			close(pstmt);
//		}
//		return result;
//	}
//
//	public List<BoardComment> selectCommentList(Connection conn, int no) {
//		PreparedStatement pstmt = null;
//		ResultSet rset = null;
//		String sql = prop.getProperty("selectCommentList");
//		List<BoardComment> commentList = new ArrayList<>();
//		
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, no);
//			
//			rset = pstmt.executeQuery();
//			while(rset.next()) {
//				BoardComment bc = new BoardComment();
//				bc.setNo(rset.getInt("no"));
//				bc.setCommentLevel(rset.getInt("comment_level"));
//				bc.setWriter(rset.getString("writer"));
//				bc.setContent(rset.getString("content"));
//				bc.setBoardNo(rset.getInt("board_no"));
//				bc.setCommentRef(rset.getInt("comment_ref"));
//				bc.setRegDate(rset.getDate("reg_date"));
//				commentList.add(bc);
//			}
//			
//		} catch (SQLException e) {
//			throw new BoardException("댓글 조회 오류!", e);
//		} finally {
//			close(rset);
//			close(pstmt);
//		}
//		return commentList;
//	}
//
//	public int insertBoardComment(Connection conn, BoardComment bc) {
//		int result = 0;
//		PreparedStatement pstmt = null;
//		String query = prop.getProperty("insertBoardComment"); 
//		try {
//			//미완성쿼리문을 가지고 객체생성.
//			pstmt = conn.prepareStatement(query);
//			pstmt.setInt(1, bc.getCommentLevel());
//			pstmt.setString(2, bc.getWriter());
//			pstmt.setString(3, bc.getContent());
//			pstmt.setInt(4, bc.getBoardNo());
//			pstmt.setObject(5, bc.getCommentRef() == 0 ? null : bc.getCommentRef());
//			
//			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
//			//DML은 executeUpdate()
//			result = pstmt.executeUpdate();
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw new BoardException("댓글 등록 오류!", e);
//		} finally {
//			close(pstmt);
//		}
//		return result;
//	}
//
//	public int deleteBoardComment(Connection conn, int no) {
//		PreparedStatement pstmt = null;
//		int result = 0;
//		String sql = prop.getProperty("deleteBoardComment");
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, no);
//			result = pstmt.executeUpdate();
//		} catch (SQLException e) {
//			// RuntimeException 오류처리를 쉽게, 현재 업무상황을 잘 설명가능한 커스텀예외로 전환해서 throw
//			throw new BoardException("댓글 삭제 오류", e);
//		} finally {
//			close(pstmt);
//		}
//		return result;
//	}

}
