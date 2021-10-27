package com.petdaon.mvc.serviceBoard.askBoard.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class AskBoard implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int inquiryNo;
	private String boardCode;
	private String writer;
	private String status;
	private String inquiryTitle;
	private String inquiryContent;
	private Date enrollDate;
	private String answer;
	private Date answerDate;
	private String adminId;
	
	public AskBoard() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AskBoard(int inquiryNo, String boardCode, String writer, String status, String inquiryTitle,
			String inquiryContent, Date enrollDate, String answer, Date answerDate, String adminId) {
		super();
		this.inquiryNo = inquiryNo;
		this.boardCode = boardCode;
		this.writer = writer;
		this.status = status;
		this.inquiryTitle = inquiryTitle;
		this.inquiryContent = inquiryContent;
		this.enrollDate = enrollDate;
		this.answer = answer;
		this.answerDate = answerDate;
		this.adminId = adminId;
	}

	public int getInquiryNo() {
		return inquiryNo;
	}

	public void setInquiryNo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	}

	public String getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getInquiryTitle() {
		return inquiryTitle;
	}

	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	}

	public String getInquiryContent() {
		return inquiryContent;
	}

	public void setInquiryContent(String inquiryContent) {
		this.inquiryContent = inquiryContent;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Date getAnswerDate() {
		return answerDate;
	}

	public void setAnswerDate(Date answerDate) {
		this.answerDate = answerDate;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	@Override
	public String toString() {
		return "AskBoard [inquiryNo=" + inquiryNo + ", boardCode=" + boardCode + ", writer=" + writer + ", status="
				+ status + ", inquiryTitle=" + inquiryTitle + ", inquiryContent=" + inquiryContent + ", enrollDate="
				+ enrollDate + ", answer=" + answer + ", answerDate=" + answerDate + ", adminId=" + adminId + "]";
	}	
}
