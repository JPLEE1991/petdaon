package com.petdaon.mvc.volunteer_board.model.vo;

import java.io.Serializable;
import java.sql.Date;

/* Join으로 알수있는 컬럼(아이디로 회원 이름, 휴대폰, 이메일 정보 조회됨) 담은 VO클래스 */
public class VolunteerApplicationExt extends VolunteerApplication implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String memberName;	// 이름
	private String phone;	// 휴대폰
	private String email;	// 이메일
	
	public VolunteerApplicationExt() {
		super();
	}
	
	public VolunteerApplicationExt(int no, String approvalYn, String applicationYn, Date regDate, int boardNo,
			String boardCode, String applicant, String name, String phone, String email) {
		super(no, approvalYn, applicationYn, regDate, boardNo, boardCode, applicant);
		this.memberName = name;
		this.phone = phone;
		this.email = email;
	}

	public String getMemberName() {
		return memberName;
	}
	
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	
	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "VolunteerApplicationExt [name=" + memberName + ", phone=" + phone + ", email=" + email + ", toString()=" + super.toString() + "]";
	}
	
}
