package com.petdaon.mvc.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Member implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String memberId;
	private String password;
	private String memberName;
	private String memberRole;
	private Date birthday;
	private String email;
	private String phone;
	private Date enroll_date;
	private String status;
	private String warning_count;
	private String photo;
	private Date quit_date;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Member(String memberId, String password, String memberName, String memberRole, Date birthday, String email,
			String phone, Date enroll_date, String status, String warning_count, String photo, Date quit_date) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.memberName = memberName;
		this.memberRole = memberRole;
		this.birthday = birthday;
		this.email = email;
		this.phone = phone;
		this.enroll_date = enroll_date;
		this.status = status;
		this.warning_count = warning_count;
		this.photo = photo;
		this.quit_date = quit_date;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberRole() {
		return memberRole;
	}

	public void setMemberRole(String memberRole) {
		this.memberRole = memberRole;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
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

	public Date getEnroll_date() {
		return enroll_date;
	}

	public void setEnroll_date(Date enroll_date) {
		this.enroll_date = enroll_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getWarning_count() {
		return warning_count;
	}

	public void setWarning_count(String warning_count) {
		this.warning_count = warning_count;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Date getQuit_date() {
		return quit_date;
	}

	public void setQuit_date(Date quit_date) {
		this.quit_date = quit_date;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", password=" + password + ", memberName=" + memberName
				+ ", memberRole=" + memberRole + ", birthday=" + birthday + ", email=" + email + ", phone=" + phone
				+ ", enroll_date=" + enroll_date + ", status=" + status + ", warning_count=" + warning_count
				+ ", photo=" + photo + ", quit_date=" + quit_date + "]";
	} 
	
	
	
}
