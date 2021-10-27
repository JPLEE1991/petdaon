package com.petdaon.mvc.serviceBoard.noticeBoard.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class NoticeBoard implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int no;
	private String writer;
	private String title;
	private String content;
	private Date enrollDate;
	private int viewNum;
	private String boardCode;
	
	public NoticeBoard() {
		super();
		// TODO Auto-generated constructor stub
	}

	public NoticeBoard(int no, String writer, String title, String content, Date enrollDate, int viewNum,
			String boardCode) {
		super();
		this.no = no;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.enrollDate = enrollDate;
		this.viewNum = viewNum;
		this.boardCode = boardCode;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public int getViewNum() {
		return viewNum;
	}

	public void setViewNum(int viewNum) {
		this.viewNum = viewNum;
	}

	public String getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
	}

	@Override
	public String toString() {
		return "NoticeBoard [no=" + no + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", enrollDate=" + enrollDate + ", viewNum=" + viewNum + ", boardCode=" + boardCode + "]";
	}
}
