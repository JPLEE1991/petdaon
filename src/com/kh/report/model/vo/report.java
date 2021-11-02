package com.kh.report.model.vo;

import java.sql.Date;

public class report {
	
	private int reportNo;
	private String reportContent;
	private Date reportDate;
	private String reportstatus;
	private String userNo; // userNo 신고한사람
	private String userNo2;// userNo2 신고당한사람
	private int reportPostno;
	private String reportType;
	private int reportPostType;  // 1: 커뮤니티 / 2: 일정 / 3: 댓글
	
	public report() {
		
	}

	public report(int reportNo, String reportContent, Date reportDate, String reportstatus, String userNo,
			String userNo2, int reportPostno, String reportType, int reportPostType) {
		super();
		this.reportNo = reportNo;
		this.reportContent = reportContent;
		this.reportDate = reportDate;
		this.reportstatus = reportstatus;
		this.userNo = userNo;
		this.userNo2 = userNo2;
		this.reportPostno = reportPostno;
		this.reportType = reportType;
		this.reportPostType = reportPostType;
	}

	
	public report(String reportContent, String userNo, String userNo2, int reportPostno, String reportType,
			int reportPostType) {
		super();
		this.reportContent = reportContent;
		this.userNo = userNo;
		this.userNo2 = userNo2;
		this.reportPostno = reportPostno;
		this.reportType = reportType;
		this.reportPostType = reportPostType;
	}
	

	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	public String getReportstatus() {
		return reportstatus;
	}

	public void setReportstatus(String reportstatus) {
		this.reportstatus = reportstatus;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getUserNo2() {
		return userNo2;
	}

	public void setUserNo2(String userNo2) {
		this.userNo2 = userNo2;
	}

	public int getReportPostno() {
		return reportPostno;
	}

	public void setReportPostno(int reportPostno) {
		this.reportPostno = reportPostno;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public int getReportPostType() {
		return reportPostType;
	}

	public void setReportPostType(int reportPostType) {
		this.reportPostType = reportPostType;
	}

	@Override
	public String toString() {
		return "Report [reportNo=" + reportNo + ", reportContent=" + reportContent + ", reportDate=" + reportDate
				+ ", reportstatus=" + reportstatus + ", userNo=" + userNo + ", userNo2=" + userNo2 + ", reportPostno="
				+ reportPostno + ", reportType=" + reportType + ", reportPostType=" + reportPostType + "]";
	}


}