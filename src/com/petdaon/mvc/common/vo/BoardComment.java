package com.petdaon.mvc.common.vo;

import java.io.Serializable;
import java.sql.Date;

public class BoardComment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;				// 댓글번호
	private String writer;		// 댓글 작성자
	private int commentLevel;	// 댓글 1, 대댓글 2
	private String content;		// 댓글내용
	private int commentRef;		// 댓글 null, 대댓글인 경우 부모댓글번호 no
	private Date regDate;		// 댓글 작성일
	private String deleteYn;	// 삭제여부(Y/N)
	private String boardCode;	// 게시판코드
	private int boardNo;		// 게시글번호
	
	public BoardComment() {
		super();
	}

	public BoardComment(int no, String writer, int commentLevel, String content, int commentRef, Date regDate,
			String deleteYn, String boardCode, int boardNo) {
		super();
		this.no = no;
		this.writer = writer;
		this.commentLevel = commentLevel;
		this.content = content;
		this.commentRef = commentRef;
		this.regDate = regDate;
		this.deleteYn = deleteYn;
		this.boardCode = boardCode;
		this.boardNo = boardNo;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getCommentLevel() {
		return commentLevel;
	}

	public void setCommentLevel(int commentLevel) {
		this.commentLevel = commentLevel;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getCommentRef() {
		return commentRef;
	}

	public void setCommentRef(int commentRef) {
		this.commentRef = commentRef;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getDeleteYn() {
		return deleteYn;
	}

	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}

	public String getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	@Override
	public String toString() {
		return "BoardComment [no=" + no + ", writer=" + writer + ", commentLevel=" + commentLevel + ", content="
				+ content + ", commentRef=" + commentRef + ", regDate=" + regDate + ", deleteYn=" + deleteYn
				+ ", boardCode=" + boardCode + ", boardNo=" + boardNo + "]";
	}

}
