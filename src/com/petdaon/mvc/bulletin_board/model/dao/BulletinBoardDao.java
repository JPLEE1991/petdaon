package com.petdaon.mvc.bulletin_board.model.dao;



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

import com.petdaon.mvc.bulletin_board.model.exception.BulletinBoardException;
import com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard;
import com.petdaon.mvc.common.vo.Attachment;

public class BulletinBoardDao {
    
    private Properties prop = new Properties();
    
    /**
     * prop객체에 buildpath로 배포된  /sql/bulletin_board/board-query.properties 불러오기
     */
    public BulletinBoardDao() {
        String filepath = BulletinBoardDao.class.getResource("/sql/bulletin_board/bulletin_board-query.properties").getPath();
        
        System.out.println("BulletinBoard filepath: " + filepath);
        try {
            prop.load(new FileReader(filepath));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<BulletinBoard> selectBoardList(Connection conn, int start, int end) {
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        String sql = prop.getProperty("selectBoardList");
        List<BulletinBoard> list = new ArrayList<>();
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start);
            pstmt.setInt(2, end);
            
            rset = pstmt.executeQuery();
            
            while(rset.next()) {
                BulletinBoard board = new BulletinBoard();
                board.setNo(rset.getInt("no"));
                board.setWriter(rset.getString("writer"));
                board.setTitle(rset.getString("title"));
                board.setContent(rset.getString("content"));
                board.setRegDate(rset.getDate("enroll_date"));
                board.setReadCount(rset.getInt("scrap_num"));
                board.setScrapCount(rset.getInt("scrap_num"));
                board.setLikeCount(rset.getInt("like_num"));
                board.setAnimal(rset.getString("animal_type"));
                board.setDetail(rset.getString("detail"));
                board.setCategory(rset.getString("category"));
                board.setDelete(rset.getString("delete_yn"));
                board.setNotice(rset.getString("notice_yn"));
                
                if(rset.getInt("attach_no") != 0) {
                	Attachment attach = new Attachment();
                	attach.setNo(rset.getInt("attach_no"));
                	attach.setBoardCode(rset.getString("board_code"));
                	attach.setOriginalFilename(rset.getString("original_filename"));
                	attach.setRenamedFilename(rset.getString("renamed_filename"));
                	attach.setRegDate(rset.getDate("attach_reg_date"));
                	
                	board.setAttach(attach);
                }
                
                list.add(board);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rset);
            close(pstmt);
        }
        
        return list;
    }


    public int insertBoard(Connection conn, BulletinBoard board) {
        PreparedStatement pstmt = null;
        String sql = prop.getProperty("insertBoard");
        int result = 0;
        System.out.println("@BulletinBoardDao board.getWriter() "+board.getWriter());
        try {
        	
        	
            pstmt = conn.prepareStatement(sql);
        	pstmt.setString(1, board.getWriter());
            pstmt.setString(2, board.getTitle());
            pstmt.setString(3, board.getContent());
            pstmt.setString(4, board.getAnimal());
            pstmt.setString(5, board.getDetail());
            pstmt.setString(6, board.getCategory());
            
            result = pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new BulletinBoardException("게시글 등록 오류", e);
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
            if(rset.next()) {
                boardNo = rset.getInt(1);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new BulletinBoardException("게시글번호 조회 오류", e);
        } finally {
            close(rset);
            close(pstmt);
        }
        return boardNo;
    }

    public int insertAttachment(Connection conn, Attachment attach) {
        PreparedStatement pstmt = null;
        String sql = prop.getProperty("insertAttachment");
        int result = 0;
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, attach.getOriginalFilename());
            pstmt.setString(2, attach.getRenamedFilename());
            pstmt.setInt(3, attach.getNo());
            
            result = pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new BulletinBoardException("첨부파일 등록 오류", e);
        } finally {
            close(pstmt);
        }
        
        return result;
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

	public BulletinBoard selectOneBoard(Connection conn, int no) {
		BulletinBoard board = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = prop.getProperty("selectOneBoard");
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				board = new BulletinBoard();
				board.setNo(rset.getInt("no"));
				board.setWriter(rset.getString("writer"));
				board.setTitle(rset.getString("title"));
				board.setContent(rset.getString("content"));
				board.setRegDate(rset.getDate("enroll_date"));
				board.setReadCount(rset.getInt("view_num"));
				board.setScrapCount(rset.getInt("scrap_num"));
				board.setLikeCount(rset.getInt("like_num"));
				board.setAnimal(rset.getString("animal_type"));
				board.setDetail(rset.getString("detail"));
				board.setCategory(rset.getString("category"));
				board.setDelete(rset.getString("delete_yn"));
				board.setNotice(rset.getString("notice_yn"));
				board.setAttach(null);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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

	public int updateReadCount(Connection conn, int no) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateReadCount");
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new BulletinBoardException("조회수가1증가 오류", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public Attachment selectOneAttachment(Connection conn, int no) {
		Attachment attach = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = prop.getProperty("selectOneAttachment");
		
		try{
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setInt(1, no);
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

	public int deleteBoard(Connection conn, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("deleteBoard"); 
		
		try {
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setInt(1, no);
			
			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			//DML은 executeUpdate()
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		
		return result;
	}

	public int updateBoard(Connection conn, BulletinBoard board) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("updateBoard"); 
		
		try {
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getAnimal());
			pstmt.setString(4, board.getDetail());
			pstmt.setString(5, board.getCategory());
			pstmt.setInt(6, board.getNo());
			
			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			//DML은 executeUpdate()
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		
		return result;
	}

	public int deleteAttachment(Connection conn, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("deleteAttachment"); 
		try {
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setInt(1, no);
			
			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			//DML은 executeUpdate()
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
    
	
	
	
	
}