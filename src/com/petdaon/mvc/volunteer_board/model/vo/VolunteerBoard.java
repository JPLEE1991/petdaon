package com.petdaon.mvc.volunteer_board.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class VolunteerBoard implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String title;
	private String centerName;
	private String content;
	private Date startDate;
	private Date endDate;
	private String email;
	private String phone;
	private String approvalYn;
	private String deleteYn;
	private int capacity;
	private String place;
	private Date deadlineDate;
	private Date regDate;
	private String time;
	private String day;
	private String boardCode;
	private String writer;
	private String enrollYn;
	private String thumbnail;
	
	public VolunteerBoard() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VolunteerBoard(int no, String title, String centerName, String content, Date startDate, Date endDate,
			String email, String phone, String approvalYn, String deleteYn, int capacity, String place,
			Date deadlineDate, Date regDate, String time, String day, String boardCode, String writer, String enrollYn,
			String thumbnail) {
		super();
		this.no = no;
		this.title = title;
		this.centerName = centerName;
		this.content = content;
		this.startDate = startDate;
		this.endDate = endDate;
		this.email = email;
		this.phone = phone;
		this.approvalYn = approvalYn;
		this.deleteYn = deleteYn;
		this.capacity = capacity;
		this.place = place;
		this.deadlineDate = deadlineDate;
		this.regDate = regDate;
		this.time = time;
		this.day = day;
		this.boardCode = boardCode;
		this.writer = writer;
		this.enrollYn = enrollYn;
		this.thumbnail = thumbnail;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCenterName() {
		return centerName;
	}

	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getApprovalYn() {
		return approvalYn;
	}

	public void setApprovalYn(String approvalYn) {
		this.approvalYn = approvalYn;
	}

	public String getDeleteYn() {
		return deleteYn;
	}

	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public Date getDeadlineDate() {
		return deadlineDate;
	}

	public void setDeadlineDate(Date deadlineDate) {
		this.deadlineDate = deadlineDate;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
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

	public String getEnrollYn() {
		return enrollYn;
	}

	public void setEnrollYn(String enrollYn) {
		this.enrollYn = enrollYn;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	@Override
	public String toString() {
		return "VolunteerBoard [no=" + no + ", title=" + title + ", centerName=" + centerName + ", content=" + content
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", email=" + email + ", phone=" + phone
				+ ", approvalYn=" + approvalYn + ", deleteYn=" + deleteYn + ", capacity=" + capacity + ", place="
				+ place + ", deadlineDate=" + deadlineDate + ", regDate=" + regDate + ", time=" + time + ", day=" + day
				+ ", boardCode=" + boardCode + ", writer=" + writer + ", enrollYn=" + enrollYn + ", thumbnail="
				+ thumbnail + "]";
	}
	
}
