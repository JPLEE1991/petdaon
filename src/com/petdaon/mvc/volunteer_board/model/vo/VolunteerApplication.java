package com.petdaon.mvc.volunteer_board.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class VolunteerApplication implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;					// 신청번호
	private String approvalYn;		// 봉사신청 승인여부
	private String applicationYn;	// 봉사신청상태
	private Date regDate;			// 봉사신청등록일
	private int boardNo;			// 봉사게시글번호
	private String boardCode;		// 게시판코드
	private String applicant;		// 신청자아이디
	
	public VolunteerApplication() {
		super();
	}

	public VolunteerApplication(int no, String approvalYn, String applicationYn, Date regDate, int boardNo,
			String boardCode, String applicant) {
		super();
		this.no = no;
		this.approvalYn = approvalYn;
		this.applicationYn = applicationYn;
		this.regDate = regDate;
		this.boardNo = boardNo;
		this.boardCode = boardCode;
		this.applicant = applicant;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getApprovalYn() {
		return approvalYn;
	}

	public void setApprovalYn(String approvalYn) {
		this.approvalYn = approvalYn;
	}

	public String getApplicationYn() {
		return applicationYn;
	}

	public void setApplicationYn(String applicationYn) {
		this.applicationYn = applicationYn;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
	}

	public String getApplicant() {
		return applicant;
	}

	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}

	@Override
	public String toString() {
		return "VolunteerApplication [no=" + no + ", approvalYn=" + approvalYn + ", applicationYn=" + applicationYn
				+ ", regDate=" + regDate + ", boardNo=" + boardNo + ", boardCode=" + boardCode + ", applicant="
				+ applicant + "]";
	}
	
}
