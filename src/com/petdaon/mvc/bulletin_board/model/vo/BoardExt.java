package com.petdaon.mvc.bulletin_board.model.vo;

import java.io.Serializable;
import java.sql.Date;

import com.petdaon.mvc.common.vo.Attachment;


public class BoardExt extends BulletinBoard implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int boardCommentCount;

	public BoardExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BoardExt(int no, String title, String writer, String content, Date regDate, int readCount, Attachment attach, int boardCommentCount) {
		super();
		this.boardCommentCount = boardCommentCount;
	}

	public int getBoardCommentCount() {
		return boardCommentCount;
	}

	public void setBoardCommentCount(int boardCommentCount) {
		this.boardCommentCount = boardCommentCount;
	}

	@Override
	public String toString() {
		return "BoardExt [boardCommentCount=" + boardCommentCount + ", toString()=" + super.toString() + "]";
	}

	
	

}
